/* Part 5: Parallel Vector Addition C[i] = A[i] + B[i] */
#include <stdio.h>
#include <upc.h>

#define N 1000

shared int A[N];
shared int B[N];
shared int C[N];

int main()
{
    int i;

    upc_forall(i = 0; i < N; i++; &A[i])
    {
        A[i] = i;
        B[i] = 2 * i;
    }

    upc_barrier;

    upc_forall(i = 0; i < N; i++; &C[i])
    {
        C[i] = A[i] + B[i];
    }

    upc_barrier;

    if (MYTHREAD == 0)
    {
        printf("C[0] = %d\n", C[0]);
        printf("C[10] = %d\n", C[10]);
        printf("C[999] = %d\n", C[999]);
    }

    return 0;
}
