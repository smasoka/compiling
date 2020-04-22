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
module load chpc/astro/bison/3.4
module load chpc/astro/cfitsio/3.47
module load chpc/astro/wcslib/6.4
module load chpc/astro/fftw/3.3.8
module load chpc/astro/openmpi/4.0.3
module load chpc/astro/hdf5/1.10.5
module load chpc/astro/atlas/3.10.3
module load chpc/astro/boost/1.71.0

VERSION=3.2.1
SOURCE_DIR=/apps/chpc/astro/casacore-3.2.0/source_dir/casacore-${VERSION}
INSTALL_PREFIX=/apps/chpc/astro/casacore/${VERSION}
DATA=/apps/chpc/astro/casacore-3.2.0/source_dir/data

echo "Version : $VERSION"
echo "Source Directory: $SOURCE_DIR"
echo "Install Prefix: $INSTALL_PREFIX"

OPTIONS=""
OPTIONS="${OPTIONS} -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX}"
OPTIONS="${OPTIONS} -DUSE_FFTW3=ON"
OPTIONS="${OPTIONS} -DUSE_OPENMP=ON"
OPTIONS="${OPTIONS} -DUSE_HDF5=ON"
OPTIONS="${OPTIONS} -DBUILD_PYTHON3=ON"
OPTIONS="${OPTIONS} -DPYTHON3_LIBRARY=/apps/chpc/astro/anaconda3/lib/libpython3.7m.so"
OPTIONS="${OPTIONS} -DPYTHON3_EXECUTABLE=/apps/chpc/astro/anaconda3/bin/python "
OPTIONS="${OPTIONS} -DPYTHON3_INCLUDE_DIR=/apps/chpc/astro/anaconda3/include"
OPTIONS="${OPTIONS} -DBUILD_PYTHON=OFF"
OPTIONS="${OPTIONS} -DUSE_THREADS=ON"
OPTIONS="${OPTIONS} -DDATA_DIR=${DATA}"

cd $SOURCE_DIR
mkdir build && cd build
cmake ${OPTIONS} ..
make -j 8
make install 
