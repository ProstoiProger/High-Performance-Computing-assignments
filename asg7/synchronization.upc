/* Part 8: Synchronization - synchronization experiment */
#include <stdio.h>
#include <upc.h>

shared int result[THREADS];

int main()
{
    result[MYTHREAD] = MYTHREAD * 10;

    upc_barrier;

    if (MYTHREAD == 0)
    {
        for (int i = 0; i < THREADS; ++i)
        {
            printf("result[%d] = %d\n",
                   i, result[i]);
        }
    }

    return 0;
}
