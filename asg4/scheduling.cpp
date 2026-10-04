#include <bits/stdc++.h>
#include <omp.h>

int main() {

    const int N = 100000;

    std::vector<double> result(N);

    double start = omp_get_wtime();

    #pragma omp parallel for schedule(static)
    for (int i = 0; i < N; ++i) {

        int work = 100 + (i % 1000);

        double value = 0.0;

        for (int k = 0; k < work; ++k) {
            value += std::sqrt(k + 1.0);
        }

        result[i] = value;
    }

    double finish = omp_get_wtime();

    std::cout << "Static Time = "
              << finish - start
              << " seconds "
              << std::endl;

    start = omp_get_wtime();

    #pragma omp parallel for schedule(dynamic, 10)
    for (int i = 0; i < N; ++i) {

        int work = 100 + (i % 1000);

        double value = 0.0;

        for (int k = 0; k < work; ++k) {
            value += std::sqrt(k + 1.0);
        }

        result[i] = value;
    }

    finish = omp_get_wtime();

    std::cout << "Dynamic Time = "
              << finish - start
              << " seconds "
              << std::endl;

    return 0;
}
