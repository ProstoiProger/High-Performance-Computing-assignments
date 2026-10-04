#include <bits/stdc++.h>
#include <omp.h>

int main() {

    const int N = 1000000;
    int counter = 0;

    #pragma omp parallel for
    for (int i = 0; i < N; ++i) {
        #pragma omp atomic
        counter++;
    }

    std::cout << "Counter = "
              << counter
              << std::endl;

    return 0;
}
