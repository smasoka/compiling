#!/bin/bash

#PBS -P RCHPC
#PBS -N casacore_compiling
#PBS -q serial
#PBS -l select=1:ncpus=24
#PBS -l walltime=03:00:00
#PBS -o /mnt/lustre/users/smasoka/compiling/casacore_compiling.out
#PBS -e /mnt/lustre/users/smasoka/compiling/casacore_compiling.err
#PBS -m abe
#PBS -M sakhile.harvey@gmail.com

module load chpc/astro/gcc/8.3.0
module load chpc/astro/anaconda/3
module load chpc/astro/cmake/3.15.6
module load chpc/astro/openmpi/4.0.3

VERSION=3.2.1
SOURCE_DIR=/apps/chpc/astro/casacore-3.2.0/source_dir/casacore-${VERSION}
INSTALL_PREFIX=/apps/chpc/astro/casacore/${VERSION}

echo "Version : $VERSION"
echo "Source Directory: $SOURCE_DIR"
echo "Install Prefix: $INSTALL_PREFIX"

OPTIONS=""
OPTIONS="${OPTIONS} -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX}"
OPTIONS="${OPTIONS} -DCMAKE_CXX_COMPILER=${MPICPP}"
OPTIONS="${OPTIONS} -DCMAKE_C_COMPILER=${MPICC}"
OPTIONS="${OPTIONS} -DCMAKE_Fortran_COMPILER=${MPIFORT}"
OPTIONS="${OPTIONS} -DUSE_FFTW3=ON"
OPTIONS="${OPTIONS} -DUSE_OPENMP=ON"
OPTIONS="${OPTIONS} -DUSE_HDF5=ON"
OPTIONS="${OPTIONS} -DBUILD_PYTHON=ON"
OPTIONS="${OPTIONS} -DUSE_THREADS=ON"
OPTIONS="${OPTIONS} -DCXX11=ON"

cd $SOURCE_DIR
mkdir build && cd build
cmake .. ${OPTIONS}
make -j 8
make install 
