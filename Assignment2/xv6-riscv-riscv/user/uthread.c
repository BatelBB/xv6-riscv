#include "uthread.h"
#include "user.h"
#include "kernel/param.h"

struct uthread uthreads[MAX_UTHREADS];
struct uthread *currentThread;
int ids = 0;

void call_exit(void (*start_func)()) {
  
  start_func();
  printf("call_exit: hello\n");
  uthread_exit();
}



int uthread_create(void (*start_func)(), enum sched_priority priority)
{
    int i;
    ids ++;

    for (i = 0; i < MAX_UTHREADS; i++)
    {
        if (uthreads[i].state == FREE)
            break;
    }     

    if (i == MAX_UTHREADS)
        return -1;

    uthreads[i].context.ra = (uint64)start_func;
    uthreads[i].context.sp = (uint64)(&uthreads[i].ustack[STACK_SIZE]);
    uthreads[i].context.sp += sizeof(uint64);
    uthreads[i].state = RUNNABLE;
    uthreads[i].priority = priority;
    currentThread = &uthreads[i];

    currentThread->pid = ids;

    return 0;
}


void uthread_yield()
{
  // if(currentThread->state == RUNNING)
  currentThread->state = RUNNABLE;
  schedule();

}


char* get_state(enum tstate s){
  switch (s)
  {
  case FREE:
    return "FREE";
  case  RUNNING:
    return "RUNNING";
  case RUNNABLE:
    return "RUNNABLE";
  }

  return "ERROR";
}


void schedule(){
  struct uthread *cur; 

  


  cur = currentThread;
  int i;
  int j;
  j = (currentThread - uthreads + 1) % MAX_UTHREADS;
  
  

  for(i = 0; i < MAX_UTHREADS; i++){
    if(uthreads[j].state == RUNNABLE || uthreads[j].state == RUNNING)
      break;
    j = (j+1) % MAX_UTHREADS;    
  }

  if(!(uthreads[j].state == RUNNABLE || uthreads[j].state == RUNNING)){
    exit(-1);
  }

  currentThread = &uthreads[j];
  currentThread->state = RUNNING;

  uswtch(&cur->context, &uthreads[j].context);
  
}







void uthread_exit()
{
  currentThread->state = FREE;
  int remainingThreads = 0;
  for (int i = 0; i < MAX_UTHREADS; i++) {
    if (uthreads[i].state == RUNNABLE) 
      remainingThreads++;
  }


  if (remainingThreads == 0){
    exit(0);
  }
  else 
  {
    schedule();
  }
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
  uswtch(&dummyContext, &currentThread->context);

  return -1;
}


struct uthread *uthread_self()
{
    return currentThread;
}