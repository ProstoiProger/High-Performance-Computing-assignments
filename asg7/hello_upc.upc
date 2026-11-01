/* Part 4: First UPC Program - thread identification */
#include <stdio.h>
#include <upc.h>

int main()
{
    printf("Hello from thread %d of %d\n",
           MYTHREAD, THREADS);

    return 0;
}
