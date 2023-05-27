#include "ustack.h"

int main() {
    char *arr[160];
    for (int i = 0; i < 160; i++) {
        printf("Writing: %d\n", i);
        arr[i] = ustack_malloc(512);
        for (int j = 0; j < 512; j++) {
            arr[i][j] = i;
        }
    }
    for (int i = 0; i < 160; i++) {
        printf("Testing: %d\n", i);
        for (int j = 0; j < 512; j++) {
            if (arr[i][j] != i) {
                printf("Error!\n");
                exit(0);
            }
        }
    }
    for (int i = 0; i < 160; i++) {
        printf("Freeing: %d\n", i);
        ustack_free();
    }
    for (int i = 0; i < 80; i++) {
        printf("Writing: %d\n", i);
        arr[i] = ustack_malloc(512);
        for (int j = 0; j < 512; j++) {
            arr[i][j] = i;
        }
    }
    if (fork()) {
        sleep(10);
    }
    for (int i = 0; i < 80; i++) {
        printf("Testing: %d\n", i);
        for (int j = 0; j < 512; j++) {
            if (arr[i][j] != i) {
                printf("Error!\n");
                exit(0);
            }
        }
    }
    for (int i = 0; i < 80; i++) {
        printf("Freeing: %d\n", i);
        ustack_free();
    }
    exit(0);
}