#include <bits/stdc++.h>
#include <mpi.h>

int main(int argc, char* argv[]) {

    MPI_Init(&argc, &argv);

    int rank;
    int size;

    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    int A[4] = {10, 20, 30, 40};
    int B[4] = {0, 0, 0, 0};
    int value;

    MPI_Scatter(A, 1, MPI_INT, &value, 1, MPI_INT, 0, MPI_COMM_WORLD);

    value = value * (rank + 1);

    MPI_Gather(&value, 1, MPI_INT, B, 1, MPI_INT, 0, MPI_COMM_WORLD);

    if (rank == 0) {
        std::cout << "Final array:";
        for (int i = 0; i < 4; ++i) {
            std::cout << " " << B[i];
        }
        std::cout << std::endl;
    }

    MPI_Finalize();

    return 0;
}
