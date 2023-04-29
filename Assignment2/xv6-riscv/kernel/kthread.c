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

  for (struct kthread *kt = p->kthread; kt < &p->kthread[NKT]; kt++)
  {

    // WARNING: Don't change this line!
    // get the pointer to the kernel stack of the kthread
    kt->kstack = KSTACK((int)((p - proc) * NKT + (kt - p->kthread)));

    //initi its lock
    initlock(&kt->kthread_lock, "kthread_lock");
    //state = unsused
    kt->state = UNUSED;
    //self.process = proc
    kt->proc = p;
    
  }
}

struct proc* current_proc(){
  
}

struct kthread *mykthread()
{
  // return &myproc()->kthread[0];
  return mycpu()->thread;
}

struct trapframe *get_kthread_trapframe(struct proc *p, struct kthread *kt)
{
  return p->base_trapframes + ((int)(kt - p->kthread));
}


int alloc_ktid(struct proc *p){
  acquire(&p->creating_thread_lock);
  int ktid = p->counter;
  p->counter ++;
  release(&p->creating_thread_lock);
  return ktid;
}

struct kthread* alloc_kthread(struct proc *p){
  acquire(&p->lock);
  struct kthread * t;
  for(t = p->kthread; t < &p->kthread + NKT; t++){
    if(t->state == UNUSED)
      break;
  }

  if(t->state != UNUSED){
    return -1;
    release(&p->lock);
  }

  t->ktid = alloc_ktid(p);
  t->state = USED;
  t->trapframe = get_kthread_trapframe(p, t);
  memset(t->context, 0, sizeof(t->context));
  t->context->ra = (uint64)forkret;
  t->context->sp = (uint64)(t->kstack);

  acquire(&t->kthread_lock);
  release(&p->lock);
  return t;

}

void free_kthread(struct kthread* t){
  t->chan = 0;
  t->context = 0;
  t->killed = 0;
  t->kstack = 0;
  t->ktid = 0;
  t->proc = 0;
  t->state = UNUSED;
  t->trapframe = 0;
  t->xstate = 0;
  release(&t->kthread_lock);
}

void clone_kthread(struct kthread* from, struct kthread* into){
  into->chan = from->chan;
  into->context = from->context;
  into->killed = from->killed;
  into->kstack = from->kstack;
  into->
}