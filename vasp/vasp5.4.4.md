# 1.Folder structure
```
$pwd
~/sf_box/vasp.5.4.4
$ tree 
.
|-- README
|-- arch
|   |-- makefile.include.linux_gnu
|   |-- makefile.include.linux_intel
|   |-- makefile.include.linux_intel_serial
|   `-- makefile.include.linux_pgi
|-- bin
|-- build
|-- makefile
`-- src
    |-- CUDA
    |   |-- Makefile
    |   |-- Makefile_CUDASDK
    |   |-- Makefile_CUDASDK_TAU
    |   |-- Operator.h
    |   |-- common.mk
    |   |-- cub
    |   |   |-- block
    |   |   |   |-- block_raking_layout.cuh
    |   |   |   |-- block_reduce.cuh
    |   |   |   `-- specializations
    |   |   |       |-- block_reduce_raking.cuh
    |   |   |       |-- block_reduce_raking_commutative_only.cuh
    |   |   |       `-- block_reduce_warp_reductions.cuh
    |   |   |-- thread
    |   |   |   |-- thread_load.cuh
    |   |   |   |-- thread_operators.cuh
    |   |   |   |-- thread_reduce.cuh
    |   |   |   `-- thread_store.cuh
    |   |   |-- util_arch.cuh
    |   |   |-- util_debug.cuh
    |   |   |-- util_macro.cuh
    |   |   |-- util_namespace.cuh
    |   |   |-- util_ptx.cuh
    |   |   |-- util_type.cuh
    |   |   `-- warp
    |   |       |-- specializations
    |   |       |   |-- warp_reduce_shfl.cuh
    |   |       |   `-- warp_reduce_smem.cuh
    |   |       `-- warp_reduce.cuh
    |   |-- cublasP.h
  ...
    |   |-- kernels.h
    |   |-- local_contribution.h
    |   |-- magma.c
    |   |-- magma_zheevd.cpp
    |   |-- mpi.cu
    |   |-- nonlr.cu
    |   |-- potlok.cu
    |   `-- rmm-diis.cu
    |-- LDApU.F
    |-- Lebedev-Laikov.F
    |-- README
    |-- acfdt.F
    ...
    |-- fft3dlib.F
    |-- fft3dlib_f77.F
    |-- fft3dnec.F
    |-- fft3dsimple.F
    |-- fft3dsimple_gpu.F
    |-- fftlib
    |   |-- LICENSE
    |   |-- README.md
    |   |-- howto.txt
    |   |-- include
    |   |   `-- fftlib
    |   |       |-- fftlib.hpp
    |   |       |-- fftlib_configuration.hpp
    |   |       |-- fftlib_configuration_implementation.hpp
    |   |       |-- fftlib_constants.hpp
    |   |       |-- fftlib_dynamic_lib.hpp
    |   |       |-- fftlib_dynamic_lib_implementation.hpp
    |   |       |-- fftlib_dynamic_lib_implementation_fftw.hpp
    |   |       |-- fftlib_ext_plan.hpp
    |   |       |-- fftlib_ext_plan_implementation.hpp
    |   |       |-- fftlib_implementation.hpp
    |   |       |-- fftlib_macros.hpp
    |   |       |-- fftlib_plan.hpp
    |   |       |-- fftlib_plan_implementation.hpp
    |   |       |-- fftlib_reader_writer_lock.hpp
    |   |       |-- fftlib_reader_writer_lock_implementation.hpp
    |   |       `-- fftlib_types.hpp
    |   |-- makefile
    |   `-- src
    |       `-- fftlib.cpp
    |-- fftmpi.F
    |-- fftmpi_map.F
   ...
    |   |-- timing.c
    |   |-- timing.fujitsu.F
    |   |-- timing_.c
    |   `-- timing_ds20.c
    |-- linear_optics.F
    |-- linear_response.F
    |-- linear_response_NMR.F
    |-- local_field.F
 ..
    |-- param.inc
    |-- pardens.F
    |-- parsD3.inc
    |-- parser
    |   |-- basis.cpp
    |   |-- basis.hpp
    |   |-- call_from_fortran.F90
    |   |-- functions.cpp
    |   |-- functions.hpp
    |   |-- lex.yy.c
    |   |-- locproj.l
    |   |-- locproj.tab.c
    |   |-- locproj.tab.h
    |   |-- locproj.y
    |   |-- makefile
    |   |-- radial.cpp
    |   |-- radial.hpp
    |   |-- sites.cpp
    |   |-- sites.hpp
    |   `-- yywrap.c
    |-- paw.F
    |-- paw_base.F
    |-- pawfock.F
    |-- pawlhf.F
    |-- pawsym.F
