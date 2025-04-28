
SETUP_DIR=~/zsh-setup-tmp
INSTALLATION_PATH=$HOME/.local

export CXXFLAGS=" -fPIC"
export CFLAGS=" -fPIC"

mkdir $SETUP_DIR
cd $SETUP_DIR 

git clone https://github.com/mirror/ncurses
cd ncurses
./configure --enable-shared --prefix=$INSTALLATION_PATH
make 
make check
make install

export PATH=$INSTALLATION_PATH/bin/:$PATH
export LD_LIBRARY_PATH=$INSTALLATION_PATH/lib:$LD_LIBRARY_PATH
export CFLAGS=-I$INSTALLATION_PATH/include
export CPPFLAGS="-I$INSTALLATION_PATH/include"
export LDFLAGS="-L$INSTALLATION_PATH/lib"

cd $SETUP_DIR

wget https://www.zsh.org/pub/zsh-5.9.tar.xz
tar xf zsh-5.9.tar.xz
cd zsh-5.9
./Util/preconfig
./configure --enable-shared --prefix=$INSTALLATION_PATH
make
make check
make install
make install.info

rm -rf $SETUP_DIR

