#!/bin/bash

set -e

export PYTHON_LIBDIR="/usr/lib/x86_64-linux-gnu"
export PYTHON_LDLIBRARY=$(python -c 'from distutils import sysconfig; print(sysconfig.get_config_var("LDLIBRARY"))')
export PYTHON_LIBRARY="${PYTHON_LIBDIR}/${PYTHON_LDLIBRARY}"
export PYTHON_INCLUDE_DIR=$(python -c 'from distutils import sysconfig; print(sysconfig.get_python_inc())')
echo "PYTHON_LIBDIR = $PYTHON_LIBDIR"
echo "PYTHON_LDLIBRARY = $PYTHON_LDLIBRARY"
echo "PYTHON_LIBRARY = $PYTHON_LIBRARY"
echo "PYTHON_INCLUDE_DIR = $PYTHON_INCLUDE_DIR"

mkdir -p build &> /dev/null
cd build

cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr \
  -DRPI_INCLUDE_DIR=/opt/vc/include \
  -DRPI_LIB_DIR=/opt/vc/lib \
  -DPYTHON_LIBRARY="${PYTHON_LIBRARY}" \
  -DPYTHON_INCLUDE_DIR="${PYTHON_INCLUDE_DIR}" \
  ..

make -j4
# make install DESTDIR=/opt/libcec