...
    |-- xclib_grad_gpu.F
    |-- xcspin.F
    |-- xml.F
    |-- xml_writer.F
    `-- zgemmtest.F
 
17 directories, 378 files
```

# 2.Compile
```
$pwd
~/sf_box/vasp.5.4.4
$cp arch/makefile.include.linux_intel makefile.include
$vi makefile.include # modefy the MKL path and lib
```
```
# Precompiler options
CPP_OPTIONS= -DHOST=\"LinuxIFC\"\
             -DMPI -DMPI_BLOCK=8000 \
             -Duse_collective \
             -DscaLAPACK \
             -DCACHE_SIZE=4000 \
             -Davoidalloc \
             -Duse_bse_te \
 
CPP        = fpp -f_com=no -free -w0  $*$(FUFFIX) $*$(SUFFIX) $(CPP_OPTIONS)
 
FC         = mpif90
FCL        = mpif90 -mkl=sequential -lstdc++
 
FREE       = -free -names lowercase
 
FFLAGS     = -assume byterecl -w
OFLAG      = -O2
OFLAG_IN   = $(OFLAG)
DEBUG      = -O0
 
MKLROOT    =/HOME/intel/composer_xe_2013_sp1.2.144/mkl
MKL_PATH   = $(MKLROOT)/lib/intel64
BLAS       =-L$(MKL_PATH) -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread
LAPACK     =-L$(MKL_PATH) -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread
#BLACS      = -lmkl_blacs_intelmpi_lp64
BLACS      =-L$(MKL_PATH) -lmkl_blacs_intelmpi_lp64 -lmkl_blacs_openmpi_lp64
SCALAPACK  = $(MKL_PATH)/libmkl_scalapack_lp64.a $(MKL_PATH)/libmkl_scalapack_ilp64.a $(BLACS)
 
 
INCS       =-I/WORK/app/fftw/3.3.4-double/include
 
LLIBS      = $(SCALAPACK) $(LAPACK) $(BLAS)
 
 
OBJECTS_O1 += fftw3d.o fftmpi.o fftmpiw.o
OBJECTS_O2 += fft3dlib.o
 
# For what used to be vasp.5.lib
CPP_LIB    = $(CPP)
FC_LIB     = $(FC)
CC_LIB     = icc
CFLAGS_LIB = -O
FFLAGS_LIB = -O1
OBJECTS_LIB= linpack_double.o getshmem.o
 
# For the parser library
CXX_PARS   = icpc
 
LIBS       += parser
LLIBS      += -Lparser -lparser -lstdc++
 
# Normally no need to change this
SRCDIR     = ../../src
BINDIR     = ../../bin
 
#================================================
# GPU Stuff
 
CPP_GPU    = -DCUDA_GPU -DRPROMU_CPROJ_OVERLAP -DUSE_PINNED_MEMORY -DCUFFT_MIN=28 -UscaLAPACK
 
OBJECTS_GPU = fftmpiw.o fftmpi_map.o fft3dlib.o fftw3d_gpu.o fftmpiw_gpu.o
 
CC         = icc
CXX        = icpc
CFLAGS     = -fPIC -DADD_ -Wall -openmp -DMAGMA_WITH_MKL -DMAGMA_SETAFFINITY -DGPUSHMEM=300 -DHAVE_CUBLAS
 
CUDA_ROOT  ?= /usr/local/cuda/
NVCC       := $(CUDA_ROOT)/bin/nvcc -ccbin=icc
CUDA_LIB   := -L$(CUDA_ROOT)/lib64 -lnvToolsExt -lcudart -lcuda -lcufft -lcublas
 
GENCODE_ARCH    := -gencode=arch=compute_30,code=\"sm_30,compute_30\" \
                   -gencode=arch=compute_35,code=\"sm_35,compute_35\" \
                   -gencode=arch=compute_60,code=\"sm_60,compute_60\"
 
MPI_INC    = $(I_MPI_ROOT)/include64/
```

```
$ module ava intel
```
```
------------------------------- /WORK/app/modulefiles -------------------------------
intel-compilers/11.1   intel-compilers/14.0.2 intel-compilers/mkl-14
intel-compilers/13.0.0 intel-compilers/15.0.1 intel-compilers/mkl-15
```
```
$ module load intel-compilers/mkl-14 # important when run vasp
$ make all  # waiting for serival minutes
```
```
$ ls build/   # new source code
gam  ncl  std
$ ls bin   # new execute    
vasp_gam  vasp_ncl  vasp_std
```

# 3.submit job
```
$ pwd
~/sf_box/vasp.5.4.4/bin
$ export PATH=$PWD:$PATH
$ which vasp_std
~/sf_box/vasp.5.4.4/bin/vasp_std

$cd 2_1_fccSi 
yhrun -N 1 -n 16 vasp_std

```
