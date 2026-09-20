#include <bits/stdc++.h>

// Usage: matrix_access r   (row-wise, Experiment A)
//        matrix_access c   (column-wise, Experiment B)
int main(int argc, char** argv) {

    const int N = 4000;
    char mode = (argc > 1) ? argv[1][0] : 'r';

    std::vector<int> A(N * N, 1);

    long long sum = 0;

    auto start = std::chrono::high_resolution_clock::now();

    if (mode == 'r') {
        for (int i = 0; i < N; ++i) {
            for (int j = 0; j < N; ++j) {
                sum += A[i * N + j];
            }
        }
    } else {
        for (int j = 0; j < N; ++j) {
            for (int i = 0; i < N; ++i) {
                sum += A[i * N + j];
            }
        }
    }

    auto finish = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> elapsed = finish - start;

    std::cout << "Sum = " << sum << std::endl;
    std::cout << "Time = " << elapsed.count() << " seconds\n";

    return 0;
}
