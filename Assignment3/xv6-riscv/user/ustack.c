#include "ustack.h"

struct header{
  struct header *prev;
  uint size;
  void* start;
};

typedef struct header Header;

uint page_top = 0;
uint stack_last_addr = 0;
Header* cur = 0;

Header* get_more(){
    Header *new = (Header*)sbrk(PGSIZE);
    if(new == (void*)-1){
        return (Header*)-1;
    }
    page_top = PGROUNDUP((uint64)cur->start);
    return new;
}

void * ustack_malloc(uint len){
    if (len > 512){
        return (void *)-1;
    }

    if (stack_last_addr == 0){
        cur = get_more();
        cur->prev = 0;
        cur->size = 0;
        cur->start = (void*)(cur + 1);
    }

    Header* next;
    if((uint64)cur->start + (uint)cur->size + (uint)len > (uint)page_top){
        next = get_more();
    }
    else{
        next = (Header*)(cur->start + cur->size); 
    }

    next->prev = cur;
    next->start = (void*)(next + 1);
    next->size = len;
    cur = next;
    
    return (void*)cur->start;

}


int ustack_free(void){
    //check invalid
    if (cur == 0){
        return -1;
    }

    //delete cur and set cur to cur.prev
    int ret = cur->size;
    cur = cur->prev;

    //check if need to change page_top
    if(PGROUNDUP((uint64)cur) == PGROUNDDOWN(page_top)){
        if(sbrk(-PGSIZE) == (char*)-1){
            return -1;
        }

        page_top = PGROUNDUP((uint64)cur);
    }

    return ret;
}
