#!/bin/bash

#PBS -P RCHPC
#PBS -N cfitsio_compiling
#PBS -q serial
#PBS -l select=1:ncpus=24
#PBS -l walltime=01:00:00
#PBS -o /mnt/lustre/users/smasoka/compiling/cfitsio_compiling.out
#PBS -e /mnt/lustre/users/smasoka/compiling/cfitsio_compiling.err
#PBS -m abe
#PBS -M sakhile.harvey@gmail.com

module load chpc/astro/gcc/8.3.0

VERSION=3.47
SOURCE_DIR=/apps/chpc/astro/casacore-3.2.0/source_dir/cfitsio-${VERSION}
INSTALL_PREFIX=/apps/chpc/astro/cfitsio/${VERSION}

echo "Version : $VERSION"
echo "Source Directory: $SOURCE_DIR"
echo "Install Prefix: $INSTALL_PREFIX"

cd $SOURCE_DIR
./configure --prefix=${INSTALL_PREFIX}
make 
make install
