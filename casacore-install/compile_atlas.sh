#!/bin/bash

#PBS -P RCHPC
#PBS -N atlas_compiling
#PBS -q serial
#PBS -l select=1:ncpus=24
#PBS -l walltime=02:00:00
#PBS -o /mnt/lustre/users/smasoka/compiling/atlas_compiling.out
#PBS -e /mnt/lustre/users/smasoka/compiling/atlas_compiling.err
#PBS -m abe
#PBS -M sakhile.harvey@gmail.com

module load chpc/astro/gcc/8.3.0

VERSION=3.10.3
SOURCE_DIR=/apps/chpc/astro/casacore-3.2.0/source_dir/ATLAS-${VERSION}
INSTALL_PREFIX=/apps/chpc/astro/atlas/${VERSION}
lapack_tar=/apps/chpc/astro/casacore-3.2.0/source_dir/lapack-3.6.1.tgz

echo "Version : $VERSION"
echo "Source Directory: $SOURCE_DIR"
echo "Install Prefix: $INSTALL_PREFIX"

cd $SOURCE_DIR
mkdir build
cd build
../configure -b 64 -D c -DPentiumCPS=1199 --shared --prefix=${INSTALL_PREFIX} --with-netlib-lapack-tarfile=${lapack_tar}
make -j 4 
make install
