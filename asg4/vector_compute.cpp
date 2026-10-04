#include <bits/stdc++.h>
#include <omp.h>

int main() {

    const int N = 1000000;

    std::vector<double> A(N);
    std::vector<double> B(N);
    std::vector<double> C(N);

    for (int i = 0; i < N; ++i) {
        A[i] = i * 0.5;
        B[i] = i * 0.25;
    }

    #pragma omp parallel for
    for (int i = 0; i < N; ++i) {
        C[i] = 2.0 * A[i] + B[i];
    }

    std::cout << "C[0] = " << C[0] << std::endl;
    std::cout << "C[N-1] = " << C[N-1] << std::endl;

    return 0;
}
