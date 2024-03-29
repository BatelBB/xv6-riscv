#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "riscv.h"
#include "spinlock.h"
#include "proc.h"
#include "defs.h"

struct cpu cpus[NCPU];

struct proc proc[NPROC];

struct proc *initproc;

int nextpid = 1;
struct spinlock pid_lock;

extern void forkret(void);
static void freeproc(struct proc *p);

extern char trampoline[]; // trampoline.S

// helps ensure that wakeups of wait()ing
// parents are not lost. helps obey the
// memory model when using p->parent.
// must be acquired before any p->lock.
struct spinlock wait_lock;

// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void proc_mapstacks(pagetable_t kpgtbl)
{
  struct proc *p;

  for (p = proc; p < &proc[NPROC]; p++)
  {
    char *pa = kalloc();
    if (pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int)(p - proc));
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
  }
}

void init_page_meta(struct proc *p)
{
  int i;
  for (i = 0; i < MAX_TOTAL_PAGES; i++)
  {
    p->pages[i].offset = 0;
    p->pages[i].pa = 0;
    p->pages[i].va = 0;
    p->pages[i].used = 0;
    p->pages[i].swapped = 0;
    p->pages[i].counter = 0;
    p->pages[i].counter_lapa = 0xFFFFFFFF;
  }
}

// initialize the proc table.
void procinit(void)
{
  struct proc *p;

  initlock(&pid_lock, "nextpid");
  initlock(&wait_lock, "wait_lock");
  for (p = proc; p < &proc[NPROC]; p++)
  {
    initlock(&p->lock, "proc");
    p->state = UNUSED;
    p->kstack = KSTACK((int)(p - proc));
  }
}

// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int cpuid()
{
  int id = r_tp();
  return id;
}

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu *
mycpu(void)
{
  int id = cpuid();
  struct cpu *c = &cpus[id];
  return c;
}

// Return the current struct proc *, or zero if none.
struct proc *
myproc(void)
{
  push_off();
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
  pop_off();
  return p;
}

int allocpid()
{
  int pid;

  acquire(&pid_lock);
  pid = nextpid;
  nextpid = nextpid + 1;
  release(&pid_lock);

  return pid;
}

// Look in the process table for an UNUSED proc.
// If found, initialize state required to run in the kernel,
// and return with p->lock held.
// If there are no free procs, or a memory allocation fails, return 0.
static struct proc *
allocproc(void)
{
  struct proc *p;

  for (p = proc; p < &proc[NPROC]; p++)
  {
    acquire(&p->lock);
    if (p->state == UNUSED)
    {
      goto found;
    }
    else
    {
      release(&p->lock);
    }
  }
  return 0;

found:
  p->pid = allocpid();
  p->state = USED;

  // createSwapFile(p);
  init_page_meta(p);
  p->tail = 0;
  p->head = 0;
  p->pages_in_file = 0;

  // Allocate a trapframe page.
  if ((p->trapframe = (struct trapframe *)kalloc()) == 0)
  {
    freeproc(p);
    release(&p->lock);
    return 0;
  }

  // An empty user page table.
  p->pagetable = proc_pagetable(p);
  if (p->pagetable == 0)
  {
    freeproc(p);
    release(&p->lock);
    return 0;
  }

  // Set up new context to start executing at forkret,
  // which returns to user space.
  memset(&p->context, 0, sizeof(p->context));
  p->context.ra = (uint64)forkret;
  p->context.sp = p->kstack + PGSIZE;

  return p;
}

// free a proc structure and the data hanging from it,
// including user pages.
// p->lock must be held.
static void
freeproc(struct proc *p)
{
  if (p->trapframe)
    kfree((void *)p->trapframe);
  p->trapframe = 0;
  if (p->pagetable)
    proc_freepagetable(p->pagetable, p->sz, p);
  p->pagetable = 0;
  p->sz = 0;
  p->pid = 0;
  p->parent = 0;
  p->name[0] = 0;
  p->chan = 0;
  p->killed = 0;
  p->xstate = 0;
  p->state = UNUSED;
}

