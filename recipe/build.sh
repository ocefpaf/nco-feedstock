#!/bin/bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./autobld

if [[ $(uname) == Darwin ]]; then
  ARGS="--disable-openmp --enable-regex --disable-shared --disable-doc"
elif [[ $(uname) == Linux ]]; then
  ARGS="--enable-openmp --disable-dependency-tracking"
fi

export HAVE_ANTLR=yes
export HAVE_NETCDF4_H=yes
export NETCDF_ROOT=$PREFIX

./configure --prefix=$PREFIX $ARGS

make -j$CPU_COUNT
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
make check
fi
make install
