#include "kernel/types.h"
#include "kernel/stat.h"
#include "user.h"
#include "kernel/fcntl.h"


int main()
{
  int fd;
  int n;
  char *filename = "test";
  char data[512];
  char buffer[512];

  fd = open(filename, O_CREATE | O_WRONLY);
  if(fd < 0){
    printf("not opening %s\n", filename);
    exit(1);
  }
  memset(data, 'D', 512);
  write(fd, data, 512);
  close(fd);

  // open in read mode
  fd = open(filename, O_RDONLY);
  if(fd < 0){
    printf("failed to open\n");
    exit(1);
  }

  // read from the middle
  seek(fd, 512 / 2, SEEK_SET);
  n = read(fd, buffer, 512);
  // printf("buffer: %s\n", buffer);
  if(n < 0){
    printf("failed to read\n");
    exit(1);
  }

  for(int i = 0; i < n; i++){
    if(buffer[i] != 'D'){
      exit(1);
    }
  }


  close(fd);

  //test set + offset < 0
  char buffer2[1];
  char data2[1];
  memset(data2, 'S', 1);
  fd = open(filename, O_WRONLY);

  int ans1 = seek(fd, -31, SEEK_SET);
  n = write(fd, data2, 1);
  // printf("data2: %s\n",  data2);
  // printf("n: %d\n",  n);

  close(fd);

  fd = open(filename, O_RDONLY);
  int ans2 = seek(fd, 0, SEEK_SET);

  // printf("ans1: %d, ans2: %d\n", ans1, ans2);


  n = read(fd, buffer2, 1);
  // printf("buffer2: %s\n",  buffer2);
  if (buffer2[0] != 'S'){
    printf("negative offset with set != 0 : %s\n", buffer2[0]);
    exit(-1);
  }

  close(fd);
  printf("hafala the best\n");

  exit(0);
}