#include <stdarg.h>

#include "types.h"
#include "param.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "file.h"
#include "memlayout.h"
#include "riscv.h"
#include "defs.h"
#include "proc.h"

uint8 lfsr = 0x2A; // initialize the seed
struct spinlock lock;

void randominit(void)
{
  initlock(&lock, "random");

//   uartinit();

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[RANDOM].read = randomread;
  devsw[RANDOM].write = randomwrite;
}

uint8 lfsr_char(uint8 lfsr)
{
  uint8 bit;
  bit = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 4)) & 0x01;
  lfsr = (lfsr >> 1) | (bit << 7);
  return lfsr;
}

int randomread(int something, uint64 dst, int n)
{
  int i;
  uint8 tmp;            //maybe change to pointer
  int counter = 0;

  acquire(&lock);
  for(i = 0; i < n; i++){
    tmp = lfsr_char(lfsr);
    if(either_copyout(1, dst, &tmp, sizeof(uint8)) == -1)
        return counter;
    dst ++;
    counter ++;
    lfsr = tmp;
  }
  release(&lock);

  
  
  return n;
}


int randomwrite(int something, uint64 src, int n)
{
  if(n != 1)
    return -1;

  uint8 tmp;

  if(either_copyin(&tmp, 1, src, 1) == -1)
    return -1;

  acquire(&lock);
  lfsr = tmp;
  release(&lock);

  return 1;
}
