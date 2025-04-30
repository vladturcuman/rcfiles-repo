#!/bin/sh
INSTALL_DIR="$HOME/.local"
BUILD_DIR="$HOME/vim-build"

export CXXFLAGS=" -fPIC"
export CFLAGS=" -fPIC"

mkdir $BUILD_DIR
cd $BUILD_DIR 

git clone https://github.com/mirror/ncurses
cd ncurses
./configure --enable-shared --prefix=$INSTALL_DIR
make 
make check
make install

export PATH=$INSTALL_DIR/bin/:$PATH
export LD_LIBRARY_PATH=$INSTALL_DIR/lib:$LD_LIBRARY_PATH
export CFLAGS=-I$INSTALL_DIR/include
export CPPFLAGS="-I$INSTALL_DIR/include"
export LDFLAGS="-L$INSTALL_DIR/lib"

mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"


PY_VER=3.11.7
curl -LO https://www.python.org/ftp/python/${PY_VER}/Python-${PY_VER}.tar.xz
tar xJf Python-${PY_VER}.tar.xz
cd Python-${PY_VER}

./configure --prefix=$HOME/.local \
            --enable-optimizations \
            --enable-shared
make -j$(nproc)
make install
cd ..

git clone --depth 1 https://github.com/vim/vim.git
cd vim

echo "Configuring Vim build..."
./configure \
  --prefix="$INSTALL_DIR" \
  --with-features=huge \
  --enable-multibyte \
  --enable-python3interp=yes \
  --with-python3-command=$HOME/.local/bin/python3 \
  --without-x \
  --enable-gui=auto \
  --enable-cscope
make install

cd ~ && rm -rf "$BUILD_DIR"

