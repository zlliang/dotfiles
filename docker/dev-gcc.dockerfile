# Docker image for development (C/C++)
# Repository: zlliang/dev:gcc
# Author: Zilong Liang

FROM zlliang/dev:base

RUN apt-get update

# Install GCC and CMake
RUN apt-get install -y gcc g++ cmake

# Install libtinfo5 for VSCode's C/C++ extension
RUN apt-get install -y libtinfo5

CMD ["fish"]
