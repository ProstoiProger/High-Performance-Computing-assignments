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
        N = 10000000;
    }

    MPI_Bcast(&N, 1, MPI_LONG_LONG, 0, MPI_COMM_WORLD);

    std::cout << "Process " << rank << ": N = " << N << std::endl;

    MPI_Finalize();

    return 0;
}
