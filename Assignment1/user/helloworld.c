#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, int *argv[]){
    write(1, "Hello World xv6", 15);

    exit(0, "exit_message");
}