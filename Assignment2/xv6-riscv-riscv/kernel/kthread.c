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
  acquire(&p->thread_lock);

  for (struct kthread *kt = p->kthread; kt < &p->kthread[NKT]; kt++)
  {
    initi_lock(&kt->lock);
    kt->state = KUNUSED;
    kt->pcb = p;

    // WARNING: Don't change this line!
    // get the pointer to the kernel stack of the kthread
    kt->kstack = KSTACK((int)((p - proc) * NKT + (kt - p->kthread)));
  }
  release(&p->thread_lock);
}

struct kthread *mykthread()
{
  return mycpu()->thread;
}

int alloc_thread_id(struct proc *p){
  acquire(&p->thread_lock);
  int next = p->counter;
  p->counter ++;
  release(&p->thread_lock);
  return next;
}

struct kthread* alloc_thread(struct proc *p){
  acquire(&p->lock);
  for (struct kthread *kt = p->kthread; kt < &p->kthread[NKT]; kt++)
  {
    if(kt->state == KUNUSED){
      kt->tid = alloc_thread_id(p);
      kt->state = KUSED;
      kt->trapframe = get_kthread_trapframe(p, kt);
      memset(&kt->context, 0, sizeof(kt->context));
      kt->context.ra = (uint64)forkret;
      kt->context.sp = (uint64)kt->kstack + PGSIZE;

      release(&p->lock);
      return kt;
    }
  }

  release(&p->lock);
  return 0;
}

void free_thread(struct kthread* kt){
  acquire(&kt->lock);
  kt->trapframe = 0;
  kt->state = KUNUSED;
  kt->chan = 0;
  kt->tid = 0;
  kt->kstack = 0;

  release(&kt->lock);
}

struct trapframe *get_kthread_trapframe(struct proc *p, struct kthread *kt)
{
  return p->base_trapframes + ((int)(kt - p->kthread));
}

// TODO: delte this after you are done with task 2.2
void allocproc_help_function(struct proc *p) {
  p->kthread->trapframe = get_kthread_trapframe(p, p->kthread);

  p->context.sp = p->kthread->kstack + PGSIZE;
}