// Create a user page table for a given process, with no user memory,
// but with trampoline and trapframe pages.
pagetable_t
proc_pagetable(struct proc *p)
{
  pagetable_t pagetable;

  // An empty page table.
  pagetable = uvmcreate();
  if (pagetable == 0)
    return 0;

  // map the trampoline code (for system call return)
  // at the highest user virtual address.
  // only the supervisor uses it, on the way
  // to/from user space, so not PTE_U.
  if (mappages(pagetable, TRAMPOLINE, PGSIZE,
               (uint64)trampoline, PTE_R | PTE_X) < 0)
  {
    uvmfree(pagetable, 0, p);
    return 0;
  }

  // map the trapframe page just below the trampoline page, for
  // trampoline.S.
  if (mappages(pagetable, TRAPFRAME, PGSIZE,
               (uint64)(p->trapframe), PTE_R | PTE_W) < 0)
  {
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    uvmfree(pagetable, 0, p);
    return 0;
  }

  return pagetable;
}

// Free a process's page table, and free the
// physical memory it refers to.
void proc_freepagetable(pagetable_t pagetable, uint64 sz, struct proc *p)
{
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
  uvmfree(pagetable, sz, p);
}

// a user program that calls exec("/init")
// assembled from ../user/initcode.S
// od -t xC ../user/initcode
uchar initcode[] = {
    0x17, 0x05, 0x00, 0x00, 0x13, 0x05, 0x45, 0x02,
    0x97, 0x05, 0x00, 0x00, 0x93, 0x85, 0x35, 0x02,
    0x93, 0x08, 0x70, 0x00, 0x73, 0x00, 0x00, 0x00,
    0x93, 0x08, 0x20, 0x00, 0x73, 0x00, 0x00, 0x00,
    0xef, 0xf0, 0x9f, 0xff, 0x2f, 0x69, 0x6e, 0x69,
    0x74, 0x00, 0x00, 0x24, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00};

// Set up first user process.
void userinit(void)
{
  struct proc *p;

  p = allocproc();
  initproc = p;

  // allocate one user page and copy initcode's instructions
  // and data into it.
  uvmfirst(p->pagetable, initcode, sizeof(initcode));
  p->sz = PGSIZE;

  // prepare for the very first "return" from kernel to user.
  p->trapframe->epc = 0;     // user program counter
  p->trapframe->sp = PGSIZE; // user stack pointer

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  p->state = RUNNABLE;

  release(&p->lock);
}

