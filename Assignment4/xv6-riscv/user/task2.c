#include "kernel/types.h"
#include "kernel/stat.h"
#include "user.h"
#include "kernel/fcntl.h"


int main(int argc, char *argv[])
{
  int fd;
  char buff[256];
  int i, n;

  fd = open("/random", O_RDWR);
  if(fd < 0){
    printf("not opened\n");
    exit(1);
  }

  // reading 256 numbers
  n = read(fd, buff, 256);
  // printf("buff: %s\n", buff);
  if(n < 0){
    printf("failed read\n");
    exit(1);
  }
  
  for(i = 0; i < n; i++){
    printf("index %d: random num: %d\n", i, buff[i]);
  }

  if(buff[0] != buff[255]){
    // printf("buff[255]: %d\n", buff[255]);
    printf("buffer not reset correctly\n");
    exit(1);
  }

  // test writing
  char new_seed = 0x3D;
  if(write(fd, &new_seed, 1) != 1){
    printf("failed to write\n");
    exit(1);
  }

  n = read(fd, buff, 5);
  if(n < 0){
    printf("failed to read 2\n");
    exit(1);
  }
  for(i = 0; i < n; i++){
    printf("index 2: %d: random num 2: %d\n", i, buff[i]);
  }

  // write more than one byte
  if(write(fd, &new_seed, 5) != -1){
    printf("didnt fail\n");
    exit(1);
  }

  printf("leazazel im hafala\n");
  exit(0);
}