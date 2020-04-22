#!/bin/bash

#PBS -P RCHPC
#PBS -N hdf5_compiling
#PBS -q serial
#PBS -l select=1:ncpus=24
#PBS -l walltime=01:00:00
#PBS -o /mnt/lustre/users/smasoka/compiling/hdf5_compiling.out
#PBS -e /mnt/lustre/users/smasoka/compiling/hdf5_compiling.err
#PBS -m abe
#PBS -M sakhile.harvey@gmail.com

module load chpc/astro/gcc/8.3.0
module load chpc/astro/openmpi/4.0.3

VERSION=1.10.5
SOURCE_DIR=/apps/chpc/astro/casacore-3.2.0/source_dir/hdf5-${VERSION}
INSTALL_PREFIX=/apps/chpc/astro/hdf5/${VERSION}

echo "Version : $VERSION"
echo "Source Directory: $SOURCE_DIR"
echo "Install Prefix: $INSTALL_PREFIX"

cd $SOURCE_DIR
./configure --prefix=${INSTALL_PREFIX} --enable-parallel
make -j 4 
make install