// Grow or shrink user memory by n bytes.
// Return 0 on success, -1 on failure.
int growproc(int n)
{
  uint64 sz;
  struct proc *p = myproc();

  sz = p->sz;
  if (n > 0)
  {
    if ((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0)
    {
      return -1;
    }
  }
  else if (n < 0)
  {
    sz = uvmdealloc(p->pagetable, sz, sz + n);
  }
  p->sz = sz;
  return 0;
}

// Create a new process, copying the parent.
// Sets up child kernel stack to return as if from fork() system call.
int fork(void)
{
  int i, pid;
  struct proc *np;
  struct proc *p = myproc();

  // Allocate process.
  if ((np = allocproc()) == 0)
  {
    return -1;
  }

  // Copy user memory from parent to child.
  if (uvmcopy(p->pagetable, np->pagetable, p->sz) < 0)
  {
    freeproc(np);
    release(&np->lock);
    return -1;
  }
  np->sz = p->sz;

  // copy saved user registers.
  *(np->trapframe) = *(p->trapframe);

  // Cause fork to return 0 in the child.
  np->trapframe->a0 = 0;

  // increment reference counts on open file descriptors.
  for (i = 0; i < NOFILE; i++)
    if (p->ofile[i])
      np->ofile[i] = filedup(p->ofile[i]);
  np->cwd = idup(p->cwd);

  safestrcpy(np->name, p->name, sizeof(p->name));

  pid = np->pid;

  release(&np->lock);

  createSwapFile(np);
  if (p->pid > 2)
  {
    copy_page_meta(p, np);
  }

  acquire(&wait_lock);
  np->parent = p;
  release(&wait_lock);

  acquire(&np->lock);
  np->state = RUNNABLE;
  release(&np->lock);

  return pid;
}

// Pass p's abandoned children to init.
// Caller must hold wait_lock.
void reparent(struct proc *p)
{
  struct proc *pp;

  for (pp = proc; pp < &proc[NPROC]; pp++)
  {
    if (pp->parent == p)
    {
      pp->parent = initproc;
      wakeup(initproc);
    }
  }
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait().
void exit(int status)
{
  struct proc *p = myproc();

  if (p == initproc)
    panic("init exiting");

  removeSwapFile(p);

  // Close all open files.
  for (int fd = 0; fd < NOFILE; fd++)
  {
    if (p->ofile[fd])
    {
      struct file *f = p->ofile[fd];
      fileclose(f);
      p->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(p->cwd);
  end_op();
  p->cwd = 0;

  acquire(&wait_lock);

  // Give any children to init.
  reparent(p);

  // Parent might be sleeping in wait().
  wakeup(p->parent);

  acquire(&p->lock);

  p->xstate = status;
  p->state = ZOMBIE;

  release(&wait_lock);

  // Jump into the scheduler, never to return.
  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int wait(uint64 addr)
{
  struct proc *pp;
  int havekids, pid;
  struct proc *p = myproc();

  acquire(&wait_lock);

  for (;;)
  {
    // Scan through table looking for exited children.
    havekids = 0;
    for (pp = proc; pp < &proc[NPROC]; pp++)
    {
      if (pp->parent == p)
      {
        // make sure the child isn't still in exit() or swtch().
        acquire(&pp->lock);

        havekids = 1;
        if (pp->state == ZOMBIE)
        {
          // Found one.
          pid = pp->pid;
          if (addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
                                   sizeof(pp->xstate)) < 0)
          {
            release(&pp->lock);
            release(&wait_lock);
            return -1;
          }
          freeproc(pp);
          release(&pp->lock);
          release(&wait_lock);
          return pid;
        }
        release(&pp->lock);
      }
    }

    // No point waiting if we don't have any children.
    if (!havekids || killed(p))
    {
      release(&wait_lock);
      return -1;
    }

    // Wait for a child to exit.
    sleep(p, &wait_lock); // DOC: wait-sleep
  }
}

// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run.
//  - swtch to start running that process.
//  - eventually that process transfers control
//    via swtch back to the scheduler.
void scheduler(void)
{
  struct proc *p;
  struct cpu *c = mycpu();

  c->proc = 0;
  for (;;)
  {
    // Avoid deadlock by ensuring that devices can interrupt.
    intr_on();

    for (p = proc; p < &proc[NPROC]; p++)
    {
      acquire(&p->lock);
      if (p->state == RUNNABLE)
      {
        // Switch to chosen process.  It is the process's job
        // to release its lock and then reacquire it
        // before jumping back to us.
        p->state = RUNNING;
        c->proc = p;
        swtch(&c->context, &p->context);

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        c->proc = 0;
      }
      release(&p->lock);

      #ifdef NFUA
        update_nfua(p);
      #endif
    }
  }
}

// Switch to scheduler.  Must hold only p->lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->noff, but that would
// break in the few places where a lock is held but
// there's no process.
void sched(void)
{
  int intena;
  struct proc *p = myproc();

  if (!holding(&p->lock))
    panic("sched p->lock");
  if (mycpu()->noff != 1)
    panic("sched locks");
  if (p->state == RUNNING)
    panic("sched running");
  if (intr_get())
    panic("sched interruptible");

  intena = mycpu()->intena;
  swtch(&p->context, &mycpu()->context);
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void yield(void)
{
  struct proc *p = myproc();
  acquire(&p->lock);
  p->state = RUNNABLE;
  sched();
  release(&p->lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void forkret(void)
{
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);

  if (first)
  {
    // File system initialization must be run in the context of a
    // regular process (e.g., because it calls sleep), and thus cannot
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();

  // Must acquire p->lock in order to
  // change p->state and then call sched.
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock); // DOC: sleeplock1
  release(lk);

  // Go to sleep.
  p->chan = chan;
  p->state = SLEEPING;

  sched();

  // Tidy up.
  p->chan = 0;

  // Reacquire original lock.
  release(&p->lock);
  acquire(lk);
}

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void wakeup(void *chan)
{
  struct proc *p;

  for (p = proc; p < &proc[NPROC]; p++)
  {
    if (p != myproc())
    {
      acquire(&p->lock);
      if (p->state == SLEEPING && p->chan == chan)
      {
        p->state = RUNNABLE;
      }
      release(&p->lock);
    }
  }
}

// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int kill(int pid)
{
  struct proc *p;

  for (p = proc; p < &proc[NPROC]; p++)
  {
    acquire(&p->lock);
    if (p->pid == pid)
    {
      p->killed = 1;
      if (p->state == SLEEPING)
      {
        // Wake process from sleep().
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
  }
  return -1;
}

void setkilled(struct proc *p)
{
  acquire(&p->lock);
  p->killed = 1;
  release(&p->lock);
}

int killed(struct proc *p)
{
  int k;

  acquire(&p->lock);
  k = p->killed;
  release(&p->lock);
  return k;
}

// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
  struct proc *p = myproc();
  if (user_dst)
  {
    return copyout(p->pagetable, dst, src, len);
  }
  else
  {
    memmove((char *)dst, src, len);
    return 0;
  }
}

// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
  struct proc *p = myproc();
  if (user_src)
  {
    return copyin(p->pagetable, dst, src, len);
  }
  else
  {
    memmove(dst, (char *)src, len);
    return 0;
  }
}

// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void procdump(void)
{
  static char *states[] = {
      [UNUSED] "unused",
      [USED] "used",
      [SLEEPING] "sleep ",
      [RUNNABLE] "runble",
      [RUNNING] "run   ",
      [ZOMBIE] "zombie"};
  struct proc *p;
  char *state;

  printf("\n");
  for (p = proc; p < &proc[NPROC]; p++)
  {
    if (p->state == UNUSED)
      continue;
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    printf("%d %s %s", p->pid, state, p->name);
    printf("\n");
  }
}

void remove_page(uint64 va, struct proc *p)
{
  struct pages_meta *s;
  if (p->pid > 2)
  {
    // printf("remove: %p\n", va);

    for (s = p->pages; s < p->pages + MAX_TOTAL_PAGES; s++)
    {
      if (s->va == va)
      {
        s->used = 0;
      }
    }
  }
}

struct pages_meta *swap_nfua(struct proc *p)
{
  printf("****************nfua\n");

  struct pages_meta *min = 0;
  struct pages_meta *cur;

  for (cur = p->pages; cur < p->pages + MAX_TOTAL_PAGES; cur++)
  {
    if (cur->used && !cur->swapped)
    {
      pte_t *pte = walk(p->pagetable, cur->va, 0);
      if (*pte & PTE_U)
      {
        if (min == 0 || cur->counter < min->counter)
          min = cur;
      }
    }
  }
  return min;
}

int count_ones(uint64 x)
{
  int count = 0;
  while (x)
  {
    count += x & 1;
    x >>= 1;
  }
  return count;
}

struct pages_meta *swap_lapa(struct proc *p)
{
  printf("****************lapa\n");
  struct pages_meta *min = 0;
  struct pages_meta *cur;

  for (cur = p->pages; cur < p->pages + MAX_TOTAL_PAGES; cur++)
  {
    if (cur->used && !cur->swapped)
    {
      pte_t *pte = walk(p->pagetable, cur->va, 0);
      if (*pte & PTE_U)
      {
        if (min == 0 || count_ones(cur->counter_lapa) < count_ones(min->counter_lapa))
          min = cur;
        else if (count_ones(cur->counter_lapa) == count_ones(min->counter_lapa))
          if (cur->counter_lapa < min->counter_lapa)
            min = cur;
      }
    }
  }
  return min;
}

struct pages_meta *swap_scfifo(struct proc *p)
{
  printf("****************scfifo\n");
  struct pages_meta *next = p->pages_scfifo_queue + p->head;
  pte_t *pte = walk(p->pagetable, next->va, 0);

  if ((*pte & PTE_A))
  {
    // then second change:
    p->pages_scfifo_queue[p->tail] = *next;
    p->tail = (p->tail + 1) % MAX_PSYC_PAGES;
    p->head = (p->head + 1) % MAX_PSYC_PAGES;
    *pte &= ~PTE_A;
    return swap_scfifo(p);
  }
  else
  {
    p->head = (p->head + 1) % MAX_PSYC_PAGES;
    return next;
  }
}

struct pages_meta *get_swap_algo(struct proc* p){
  #ifdef NFUA
    return swap_nfua(p);
  #endif
  #ifdef LAPA
    return swap_lapa(p);
  #endif
  #ifdef SCFIFO
    return swap_scfifo(p);
  #endif
  return 0;
}

int swap_psyc(struct proc *p)
{ // swap from physical to file
  if (p->pid < 3)
  {
    return 0;
  }

  struct pages_meta *s = get_swap_algo(p);

  if (s == 0)
    return -1;

  pte_t *pte = walk(p->pagetable, s->va, 0);

  if (writeToSwapFile(p, (char *)s->pa, p->pages_in_file * PGSIZE, PGSIZE) == -1)
  {
    printf("error write to file\n");
    exit(-1);
  }

  s->swapped = 1;
  s->offset = p->pages_in_file * PGSIZE;
  kfree((void *)s->pa); // freeing the page from pyisical memmory
  s->pa = 0;
  s->pte_flags = PTE_FLAGS(*pte);

  *pte |= PTE_PG;
  *pte &= ~PTE_V;

  p->pages_in_file++;
  // printf("swapped out va: %p\n", s->va);
  return 0;
}

int count_psyc(struct proc *p)
{
  struct pages_meta *s;
  int counter = 0;
  for (s = p->pages; s < p->pages + MAX_TOTAL_PAGES; s++)
  {
    if (!s->swapped && s->used)
    {
      counter++;
    }
  }

  return counter;
}

struct pages_meta *get_free_slot(struct proc *p)
{
  struct pages_meta *s;
  for (s = p->pages; s < p->pages + MAX_TOTAL_PAGES; s++)
  {
    if (!s->used)
    {
      return s;
    }
  }
  return (struct pages_meta *)0;
}

void add_to_queue(struct proc *p, struct pages_meta *s)
{
  pte_t *pte = walk(p->pagetable, s->va, 0);
  if (*pte & PTE_U)
  {
    p->pages_scfifo_queue[p->tail] = *s;
    p->tail = (p->tail + 1) % MAX_PSYC_PAGES;
  }
}

int add_page(uint64 va, uint64 pa)
{
  // printf("add_page\n");
  // find open spot in the array
  // if no open slot in array delete 1 and swap for new one

  struct proc *p = myproc();
  if (p->pid < 3)
  {
    return 0;
  }

  if (p->swapFile == 0)
  {
    createSwapFile(p);
  }

  // acquire(&p->lock);

  struct pages_meta *new_page = get_free_slot(p);
  if (new_page == 0)
  {
    // release(&p->lock);
    printf("max pages exeeded");
    exit(-1);
  }

  // check if phyisical mem holds less than 16 pages if not need gto swap 1
  if (count_psyc(p) == MAX_PSYC_PAGES)
  {
    swap_psyc(p);
  }

  new_page->va = va;
  new_page->pa = pa;
  new_page->used = 1;
  new_page->swapped = 0;
  new_page->counter = 0;
  new_page->counter_lapa = 0xFFFFFFFF;

  new_page->pte = walk(p->pagetable, va, 0);

  add_to_queue(p, new_page);

  // release(&p->lock);
  return 0;
}

int swap_in(uint64 va, struct proc *p)
{
  struct pages_meta *s;

  // printf("pagetable in swapin: %p\n", p->pagetable);

  for (s = p->pages; s < p->pages + MAX_TOTAL_PAGES; s++)
  {
    if (s->used && s->va == va)
    {

      
      if (!s->swapped)
      {
        // Page is already in memory.
        return -1;
      }

      // //check if theres already 16 pages in physical mem
      // if(count_psyc(p) == MAX_PSYC_PAGES){
      //   swap_psyc(p);
      // }

      // Allocate a new physical page.
      void *addr = kalloc();
      if (addr == 0)
      {
        printf("failed allocating physical page\n");
        return -1;
      }

      // Read data from the swap file into the new physical page.
      if (readFromSwapFile(p, (char *)addr, s->offset, PGSIZE) == -1)
      {
        printf("failed reading from swap file\n");
        kfree(addr); // free the allocated page
        return -1;
      }

      // Update the page table entry.
      pte_t *pte = walk(p->pagetable, va, 0); // no need to create a new PTE
      if (pte == 0)
      {
        printf("failed walking pagetable\n");
        kfree(addr); // free the allocated page
        return -1;
      }

      // mappages(p->pagetable, s->va, PGSIZE, s->pa, PTE_FLAGS(*pte));
      // *pte = 0;
      *pte = PA2PTE(addr) | s->pte_flags | PTE_V; // set the physical address and valid bit, preserving the other flags
      //

      // printf("after swap: isvalid: %d\npte: %d\n", (*pte & PTE_V), *pte);
      // printf("saved pte: %d\n", (*(s->pte) & PTE_V), *(s->pte));
      // Update the metadata.
      s->pa = (uint64)addr;
      s->swapped = 0;
      s->counter = 0;
      s->counter_lapa = 0xFFFFFFFF;

      p->pages_in_file--;
      printf("swapped in va: %p\n", s->va);

      add_to_queue(p, s);

      // printf("swapped_in: %p\n", s->va);

      return 0;
    }
  }

  // Page not found.
  return -1;
}

int is_swapped(uint64 va)
{
  struct pages_meta *s;
  struct proc *p = myproc();
  for (s = p->pages; s < p->pages + MAX_TOTAL_PAGES; s++)
  {
    if (s->swapped && s->va == va)
    {
      return 1;
    }
  }
  return 0;
}

int copy_page_meta(struct proc *p, struct proc *np)
{

  int j;
  for (j = 0; j < MAX_TOTAL_PAGES; j++)
  {
    // copy the file
    if (p->pages[j].swapped)
    {
      char *buffer = (char *)kalloc();
      int read_size = readFromSwapFile(p, buffer, p->pages[j].offset, PGSIZE);
      if (read_size == -1)
        return 0;

      kfree((void *)buffer);

      if (writeToSwapFile(np, buffer, p->pages[j].offset, read_size) == -1)
        return -1;
    }
  }

  int i;
  for (i = 0; i < MAX_TOTAL_PAGES; i++)
  {
    struct pages_meta s = p->pages[i];
    // struct pages_meta s2 = np->pages[i];

    // copy values
    np->pages[i].used = s.used;
    np->pages[i].swapped = s.swapped;
    np->pages[i].offset = s.offset;
    np->pages[i].pa = s.pa;
    np->pages[i].va = s.va;
    np->pages[i].pte_flags = s.pte_flags;
  }
  return 0;
}

int is_paging()
{
  return myproc()->pid > 2;
}

int cur_pid()
{
  return myproc()->pid;
}

void *p_pagetable(struct proc *p)
{
  return p->pagetable;
}

void update_nfua(struct proc *p)
{
  struct pages_meta *s;
  for (s = p->pages; s < p->pages + MAX_TOTAL_PAGES; s++)
  {
    if (s->used && !(s->swapped))
    {
      pte_t *pte = walk(p->pagetable, s->va, 0);
      s->counter = s->counter >> 1;
      if ((*pte) & PTE_A)
      {
        s->counter |= 0x80000000;
        (*pte) &= ~PTE_A;
      }
      else
      {
        s->counter &= 0;
      }
    }
  }
}