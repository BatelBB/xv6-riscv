#include "uthread.h"
#include "user.h"
#include "kernel/param.h"

struct uthread uthreads[MAX_UTHREADS];
struct uthread *currentThread;

void call_exit(void (*start_func)()) {
  start_func();
  uthread_exit();
}



int uthread_create(void (*start_func)(), enum sched_priority priority)
{
    int i;

    for (i = 0; i < MAX_UTHREADS; i++)
    {
        if (uthreads[i].state == FREE)
            break;
    }     

    if (i == MAX_UTHREADS)
        return -1;

    uthreads[i].context.ra = (uint64)call_exit;
    uthreads[i].context.sp = (uint64)(&uthreads[i].ustack[STACK_SIZE]);
    uthreads[i].context.sp += sizeof(uint64);
    *((uint64 *)uthreads[i].context.sp) = (uint64)start_func;
    uthreads[i].state = RUNNABLE;
    uthreads[i].priority = priority;
    currentThread = &uthreads[i];

    return 0;
}


void uthread_yield()
{
struct uthread *prevThread = currentThread;

  int threadDifference = currentThread - uthreads + 1;
  int nextIndex = threadDifference % MAX_UTHREADS;

  while (uthreads[nextIndex].state != RUNNABLE) {
    nextIndex = (nextIndex + 1) % MAX_UTHREADS;
  }
  currentThread = &uthreads[nextIndex];
  uswtch(&prevThread->context, &currentThread->context); 
}

void uthread_exit()
{
  currentThread->state = FREE;
  int remainingThreads = 0;
  for (int i = 0; i < MAX_UTHREADS; i++) {
    if (uthreads[i].state == RUNNABLE) 
      remainingThreads++;
  }

  if (remainingThreads == 0) 
    exit(0);
  else 
    uthread_yield();
}

enum sched_priority uthread_set_priority(enum sched_priority priority)
{
    enum sched_priority prevPriority = currentThread->priority;
  currentThread->priority = priority;
  return prevPriority;
}

enum sched_priority uthread_get_priority()
{
    return currentThread->priority;
}

int uthreadStarted = 0;

int uthread_start_all() {
  if (uthreadStarted) {
    return -1;
  }
  uthreadStarted = 1;

  int firstRunnableThread = -1;
  for (int i = 0; i < MAX_UTHREADS; i++) {
    if (uthreads[i].state == RUNNABLE) {
      firstRunnableThread = i;
      break;
    }
  }

  if (firstRunnableThread == -1) 
    return -1; 
  

  currentThread = &uthreads[firstRunnableThread];

  struct context dummyContext;
  printf("inside start all\n");
  uswtch(&dummyContext, &currentThread->context);

  return -1;
}


struct uthread *uthread_self()
{
    return currentThread;
}