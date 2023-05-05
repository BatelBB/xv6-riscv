#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "riscv.h"
#include "spinlock.h"
#include "proc.h"
#include "defs.h"


extern struct proc proc[NPROC];



void kthreadinit(struct proc *p)
{
  initlock(&p->thread_lock, "thread_lock");
  // acquire(&p->thread_lock);

  for (struct kthread *kt = p->kthread; kt < &p->kthread[NKT]; kt++)
  {
    initlock(&kt->lock, "kthread lock");
    kt->state = KUNUSED;
    kt->pcb = p;

    // WARNING: Don't change this line!
    // get the pointer to the kernel stack of the kthread
    kt->kstack = KSTACK((int)((p - proc) * NKT + (kt - p->kthread)));
  }
  // release(&p->thread_lock);
}

struct kthread *mykthread()
{
  push_off();
  struct kthread* kt;
  if(mycpu()->thread == 0)
    kt = 0;
  else
    kt = mycpu()->thread; 
  pop_off();
  
  return kt;
}

int alloc_thread_id(struct proc *p){
  acquire(&p->thread_lock);
  int next = p->counter;
  p->counter ++;
  release(&p->thread_lock);
  return next;
}

struct kthread* alloc_thread(struct proc *p){
  // acquire(&p->lock);
  for (struct kthread *kt = p->kthread; kt < &p->kthread[NKT]; kt++)
  {
    if(kt->state == KUNUSED){
      acquire(&kt->lock);
      kt->tid = alloc_thread_id(p);
      kt->state = KUSED;
      kt->trapframe = get_kthread_trapframe(p, kt);
      memset(&kt->context, 0, sizeof(kt->context));
      kt->context.ra = (uint64)forkret;
      kt->context.sp = (uint64)kt->kstack + PGSIZE;

      // release(&p->lock);
      return kt;
    }
  }

  // release(&p->lock);
  return 0;
}

void free_thread(struct kthread* kt){
  if(kt != 0){
    acquire(&kt->lock);
    kt->trapframe = 0;
    kt->state = KUNUSED;
    kt->chan = 0;
    kt->tid = 0;
    kt->killed = 0;

    release(&kt->lock);
  }
}

struct trapframe *get_kthread_trapframe(struct proc *p, struct kthread *kt)
{
  return p->base_trapframes + ((int)(kt - p->kthread));
}



int kthread_create( void *(*start_func)(), void *stack, uint stack_size){
  struct proc * p;
  p = myproc();

  struct kthread* kt = alloc_thread(p);
  if(kt == 0)
    return -1;

  kt->state = KRUNNABLE;
  kt->trapframe->epc = (uint64)start_func;
  kt->trapframe->sp = (uint64)stack + stack_size;

  return 0;
}

struct kthread* get_kthread(int ktid){
  struct proc* p;
  for(p = proc; p < proc + NPROC; p ++){
    struct kthread* kt;
    if(p->state == USED){
      for(kt = p->kthread; kt < p->kthread + NKT; kt++){
        if(kt->tid == ktid){
          return kt;
        }
      }
    }
  }
  return 0;
}

int kthread_kill(int ktid){
  struct kthread* kt;
  kt = get_kthread(ktid);
  if(kt == 0)
    return -1;

  acquire(&kt->lock);
  kt->killed = 1;
  if(kt->state == KSLEEPING)
    kt->state = KRUNNABLE;
  
  release(&kt->lock);
  return 0;
}

void kthread_exit(int status){


  struct kthread* kt = mykthread();
  
  wakeup(kt);


  acquire(&kt->lock);
  kt->xstate = status;
  kt->state = KZOMBIE;
  release(&kt->lock);
  
  //check if it was the last thread of the process:
  struct proc* p = kt->pcb;
  acquire(&p->lock);
  struct kthread* t;
  int has_active_thread = 0;
  for(t = p->kthread; t < p->kthread + NKT; t++){
    if(t->state != KZOMBIE && t->state != KUNUSED){
      has_active_thread++;
      break;
    }
  }

  release(&kt->pcb->lock);
  
  if(!has_active_thread){
    exit(status);
  }

  acquire(&kt->lock);
  sched();
  panic("zombie kthread exit");
}

int kthread_join(int ktid, int *status){
  //find the kthread
  struct kthread* kt;
  kt = get_kthread(ktid);

  // struct kthread* calling_thread;
  // calling_thread = mykthread();

  struct proc* p;
  p = myproc();

  //sleep
  //chan = mykthread
  for(;;){
    acquire(&kt->lock);
    // kt->state = KSLEEPING;
    // kt->chan = mykthread();
    // // release(&kt->lock);

    // sched();
    if(kt->state != KZOMBIE || kt->state != KUNUSED){
      release(&kt->lock);
      acquire(&p->lock);
      sleep(kt, &p->lock);
      release(&p->lock);
    }
    else{

      if(copyout(kt->pcb->pagetable, (uint64)status, (char *)&kt->xstate, sizeof(kt->xstate)) < 0){
        release(&kt->lock);
        return -1;
      }
      free_thread(kt->chan);
      // release(&calling_thread->lock);

      return 0;
    }

  }
  return 0;
  

}







