#!/bin/bash

#PBS -P RCHPC
#PBS -N boost_compiling
#PBS -q serial
#PBS -l select=1:ncpus=24
#PBS -l walltime=01:00:00
#PBS -o /mnt/lustre/users/smasoka/compiling/boost_compiling.out
#PBS -e /mnt/lustre/users/smasoka/compiling/boost_compiling.err
#PBS -m abe
#PBS -M sakhile.harvey@gmail.com

module load chpc/astro/gcc/8.3.0
module load chpc/astro/anaconda/3

VERSION=1.71.0
SOURCE_DIR=/apps/chpc/astro/casacore-3.2.0/source_dir/boost-${VERSION}
INSTALL_PREFIX=/apps/chpc/astro/boost/${VERSION}

echo "Version : $VERSION"
echo "Source Directory: $SOURCE_DIR"
echo "Install Prefix: $INSTALL_PREFIX"

cd $SOURCE_DIR
./bootstrap.sh --prefix=${INSTALL_PREFIX} --with-python=/apps/chpc/astro/anaconda3/bin/python --with-python-root=/apps/chpc/astro/anaconda3 --with-python-version=3.7 --with-toolset=gcc
./b2 toolset=gcc install
