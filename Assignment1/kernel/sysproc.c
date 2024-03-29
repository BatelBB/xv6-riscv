#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
  int n;
  argint(0, &n);
  char c[32];
  argstr(1,c,32);
  exit(n,c);
  return 0;  // not reached
}

uint64
sys_getpid(void)
{
  return myproc()->pid;
}

uint64
sys_fork(void)
{
  return fork();
}

uint64
sys_wait(void)
{
  uint64 p;
  argaddr(0, &p);
  uint64 c;
  argaddr(1,&c);
  return wait(p, c);
}

uint64
sys_sbrk(void)
{
  uint64 addr;
  int n;

  argint(0, &n);
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

uint64
sys_sleep(void)
{
  int n;
  uint ticks0;

  argint(0, &n);
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

uint64
sys_kill(void)
{
  int pid;

  argint(0, &pid);
  return kill(pid);
}

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

uint64
sys_memsize(void)
{
  struct proc *p = myproc();
  return p->sz;
}

uint64
sys_set_ps_priority(void)
{
  struct proc *p = myproc();
  int n;
  argint(0, &n);

  acquire(&p->lock);
  p->ps_priority = n;
  release(&p->lock);

  return n;
}

uint64
sys_set_cfs_priority(void)
{
  struct proc *p = myproc();
  int n;
  argint(0, &n);

  acquire(&p->lock);
  p->cfs_priority = n;
  release(&p->lock);

  return n;
}

uint64
sys_get_cfs_stats(void)
{
  int n1;
  argint(0, &n1);
  uint64 n2;
  argaddr(1, &n2);
  uint64 n3;
  argaddr(2, &n3);
  uint64 n4;
  argaddr(3, &n4);
  uint64 n5;
  argaddr(4, &n5);
  return get_cfs_stats(n1,n2,n3,n4,n5);
}

uint64
sys_set_policy(void)
{
  int n;
  argint(0, &n);
  sched_policy = n;
  return n;
}
