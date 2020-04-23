#!/bin/bash

#PBS -P RCHPC
#PBS -N wcslib_compiling
#PBS -q serial
#PBS -l select=1:ncpus=24
#PBS -l walltime=01:00:00
#PBS -o /mnt/lustre/users/smasoka/compiling/wcslib_compiling.out
#PBS -e /mnt/lustre/users/smasoka/compiling/wcslib_compiling.err
#PBS -m abe
#PBS -M sakhile.harvey@gmail.com

module load chpc/astro/gcc/8.3.0

VERSION=6.4
SOURCE_DIR=/apps/chpc/astro/casacore-3.2.0/source_dir/wcslib-${VERSION}
INSTALL_PREFIX=/apps/chpc/astro/wcslib/${VERSION}

# cfitsio dirs
cfitsiolib=/apps/chpc/astro/cfitsio/3.47/lib
cfitsioinc=/apps/chpc/astro/cfitsio/3.47/include

echo "Version : $VERSION"
echo "Source Directory: $SOURCE_DIR"
echo "Install Prefix: $INSTALL_PREFIX"

cd $SOURCE_DIR
./configure --prefix=${INSTALL_PREFIX} --with-cfitsiolib=${cfitsiolib} --with-cfitsioinc=${cfitsioinc} --without-pgplot
gmake 
gmake install
