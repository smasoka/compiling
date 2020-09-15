#!/bin/bash

#PBS -P RCHPC
#PBS -N node_compiling
#PBS -q serial
#PBS -l select=1:ncpus=24
#PBS -l walltime=01:00:00
#PBS -o /mnt/lustre/users/smasoka/compiling/node_compiling.out
#PBS -e /mnt/lustre/users/smasoka/compiling/node_compiling.err
#PBS -m abe
#PBS -M sakhile.harvey@gmail.com

module load chpc/astro/gcc/8.3.0
module load chpc/astro/anaconda/3

VERSION=14.10.1
SOURCE_DIR=/apps/chpc/astro/sources2/node-v${VERSION}
INSTALL_PREFIX=/apps/chpc/astro/node/${VERSION}

echo "Version : $VERSION"
echo "Source Directory: $SOURCE_DIR"
echo "Install Prefix: $INSTALL_PREFIX"

cd $SOURCE_DIR
./configure --prefix=${INSTALL_PREFIX}
make -j16
make install
