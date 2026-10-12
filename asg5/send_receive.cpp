#include <bits/stdc++.h>
#include <mpi.h>

int main(int argc, char* argv[]) {

    MPI_Init(&argc, &argv);

    int rank;
    int size;

    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    if (rank == 0) {

        int value = 100;

        MPI_Send(&value, 1, MPI_INT, 1, 0, MPI_COMM_WORLD);

    }
    else if (rank == 1) {

        int value;

        MPI_Recv(&value, 1, MPI_INT, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);

        value = value * 2;

        std::cout << "Result = "
                  << value
                  << std::endl;
    }

    MPI_Finalize();

    return 0;
}
