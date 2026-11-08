#include <bits/stdc++.h>
#include <cuda_runtime.h>

__global__ void vectorAdd(const float *A,
                          const float *B,
                          float *C,
                          int N)
{
    int i =
        threadIdx.x +
        blockIdx.x * blockDim.x;

    if (i < N)
    {
        C[i] = A[i] + B[i];
    }
}

int main()
{
    const int N = 1000000;

    size_t bytes = N * sizeof(float);

    float *A = (float *)malloc(bytes);
    float *B = (float *)malloc(bytes);
    float *C = (float *)malloc(bytes);

    for (int i = 0; i < N; ++i)
    {
        A[i] = (float)i;
        B[i] = 2.0f * i;
    }

    float *dev_A;
    float *dev_B;
    float *dev_C;

    cudaMalloc((void **)&dev_A, bytes);
    cudaMalloc((void **)&dev_B, bytes);
    cudaMalloc((void **)&dev_C, bytes);

    cudaMemcpy(dev_A, A, bytes, cudaMemcpyHostToDevice);
    cudaMemcpy(dev_B, B, bytes, cudaMemcpyHostToDevice);

    int threadsPerBlock = 256;

    int blocks =
        (N + threadsPerBlock - 1)
        / threadsPerBlock;

    cudaEvent_t start, stop;

    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start);

    vectorAdd<<<blocks, threadsPerBlock>>>(
        dev_A, dev_B, dev_C, N);

    cudaEventRecord(stop);

    cudaEventSynchronize(stop);

    float milliseconds = 0.0f;

    cudaEventElapsedTime(
        &milliseconds, start, stop);

    printf("Kernel time: %f ms\n",
           milliseconds);

    cudaEventDestroy(start);
    cudaEventDestroy(stop);

    // Wait until the GPU finishes
    cudaDeviceSynchronize();

    cudaMemcpy(C, dev_C, bytes, cudaMemcpyDeviceToHost);

    printf("threadsPerBlock = %d, blocks = %d\n", threadsPerBlock, blocks);
    printf("C[0] = %f\n", C[0]);
    printf("C[10] = %f\n", C[10]);
    printf("C[N-1] = %f\n", C[N-1]);

    cudaFree(dev_A);
    cudaFree(dev_B);
    cudaFree(dev_C);

    free(A);
    free(B);
    free(C);

    return 0;
}
