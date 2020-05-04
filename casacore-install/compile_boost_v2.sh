#!/bin/bash

#PBS -P RCHPC
#PBS -N boost_compiling_v2
#PBS -q serial
#PBS -l select=1:ncpus=24
#PBS -l walltime=04:00:00
#PBS -o /mnt/lustre/users/smasoka/compiling/boost_v2_compiling.out
#PBS -e /mnt/lustre/users/smasoka/compiling/boost_v2_compiling.err
#PBS -m abe
#PBS -M sakhile.harvey@gmail.com

module load chpc/astro/gcc/8.3.0
module load chpc/astro/anaconda/3

VERSION=1.67.0
SOURCE_DIR=/apps/chpc/astro/casacore-3.2.0/source_dir/boost-${VERSION}
INSTALL_PREFIX=/apps/chpc/astro/boost/${VERSION}

echo "Version : $VERSION"
echo "Source Directory: $SOURCE_DIR"
echo "Install Prefix: $INSTALL_PREFIX"

cd /apps/chpc/astro/casacore-3.2.0/source_dir
tar zxvf boost_1_67_0.tar.gz
mv boost_1_67_0 boost-1.67.0
cd $SOURCE_DIR
./bootstrap.sh --prefix=${INSTALL_PREFIX} --with-python=/apps/chpc/astro/anaconda3/bin/python3 --with-python-root=/apps/chpc/astro/anaconda3 --with-python-version=3.7 --with-toolset=gcc --with-libraries=all 
./b2 toolset=gcc install

#####################################################################################################
# Make sure to soft link '..../anaconda3/include/python3.7m' to '..../anaconda3/include/python3.7"  #
# Boost 1.67 (maybe others as well) searches for headers in 'python3.7'                             #
#####################################################################################################

# Instsead of all, you can specify --with-libraries=python
# Or use ./b2 --with-libraries=python install

# Boost and Cmake are like siblings, but they fight a lot

