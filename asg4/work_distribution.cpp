#include <bits/stdc++.h>
#include <omp.h>

int main() {

    const int N = 20;

    #pragma omp parallel for
    for (int i = 0; i < N; ++i) {

        int id = omp_get_thread_num();

        std::cout << "Iteration "
                  << i
                  << " executed by thread "
                  << id
                  << std::endl;
    }

    return 0;
}
