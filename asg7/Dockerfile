FROM ubuntu:22.04
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential perl wget curl ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /build
RUN wget -q https://upc.lbl.gov/download/release/berkeley_upc-2022.10.0.tar.gz && tar xzf berkeley_upc-2022.10.0.tar.gz
WORKDIR /build/berkeley_upc-2022.10.0
RUN ./configure --prefix=/opt/bupc --disable-mpi --disable-udp --disable-ibv --disable-ucx --disable-ofi --enable-smp > /build/configure.log 2>&1 || (tail -50 /build/configure.log; exit 1)
RUN make -j8 > /build/make.log 2>&1 || (tail -80 /build/make.log; exit 1)
RUN make install > /build/install.log 2>&1 || (tail -50 /build/install.log; exit 1)
ENV PATH=/opt/bupc/bin:$PATH
WORKDIR /work
