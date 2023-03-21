#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(){
    int bytes_of_memory = memsize();
    printf("%d\n", bytes_of_memory);


    void * mac = malloc(20000*sizeof(char));
    bytes_of_memory = memsize();
    printf("%d\n", bytes_of_memory);
   

    free(mac);
    bytes_of_memory = memsize();
    printf("%d\n", bytes_of_memory);

    exit(0, "exit_message");
}
