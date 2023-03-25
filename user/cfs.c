#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"


#define N_ITERATIONS 1000000
#define SLEEP_INTERVAL 100000

void child_loop(int priority) {
  int i;
  uint start_time, end_time;

  setpriority(priority); // Sets the priority of the current process
  start_time = uptime(); // Record the start time

  for (i = 0; i < N_ITERATIONS; i++) {
    if (i % SLEEP_INTERVAL == 0) {
      sleep(1);
    }
  }

  end_time = uptime(); // Record the end time

  printf(1, "PID: %d, Priority: %d, Run ti me: %d, Sleep time: %d,Runnable time: %d\n",
         getpid(), priority, end_time - start_time, N_ITERATIONS / SLEEP_INTERVAL, end_time - start_time);
}



int
main(int argc, char *argv[])
{

  int pid;

  for (int priority = 0; priority < 3; priority++) {
    pid = fork();
    if (pid < 0) {
      exit(1, "failed");
    } else if (pid == 0) {
      child_loop(priority);
    }
  }

  for (int i = 0; i < 3; i++) {
    wait(1, "waiting");
  }



    exit(0, "good");
}