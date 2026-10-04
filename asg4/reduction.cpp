#include <bits/stdc++.h>
#include <omp.h>

int main() {

    const int N = 1000000;

    std::vector<double> A(N, 1.0);

    double sum = 0.0;

    #pragma omp parallel for reduction(+:sum)
    for (int i = 0; i < N; ++i) {
        sum += A[i];
    }

    std::cout << "Sum = " << sum << std::endl;

    return 0;
}
