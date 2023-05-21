#include "ustack.h"

struct header {
    struct header *prev;
    uint size;
};

typedef struct header Header;

Header *head = 0;
void *page_top = 0;

Header *get_more(uint size) {
    Header *new_block = (Header *)sbrk(size);
    if (new_block == (void *)-1) {
        return (Header *)-1;
    }
    page_top = sbrk(0); //returns a pointer to the end of the current data segment
    return new_block;
}

void *ustack_malloc(uint len) {
    if (len > 512) 
        return (void *)-1;

    uint total_size = sizeof(Header) + len; // sizeof(Header) = (uint64)cur->start + (uint)cur->size
    Header *new_block = 0;
    if ((char *)sbrk(0) + total_size > (char *)page_top) {
        new_block = get_more(total_size);
    } else {
        new_block = (Header *)sbrk(total_size);
    }

    if (new_block == (void *)-1) return (void *)-1;

    new_block->prev = head;
    new_block->size = len;
    head = new_block;

    return (void *)(new_block + 1);
}

int ustack_free(void) {
	//check invalid
    if (head == 0)
     return -1;

	//delete cur and set cur to cur.prev
    uint block_size = head->size;
    head = head->prev;

	//check if need to change page_top
    if ((char *)sbrk(0) - (block_size + sizeof(Header)) <= (char *)page_top - PGSIZE) {
        sbrk(-PGSIZE);
        page_top = sbrk(0);
    }

    return block_size;
}
