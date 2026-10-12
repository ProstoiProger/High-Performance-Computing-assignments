#include <bits/stdc++.h>
#include <mpi.h>

int main(int argc, char* argv[]) {

    MPI_Init(&argc, &argv);

    int rank;
    int size;

    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    long long N = 0;

    if (rank == 0) {
        N = 1000000000;
    }

    MPI_Bcast(&N, 1, MPI_LONG_LONG, 0, MPI_COMM_WORLD);

    double start_time = MPI_Wtime();

    long long start = rank * N / size + 1;
    long long end = (rank + 1) * N / size;

    long long local_sum = 0;

    for (long long i = start; i <= end; ++i) {
        local_sum += i;
    }

    long long total_sum = 0;

    MPI_Reduce(&local_sum, &total_sum, 1, MPI_LONG_LONG, MPI_SUM, 0, MPI_COMM_WORLD);

    double finish_time = MPI_Wtime();

    double elapsed = finish_time - start_time;

    if (rank == 0) {
        std::cout << "Total sum = " << total_sum << std::endl;
        std::cout << "Time = " << elapsed << " seconds" << std::endl;
    }

    MPI_Finalize();

    return 0;
}
