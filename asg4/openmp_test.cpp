#include <bits/stdc++.h>
#include <omp.h>

int main() {

    #pragma omp parallel
    {
        int id = omp_get_thread_num();
        int nthreads = omp_get_num_threads();

        std::cout << "Hello from thread "
                  << id
                  << " of "
                  << nthreads
                  << std::endl;
    }

    return 0;
}

