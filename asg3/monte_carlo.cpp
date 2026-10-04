#include <iostream>
#include <random>

int main() {

    const long long N = 1000000;
    const int P = 4;

    std::mt19937 generator(42);
    std::uniform_real_distribution<double> distribution(-1.0, 1.0);

    long long local_inside[P] = {0};
 	
    for (int p = 0; p < P; ++p) {

        for (long long i = 0; i < N / P; ++i) {

            double x = distribution(generator);
            double y = distribution(generator);

            if (x * x + y * y <= 1.0) {
                local_inside[p]++;
            }
        }
    }

    long long total_inside = 0;

    for (int p = 0; p < P; ++p) {
        total_inside += local_inside[p];
    }

    double pi = 4.0 * total_inside / N;

    std::cout << "N = " << N << std::endl;
    for (int p = 0; p < P; ++p) {
        std::cout << "Processor " << p << ": " << local_inside[p] << std::endl;
    }
    std::cout << "M = " << total_inside << std::endl;
    std::cout << "Pi = " << pi << std::endl;

    return 0;
}
