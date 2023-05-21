#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/types.h"
#include <stdbool.h>

#define MAX_ALLOC_SIZE 512

typedef struct header {
    uint len;           // buffer len
    uint remaining;     // remaining free bytes in memory
    struct header* prev;
} header;

header* stack_top = 0;

void* ustack_malloc(uint len);
int ustack_free();

void test_assert(bool condition, const char* message)
{
    if (!condition)
    {
        printf("Test failed: %s\n", message);
        exit(1);
    }
}

// NOTE!
// THE TESTS AREN'T INDEPENDENT - ALL MEMORY IS FREED IN THE LAST TEST

void test_ustack_malloc_single_allocation()
{
    void* buffer = ustack_malloc(100);
    test_assert(buffer != (header*) -1, "Failed to allocate buffer.");
}

void test_ustack_malloc_multiple_allocations()
{
    void* buffer1 = ustack_malloc(100);
    test_assert(buffer1 != (header*) -1, "Failed to allocate buffer1.");

    void* buffer2 = ustack_malloc(MAX_ALLOC_SIZE);
    test_assert(buffer2 != (header*) -1, "Failed to allocate buffer2.");
}

void test_ustack_free_last_allocation()
{
    void* buffer1 = ustack_malloc(100);
    test_assert(buffer1 != (header*) -1, "Failed to allocate buffer1.");

    int freedSize = ustack_free();
    test_assert(freedSize == 100, "Incorrect freed size.");

    void* buffer2 = ustack_malloc(MAX_ALLOC_SIZE);
    test_assert(buffer2 != (header*) -1, "Failed to allocate buffer2.");
}

void test_ustack_clear_memory_on_last_free()
{
    void* buffer1 = ustack_malloc(MAX_ALLOC_SIZE);
    test_assert(buffer1 != (header*) -1, "Failed to allocate buffer1.");

    int freedSize = ustack_free();
    test_assert(freedSize == MAX_ALLOC_SIZE, "Incorrect freed size.");

    void* buffer2 = ustack_malloc(MAX_ALLOC_SIZE);
    test_assert(buffer2 != (header*) -1, "Failed to allocate buffer2.");
}

void test_ustack_multiple_page_alloc_and_free()
{
    for(int i = 0; i<10; i++) {
        void* buffer = ustack_malloc(MAX_ALLOC_SIZE);
        test_assert(buffer != (header*) -1, "Failed to allocate buffer.");
    }
    for(int i=0; i<16; i++) {
        test_assert(ustack_free() != 0, "free failed");
    }
    test_assert(ustack_free() == -1, "last free failed");
}


int main()
{
    // Run the tests
    test_ustack_malloc_single_allocation();
    test_ustack_malloc_multiple_allocations();
    test_ustack_free_last_allocation();
    test_ustack_clear_memory_on_last_free();
    test_ustack_multiple_page_alloc_and_free();

    printf("All tests passed!\n");
    return 0;
}