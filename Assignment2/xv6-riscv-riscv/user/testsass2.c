#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/param.h"
#include "user/user.h"
#include "user/uthread.h"

void f1() {
    fork();
    fork();
    printf("0");
    kthread_exit(0);
}

void f2() {
    printf("0");
    sleep(1);
    exit(0);
}

void f3() {
    if (fork()) {
        wait(0);
        printf("0");
        kthread_exit(0);
    }
    else {
        sleep(5);
        exit(0);
    }
}

void f4() {
    int pid = fork();
    if (pid) {
        kill(pid);
        wait(0);
        printf("0");
        kthread_exit(0);
    }
    else {
        sleep(1);
        printf("1");
    }
}

void f5() {
    char *argv[] = {"ls", 0};
    exec("ls", argv);
    printf("0");
}

void f6() {
    char *argv[] = {"asdf", 0};
    exec("asdf", argv);
    printf("0");
    kthread_exit(0);
}

void f7() {
    int pid = fork();
    if (pid) {
        kill(pid);
        sleep(5);
        wait(0);
        printf("0");
        kthread_exit(0);
    }
    else {
        sleep(1000);

    }
}

void f8() {
    if (kthread_id() == 2) {
        kthread_kill(3);
        kthread_join(3, 0);
        printf("2");
        kthread_exit(0);
    }
    else {
        kthread_kill(2);
        kthread_join(2, 0);
        printf("3");
        kthread_exit(0);
    }
}

void f9() {
    if (kthread_id() == 2) {
        kthread_kill(3);
        kthread_join(3, 0);
        printf("2");
        kthread_exit(0);
    }
    else {
        sleep(1000);
        kthread_kill(2);
        kthread_join(2, 0);
        printf("3");
        kthread_exit(0);
    }
}

void (*ptr)() = f1;

void create() {
    uint64 stack1 = (uint64)malloc(MAX_STACK_SIZE);
    uint64 stack2 = (uint64)malloc(MAX_STACK_SIZE);
    kthread_create(ptr, stack1, MAX_STACK_SIZE);
    kthread_create(ptr, stack2, MAX_STACK_SIZE);
    sleep(10);
    printf("\n");
    exit(0);
}

int main() {;
    create();
    exit(0);
}