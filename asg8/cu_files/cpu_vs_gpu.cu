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
    float *C_gpu = (float *)malloc(bytes);

    for (int i = 0; i < N; ++i)
    {
        A[i] = (float)i;
        B[i] = 2.0f * i;
    }

    auto cpu_start = std::chrono::high_resolution_clock::now();

    for (int i = 0; i < N; ++i)
    {
        C[i] = A[i] + B[i];
    }

    auto cpu_end = std::chrono::high_resolution_clock::now();
    double cpu_ms = std::chrono::duration<double, std::milli>(cpu_end - cpu_start).count();

    float *dev_A;
    float *dev_B;
    float *dev_C;

    cudaMalloc((void **)&dev_A, bytes);
    cudaMalloc((void **)&dev_B, bytes);
    cudaMalloc((void **)&dev_C, bytes);

    int threadsPerBlock = 256;

    int blocks =
        (N + threadsPerBlock - 1)
        / threadsPerBlock;

    cudaEvent_t total_start, total_stop, start, stop;

    cudaEventCreate(&total_start);
    cudaEventCreate(&total_stop);
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(total_start);

    cudaMemcpy(dev_A, A, bytes, cudaMemcpyHostToDevice);
    cudaMemcpy(dev_B, B, bytes, cudaMemcpyHostToDevice);

    cudaEventRecord(start);

    vectorAdd<<<blocks, threadsPerBlock>>>(
        dev_A, dev_B, dev_C, N);

    cudaEventRecord(stop);

    cudaMemcpy(C_gpu, dev_C, bytes, cudaMemcpyDeviceToHost);

    cudaEventRecord(total_stop);

    cudaEventSynchronize(total_stop);

    float kernel_ms = 0.0f;
    float total_ms = 0.0f;

    cudaEventElapsedTime(&kernel_ms, start, stop);
    cudaEventElapsedTime(&total_ms, total_start, total_stop);

    int errors = 0;

    for (int i = 0; i < N; ++i)
    {
        if (C_gpu[i] != C[i])
        {
            errors++;
        }
    }

    printf("N = %d\n", N);
    printf("CPU time: %f ms\n", cpu_ms);
    printf("GPU kernel time: %f ms\n", kernel_ms);
    printf("GPU time with copies: %f ms\n", total_ms);
    printf("Mismatches: %d\n", errors);

    cudaEventDestroy(total_start);
    cudaEventDestroy(total_stop);
    cudaEventDestroy(start);
    cudaEventDestroy(stop);

    cudaFree(dev_A);
    cudaFree(dev_B);
    cudaFree(dev_C);

    free(A);
    free(B);
    free(C);
    free(C_gpu);

    return 0;
}
