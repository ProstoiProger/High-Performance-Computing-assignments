#include <bits/stdc++.h>
#include <cuda_runtime.h>

__global__ void showIndex()
{
    int index =
        threadIdx.x +
        blockIdx.x * blockDim.x;

    printf("Block %d, Thread %d, Global index %d\n",
           blockIdx.x,
           threadIdx.x,
           index);
}

int main()
{
    printf("Hello from the CPU!\n");

    showIndex<<<3, 4>>>();

    cudaDeviceSynchronize();

    return 0;
}
