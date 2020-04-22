#!/bin/bash

#PBS -P RCHPC
#PBS -N gcc_compiling
#PBS -q serial
#PBS -l select=1:ncpus=24
#PBS -l walltime=03:00:00
#PBS -o /mnt/lustre/users/smasoka/compiling/gcc_compiling.out
#PBS -e /mnt/lustre/users/smasoka/compiling/gcc_compiling.err
#PBS -m abe
#PBS -M sakhile.harvey@gmail.com

VERSION=8.3.0
SOURCE_DIR=/apps/chpc/astro/casacore-3.2.0/source_dir/gcc-8.3.0/gcc_build
INSTALL_PREFIX=/apps/chpc/astro/gcc/${VERSION}

echo "GCC Version : $VERSION"
echo "Source Directory: $SOURCE_DIR"
echo "Install Prefix: $INSTALL_PREFIX"

cd $SOURCE_DIR
../configure --prefix=${INSTALL_PREFIX}
make -j 8
make install
