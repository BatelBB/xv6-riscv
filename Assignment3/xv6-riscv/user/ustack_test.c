#include "ustack.h"
#include "kernel/types.h"
#include "user.h"

void print_test_result(char *test_name, int passed) {
    printf("%s: %s\n", test_name, passed ? "PASSED" : "FAILED");
}

void test_allocation_and_deallocation() {
    // Allocate a block of 100 bytes.
    void *block1 = ustack_malloc(100);
    // Check that the allocation succeeded.
    print_test_result("Test allocation of 100 bytes", block1 != (void *)-1);

    // Allocate a block of 200 bytes.
    void *block2 = ustack_malloc(200);
    // Check that the allocation succeeded.
    print_test_result("Test allocation of 200 bytes", block2 != (void *)-1);

    // Try to allocate a block larger than the limit.
    void *block3 = ustack_malloc(600);
    // Check that the allocation failed.
    print_test_result("Test allocation of 600 bytes", block3 == (void *)-1);

    // Free the most recently allocated block (200 bytes).
    int freed_size = ustack_free();
    // Check that the freed size is correct.
    print_test_result("Test deallocation of 200 bytes", freed_size == 200);

    // Free the remaining block (100 bytes).
    freed_size = ustack_free();
    // Check that the freed size is correct.
    print_test_result("Test deallocation of 100 bytes", freed_size == 100);

    // Try to free when no blocks are allocated.
    freed_size = ustack_free();
    // Check that the free operation failed.
    print_test_result("Test deallocation when no blocks allocated", freed_size == -1);
}

int main() {
    test_allocation_and_deallocation();
    exit(0);
}
