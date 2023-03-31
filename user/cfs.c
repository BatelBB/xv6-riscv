#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"


#define N_ITERATIONS 1000000
#define SLEEP_INTERVAL 100000

void child_loop(int priority) {
  int i;
  //uint start_time, end_time;

  // printf("1111111111\n");

  set_cfs_priority(priority); // Sets the priority of the current process


  //start_time = uptime(); // Record the start time

  for (i = 0; i < N_ITERATIONS; i++) {
    if (i % SLEEP_INTERVAL == 0) {
      sleep(1);
    }
  }

  //end_time = uptime(); // Record the end time

  
  int *rtime=malloc(sizeof(int));
  int *stime=malloc(sizeof(int));
  int *retime=malloc(sizeof(int));
  int *priority2=malloc(sizeof(int));

  get_cfs_stats(getpid(), priority2, rtime, stime, retime);
  printf("PID: %d, Priority: %d, Run time: %d, Sleep time: %d, Runnable time: %d\n",
          getpid(), *priority2, *rtime, *stime, *retime);

  //  printf("PID: %d, Priority: %d, Run time: %d, Sleep time: %d, Runnable time: %d\n",
  //         getpid(), priority, end_time - start_time, N_ITERATIONS / SLEEP_INTERVAL, end_time - start_time);
}



int
main(int argc, char *argv[])
{
  int pid;

  for (int priority = 0; priority < 3; priority++) {
    pid = fork();
    // printf("%d pid\n", pid);
    // char nice = pid + '0';
    // write(1, &nice, 4);

    if (pid < 0) {
      exit(1, "failed");
    } else if (pid == 0) {
      child_loop(priority);
      exit(0, "child ended");
    }
  }

  for (int i = 0; i < 3; i++) {
    wait(0, "waiting");
  }



    exit(0, "good");
}