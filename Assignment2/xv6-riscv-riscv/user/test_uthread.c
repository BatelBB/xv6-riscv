#include "uthread.h"
#include "user.h"

void print_low() {
  for (int i = 0; i < 5; i++) {
    printf("Low priority thread\n");
    uthread_yield();
  }
  uthread_exit();
}

void print_medium() {
  for (int i = 0; i < 5; i++) {
    printf("Medium priority thread\n");
    uthread_yield();
  }
  uthread_exit();
}

void print_high() {
  for (int i = 0; i < 5; i++) {
    printf("High priority thread\n");
    uthread_yield();
  }
  uthread_exit();
}

int main() {
  uthread_create(print_low, LOW);
  uthread_create(print_medium, MEDIUM);
  uthread_create(print_high, HIGH);

  uthread_start_all();

  // This point should never be reached
  return 0;
}