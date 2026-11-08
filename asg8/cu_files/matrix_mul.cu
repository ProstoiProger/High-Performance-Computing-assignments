#include <bits/stdc++.h>
#include <cuda_runtime.h>

__global__ void matrixMul(
    const float *A,
    const float *B,
    float *C,
    int N)
{
    int col =
        blockIdx.x * blockDim.x +
        threadIdx.x;

    int row =
        blockIdx.y * blockDim.y +
        threadIdx.y;

    if (row < N && col < N)
    {
        float sum = 0.0f;

        for (int k = 0; k < N; ++k)
        {
            sum += A[row * N + k] * B[k * N + col];
        }

        C[row * N + col] = sum;
    }
}

int main()
{
    const int N = 512;

    size_t bytes = N * N * sizeof(float);

    float *A = (float *)malloc(bytes);
    float *B = (float *)malloc(bytes);
    float *C = (float *)malloc(bytes);
    float *C_cpu = (float *)malloc(bytes);

    for (int i = 0; i < N * N; ++i)
    {
        A[i] = (float)(i % 7);
        B[i] = (float)(i % 5);
    }

    for (int row = 0; row < N; ++row)
    {
        for (int col = 0; col < N; ++col)
        {
            float sum = 0.0f;

            for (int k = 0; k < N; ++k)
            {
                sum += A[row * N + k] * B[k * N + col];
            }

            C_cpu[row * N + col] = sum;
        }
    }

    float *dev_A;
    float *dev_B;
    float *dev_C;

    cudaMalloc((void **)&dev_A, bytes);
    cudaMalloc((void **)&dev_B, bytes);
    cudaMalloc((void **)&dev_C, bytes);

    cudaMemcpy(dev_A, A, bytes, cudaMemcpyHostToDevice);
    cudaMemcpy(dev_B, B, bytes, cudaMemcpyHostToDevice);

    dim3 threads(16, 16);

    dim3 blocks(
        (N + threads.x - 1) / threads.x,
        (N + threads.y - 1) / threads.y);

    matrixMul<<<blocks, threads>>>(
        dev_A,
        dev_B,
        dev_C,
        N);

    cudaDeviceSynchronize();

    cudaMemcpy(C, dev_C, bytes, cudaMemcpyDeviceToHost);

    if (N <= 8)
    {
        for (int row = 0; row < N; ++row)
        {
            for (int col = 0; col < N; ++col)
            {
                printf("%8.1f", C[row * N + col]);
            }
            printf("\n");
        }
    }

    double max_diff = 0.0;

    for (int i = 0; i < N * N; ++i)
    {
        max_diff = std::max(max_diff, (double)fabs(C[i] - C_cpu[i]));
    }

    printf("N = %d\n", N);
    printf("C[0][0] = %f, CPU = %f\n", C[0], C_cpu[0]);
    printf("C[N-1][N-1] = %f, CPU = %f\n", C[N * N - 1], C_cpu[N * N - 1]);
    printf("Max difference GPU vs CPU: %f\n", max_diff);

    cudaFree(dev_A);
    cudaFree(dev_B);
    cudaFree(dev_C);

    free(A);
    free(B);
    free(C);
    free(C_cpu);

    return 0;
}
