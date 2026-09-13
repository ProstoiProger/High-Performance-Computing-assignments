#include <bits/stdc++.h>

int main(int argc, char** argv) {
    const long long N = (argc > 1) ? std::atoll(argv[1]) : 1000000LL;

    std::vector<long long> a(N);

    for (long long i = 0; i < N; ++i) {
        a[i] = i;
    }

    auto start = std::chrono::high_resolution_clock::now();

    for (long long i = 0; i < N; ++i) {
        a[i] = a[i] + 1;
    }

    auto finish = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> elapsed = finish - start;

    long long sum = 0;
    for (long long i = 0; i < N; ++i) {
        sum += a[i];
    }

    std::cout << "N = " << N << "\n";
    std::cout << "Sum = " << sum << "\n";
    std::cout << "Time: " << elapsed.count() << " seconds\n";

    return 0;
}