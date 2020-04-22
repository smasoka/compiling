#!/bin/bash

#PBS -P RCHPC
#PBS -N bison_compiling
#PBS -q serial
#PBS -l select=1:ncpus=24
#PBS -l walltime=01:00:00
#PBS -o /mnt/lustre/users/smasoka/compiling/bison_compiling.out
#PBS -e /mnt/lustre/users/smasoka/compiling/bison_compiling.err
#PBS -m abe
#PBS -M sakhile.harvey@gmail.com

module load chpc/astro/gcc/8.3.0

VERSION=3.4
SOURCE_DIR=/apps/chpc/astro/casacore-3.2.0/source_dir/bison-${VERSION}
INSTALL_PREFIX=/apps/chpc/astro/bison/${VERSION}

echo "Version : $VERSION"
echo "Source Directory: $SOURCE_DIR"
echo "Install Prefix: $INSTALL_PREFIX"

cd $SOURCE_DIR
./configure --prefix=${INSTALL_PREFIX}
make 
make install
