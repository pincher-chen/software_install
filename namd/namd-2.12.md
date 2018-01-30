```
$ cd NAMD_2.12_Source
$ tar xvf charm-6.7.1.tar
$ cd charm-6.7.1
$ ./build charm++ mpi-linux-x86_64 smp mpicxx --with-production -DCMK_OPTMIZE -DMPICH_IGNORE_CXX_SEEK
$ ./config Linux-x86_64-icc --charm-arch mpi-linux-x86_64-smp-mpicxx
$ vi Make.charm
# CHARMBASE = /HOME/nscc_ts_1/tars/NAMD_2.12_Source/charm-6.7.1
$ cd Linux-x86_64-icc
$ make
```
