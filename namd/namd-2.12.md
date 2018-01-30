```
$ cd NAMD_2.12_Source
$ tar xvf charm-6.7.1.tar
$ cd charm-6.7.1
$ ./build charm++ mpi-linux-x86_64 smp mpicxx --with-production -DCMK_OPTMIZE -DMPICH_IGNORE_CXX_SEEK

$ vi arch/Linux-x86_64.fftw
FFTDIR=/WORK/app/fftw/3.3.4-single-avx-sse2
FFTINCL=-I$(FFTDIR)/include
FFTLIB=-L$(FFTDIR)/lib -lfftw3f
FFTFLAGS=-DNAMD_FFTW
FFT=$(FFTINCL) $(FFTFLAGS)

$ vi arch/Linux-x86_64.tcl 

#TCLDIR=/Projects/namd2/tcl/tcl8.5.9-linux-x86_64
TCLDIR=/WORK/app/TCL/8.5.11
TCLINCL=-I$(TCLDIR)/include
#TCLLIB=-L$(TCLDIR)/lib -ltcl8.5 -ldl
TCLLIB=-L$(TCLDIR)/lib -ltcl8.5 -ldl -lpthread
TCLFLAGS=-DNAMD_TCL
TCL=$(TCLINCL) $(TCLFLAGS)

$vi 
$ ./config Linux-x86_64-icc --with-fftw --charm-arch mpi-linux-x86_64-smp-mpicxx
$ vi Make.charm
# CHARMBASE = /HOME/nscc_ts_1/tars/NAMD_2.12_Source/charm-6.7.1
$ cd Linux-x86_64-icc
$ make
```
