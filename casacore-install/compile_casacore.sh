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

PYTHON3_LIBRARY=/apps/chpc/astro/anaconda3/lib/libpython3.7m.so
PYTHON3_EXECUTABLE=/apps/chpc/astro/anaconda3/bin/python
PYTHON3_INCLUDE_DIR=/apps/chpc/astro/anaconda3/include/python3.7m

DATA=/apps/chpc/astro/casacore-3.2.0/source_dir/data

FFTW3_DIR=/apps/chpc/astro/fftw/3.3.8
FFTW3_INCLUDE_DIR=/apps/chpc/astro/fftw/3.3.8/include

HDF5_DIR=/apps/chpc/astro/hdf5/1.10.5
HDF5_INCLUDE_DIR=/apps/chpc/astro/hdf5/1.10.5/include

CFITSIO_DIR=/apps/chpc/astro/cfitsio/3.47
CFITSIO_INCLUDE_DIR=/apps/chpc/astro/cfitsio/3.47/include
CFITSIO_LIBRARY=/apps/chpc/astro/cfitsio/3.47/lib/libcfitsio.so
WCSLIB_DIR=/apps/chpc/astro/wcslib/6.4
WCSLIB_INCLUDE_DIR=/apps/chpc/astro/wcslib/6.4/include
WCSLIB_LIBRARY=/apps/chpc/astro/wcslib/6.4/lib/libwcs.so

BLAS_DIR=/apps/chpc/astro/atlas/3.10.3
LAPACK_DIR=/apps/chpc/astro/atlas/3.10.3


echo "Version : $VERSION"
echo "Source Directory: $SOURCE_DIR"
echo "Install Prefix: $INSTALL_PREFIX"

OPTIONS=""
OPTIONS="${OPTIONS} -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX}"
OPTIONS="${OPTIONS} -DUSE_FFTW3=ON"
OPTIONS="${OPTIONS} -DFFTW3_ROOT_DIR=${FFTW3_DIR}"
OPTIONS="${OPTIONS} -DFFTW3_INCLUDE_DIR=${FFTW3_INCLUDE_DIR}"
OPTIONS="${OPTIONS} -DUSE_HDF5=ON"
OPTIONS="${OPTIONS} -DHDF5_ROOT_DIR={$HDF5_DIR}"
OPTIONS="${OPTIONS} -DHDF5_INCLUDE_DIR={$HDF5_INCLUDE_DIR}"
OPTIONS="${OPTIONS} -DBUILD_PYTHON3=ON"
OPTIONS="${OPTIONS} -DPYTHON3_LIBRARY=${PYTHON3_LIBRARY}"
OPTIONS="${OPTIONS} -DPYTHON3_EXECUTABLE=${PYTHON3_EXECUTABLE} "
OPTIONS="${OPTIONS} -DPYTHON3_INCLUDE_DIR=${PYTHON3_INCLUDE_DIR}"
OPTIONS="${OPTIONS} -DBUILD_PYTHON=OFF"
OPTIONS="${OPTIONS} -DUSE_THREADS=ON"
OPTIONS="${OPTIONS} -DBLAS_ROOT_DIR=${BLAS_DIR}"
OPTIONS="${OPTIONS} -DLAPACK_ROOT_DIR=${LAPACK_DIR}"
OPTIONS="${OPTIONS} -DCFITSIO_ROOT_DIR=${CFITSIO_DIR}"
OPTIONS="${OPTIONS} -DCFITSIO_INCLUDE_DIR=${CFITSIO_INCLUDE_DIR}"
OPTIONS="${OPTIONS} -DCFITSIO_LIBRARY=${CFITSIO_LIBRARY}"
OPTIONS="${OPTIONS} -DWCSLIB_ROOT_DIR=${WCSLIB_DIR}"
OPTIONS="${OPTIONS} -DWCSLIB_INCLUDE_DIR=${WCSLIB_INCLUDE_DIR}"
OPTIONS="${OPTIONS} -DWCSLIB_LIBRARY=${WCSLIB_LIBRARY}"
OPTIONS="${OPTIONS} -DDATA_DIR=${DATA}"

cd $SOURCE_DIR
rm -rf build && mkdir build && cd build
cmake ${OPTIONS} ..
make -j 8
make install 
