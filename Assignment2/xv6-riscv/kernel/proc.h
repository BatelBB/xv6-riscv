#include "kthread.h"

extern void forkret(void);

// Saved registers for kernel context switches.
struct context {
  uint64 ra;
  uint64 sp;

  // callee-saved
  uint64 s0;
  uint64 s1;
  uint64 s2;
  uint64 s3;
  uint64 s4;
  uint64 s5;
  uint64 s6;
  uint64 s7;
  uint64 s8;
  uint64 s9;
  uint64 s10;
  uint64 s11;
};



enum procstate { UNUSED, USED, SLEEPING, RUNNABLE, RUNNING, ZOMBIE };

// Per-process state
struct proc {
  struct spinlock lock;
  struct spinlock creating_thread_lock;
  int counter;


  // p->lock must be held when using these:
  enum procstate state;        // Process state
  // void *chan;                  // If non-zero, sleeping on chan
  // int killed;                  // If non-zero, have been killed
  // int xstate;                  // Exit status to be returned to parent's wait
  int pid;                     // Process ID

  struct kthread kthread[NKT];        // kthread group table
  struct trapframe *base_trapframes;  // data page for trampolines

  // wait_lock must be held when using this:
  struct proc *parent;         // Parent process

  // these are private to the process, so p->lock need not be held.
  // uint64 stack;               // Virtual address of kernel stack
  uint64 sz;                   // Size of process memory (bytes)
  pagetable_t pagetable;       // User page table
  // struct context context;      // swtch() here to run process
  struct file *ofile[NOFILE];  // Open files
  struct inode *cwd;           // Current directory
  char name[16];               // Process name (debugging)
};
