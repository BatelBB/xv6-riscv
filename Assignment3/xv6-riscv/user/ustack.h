#include "kernel/types.h" 
#include "kernel/riscv.h"
#include "user.h"

#define MAXOPSIZE = 512

void* ustack_malloc(uint len);

int ustack_free(void);