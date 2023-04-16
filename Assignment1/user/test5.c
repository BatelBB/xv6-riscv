#include "kernel/types.h"
#include "user/user.h"

int find_prime(int n) {
    int found = 0;
    int candidate;
    char ok;
    for (candidate = 2; found < n; candidate++) {
        ok = 1;
        for (int divisor = 2; ok && divisor < candidate; divisor++) {
            ok = (candidate % divisor) != 0;
        }
        found += ok;
        if (found >= n) {
            return candidate;
        }
    }
    return 0;
}

int main() {
    int n = 5000;
    int prime;
    if (fork()) {
        fork();
        fork();
        fork();
        set_ps_priority(10);
        prime = find_prime(n);
        printf("Father\n");
    }
    else {
        fork();
        fork();
        fork();
        set_ps_priority(1);
        prime = find_prime(n);
        printf("Son\n");
    }
    exit(prime, "");
}