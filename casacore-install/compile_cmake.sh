#!/bin/bash

#PBS -P RCHPC
#PBS -N cmake_compiling
#PBS -q serial
#PBS -l select=1:ncpus=24
#PBS -l walltime=02:00:00
#PBS -o /mnt/lustre/users/smasoka/compiling/cmake_compiling.out
#PBS -e /mnt/lustre/users/smasoka/compiling/cmake_compiling.err
#PBS -m abe
#PBS -M sakhile.harvey@gmail.com

module load chpc/astro/gcc/8.3.0

VERSION=3.15.6
SOURCE_DIR=/apps/chpc/astro/casacore-3.2.0/source_dir/cmake-${VERSION}
INSTALL_PREFIX=/apps/chpc/astro/cmake/${VERSION}

echo "CMAKE Version : $VERSION"
echo "Source Directory: $SOURCE_DIR"
echo "Install Prefix: $INSTALL_PREFIX"

cd $SOURCE_DIR
./bootstrap --prefix=${INSTALL_PREFIX}
make -j 4
make install
