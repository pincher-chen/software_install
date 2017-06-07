
# 1. How to install
download URL:http://www.shengbte.org/downloads/thirdorder-v1.0.2-24508d0.tar.bz2?attredirects=0&d=1

## install spglib
```
$ git clone https://github.com/atztogo/spglib.git
$ cd spglib
$ mkdir build 
$ cmake ..
$ make 
$ make install # then lib and include occured.
```

## install python package
```
$ source /WORK/app/toolshs/setproxy.sh 12.10.133.131
$ module load Python/2.7.10-fPIC
$ pip install --user numpy
$ pip install --user scipy
$ pip install --user spglib
```

## compile thirdorder
```
$ vi  thirdorder_core.c  # modefy include  "spglib/spglib.h" with include "/WORK/app/spglib/1.9.8/include/spglib.h"
$ vi setup.py  # modefy tow lines:
INCLUDE_DIRS=["/WORK/app/spglib/1.9.8/include"]
INCLUDE_DIRS=["/WORK/app/spglib/1.9.8/include"]

$ module load Python/2.7.10-fPIC
$ python setup.py build --build-lib=. --build-platlib=.
running build
running build_ext
building 'thirdorder_core' extension
gcc -pthread -fno-strict-aliasing -fPIC -DNDEBUG -g -fwrapv -O3 -Wall -Wstrict-prototypes -fPIC -I/WORK/app/Python/2.7.10-fPIC/lib/python2.7/site-packages/numpy/core/include -I/WORK/app/spglib/1.9.8/include -I/WORK/app/Python/2.7.10-fPIC/include/python2.7 -c thirdorder_core.c -o build/temp.linux-x86_64-2.7/thirdorder_core.o
In file included from /WORK/app/Python/2.7.10-fPIC/lib/python2.7/site-packages/numpy/core/include/numpy/ndarraytypes.h:1804,
                 from /WORK/app/Python/2.7.10-fPIC/lib/python2.7/site-packages/numpy/core/include/numpy/ndarrayobject.h:17,
                 from /WORK/app/Python/2.7.10-fPIC/lib/python2.7/site-packages/numpy/core/include/numpy/arrayobject.h:4,
                 from thirdorder_core.c:353:
/WORK/app/Python/2.7.10-fPIC/lib/python2.7/site-packages/numpy/core/include/numpy/npy_1_7_deprecated_api.h:15:2: warning: #warning "Using deprecated NumPy API, disable it by " "#defining NPY_NO_DEPRECATED_API NPY_1_7_API_VERSION"
/WORK/app/Python/2.7.10-fPIC/lib/python2.7/site-packages/numpy/core/include/numpy/__ufunc_api.h:241: warning: ?.import_umath?.defined but not used
gcc -pthread -shared build/temp.linux-x86_64-2.7/thirdorder_core.o -L/WORK/app/spglib/1.9.8/lib -Wl,-R/WORK/app/spglib/1.9.8/lib -lsymspg -o ./thirdorder_core.so
$ ls
build                 LICENSE    thirdorder_common.py  thirdorder_core.so
compile.sh            README.md  thirdorder_core.c     thirdorder_espresso.py
cthirdorder_core.pxd  setup.py   thirdorder_core.pyx   thirdorder_vasp.py
```
# 2. Running
```
$ mkdir test;cd test
$ cp /WORK/app/share/vasp_makefile/2_1_fccSi.tgz .
$ tar xzvf 2_1_fccSi.tgz
$ cd 2_1_fccSi
$ ../../thirdorder_vasp.py sow 3 3 2 -1
Reading POSCAR
Analyzing the symmetries
- Symmetry group Fm-3m detected
- 48 symmetry operations
Creating the supercell
Computing all distances in the supercell
- Automatic cutoff: 0.332885822331 nm
Looking for an irreducible set of third-order IFCs
- 3 triplet equivalence classes found
- 32 DFT runs are needed

.d88888b   .88888.  dP   dP   dP
88.    "' d8'   `8b 88   88   88
`Y88888b. 88     88 88  .8P  .8P
      `8b 88     88 88  d8'  d8'
d8'   .8P Y8.   .8P 88.d8P8.d8P
 Y88888P   `8888P'  8888' Y88'
ooooooooooooooooooooooooooooooooo

Writing undisplaced coordinates to 3RD.SPOSCAR
Writing displaced coordinates to 3RD.POSCAR.*

888888ba   .88888.  888888ba   88888888b
88    `8b d8'   `8b 88    `8b  88
88     88 88     88 88     88 a88aaaa
88     88 88     88 88     88  88
88    .8P Y8.   .8P 88     88  88
8888888P   `8888P'  dP     dP  88888888P
ooooooooooooooooooooooooooooooooooooooooo
```
