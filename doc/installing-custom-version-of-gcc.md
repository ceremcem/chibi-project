If you need to install a custom version of GCC¹, follow the steps:

```sh
# based on https://stackoverflow.com/a/10662297/1952991
# download the GCC tarball from https://gcc.gnu.org/releases.html
VERSION="5.4.0"
tar xzf gcc-$VERSION.tar.gz
cd gcc-$VERSION
./contrib/download_prerequisites
cd ..
mkdir objdir
cd objdir
../gcc-$VERSION/configure --prefix=$HOME/GCC-$VERSION
#                   --disable-multilib --enable-languages=c,c++  # in my case
unset LIBRARY_PATH CPATH C_INCLUDE_PATH PKG_CONFIG_PATH CPLUS_INCLUDE_PATH INCLUDE LD_LIBRARY_PATH # Ubuntu specific
make -j3
make install
```


¹: GCC > 5.4.1 has a bug for Arm Cortex-M0 cores, so you may need to install
a custom version in such a case. See http://www.chibios.com/forum/viewtopic.php?f=16&t=5030&start=10#p35130
