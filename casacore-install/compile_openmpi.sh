#!/bin/bash

#PBS -P RCHPC
#PBS -N openmpi_compiling
#PBS -q serial
#PBS -l select=1:ncpus=24
#PBS -l walltime=02:00:00
#PBS -o /mnt/lustre/users/smasoka/compiling/openmpi_compiling.out
#PBS -e /mnt/lustre/users/smasoka/compiling/openmpi_compiling.err
#PBS -m abe
#PBS -M sakhile.harvey@gmail.com

module load chpc/astro/gcc/8.3.0

VERSION=4.0.3
SOURCE_DIR=/apps/chpc/astro/casacore-3.2.0/source_dir/openmpi-${VERSION}
INSTALL_PREFIX=/apps/chpc/astro/openmpi/${VERSION}

echo "Version : $VERSION"
echo "Source Directory: $SOURCE_DIR"
echo "Install Prefix: $INSTALL_PREFIX"

cd $SOURCE_DIR
./configure --prefix=${INSTALL_PREFIX} --enable-mpi-fortran --with-mxm=/opt/mellanox/mxm --with-fca=/opt/mellanox/fca --with-tm=/opt/pbs/default
make 
make install
