
====== LAMMPS ======



===== 1.简介 =====
Large-scale Atomic/Molecular Massively Parallel Simulator（LAMMPS），经典分子动力学软件包。可以对在液态、固态或者气态的状态下的粒子系综进行建模，可以建模原子、有机分子、生物分子、金属或者粗粒子系统，可以在不同的力场和边界条件下进行系统建模。

===== 2.使用方法 =====


加载方法：
<code make>
module ava #查看所有软件
module load lammps$TAB键  
module load lammps/17Feb16 #加载软件
module list #查看已安装的软件
module unload lammps/9Dec14-mic
module help lammps/17Feb16 #查看所安装的包
</code>

任务提交脚本：
<code bash>
##job.sh
#！/bin/bash

yhrun -N 1 -n 24 lmp_intel_cpu < in.test
</code>

任务提交命令：
<code make>
yhbatch -p training -N 1 -n 24 ./job.sh
</code>

===== 3.编译方法 =====

**step 1**:选择编译包 \\
<code bash>
cp  /WORK/app/share/lammps-17Feb16.tar.gz . 
tar xvf lammps-17Feb16.tar.gz
cd lammps-17Feb16/src
make package-status
</code> 
如有必要，需先编译lib文件夹下的库文件 \\ 
<code make>
make yes-ASPHERE yes-CLASS2 yes-KSPACE yes-MPIIO yes-USER-OMP yes-USER-SPH
</code>

**step 1**直接拷贝： \\ 
<code make>
 cp /WORK/app/lammps/17Feb16/Makefile.intel_cpu src/MAKE
</code>
或修改Makefile.intel_cpu文件，对于atomistica的makefile.intel_cpu_atomistica参考(注意下面atomistica的实际路径根据自己的路径进行修改)：
<code make>
# intel_cpu = USER-INTEL package with CPU optimizations, Intel MPI, MKL FFT

SHELL = /bin/sh

# ---------------------------------------------------------------------
# compiler/linker settings
# specify flags and libraries needed for your compiler

CC =		mpicxx 
CCFLAGS =	-g -O3 -openmp -DLAMMPS_MEMALIGN=64 -no-offload \
                -xHost -fno-alias -ansi-alias -restrict -override-limits
SHFLAGS =	-fPIC
DEPFLAGS =	-M

LINK =		mpicxx
LINKFLAGS =	-g -O3 -openmp -xHost
LIB =           
SIZE =		size

ARCHIVE =	ar
ARFLAGS =	-rc
SHLIBFLAGS =	-shared

# ---------------------------------------------------------------------
# LAMMPS-specific settings, all OPTIONAL
# specify settings for LAMMPS features you will use
# if you change any -D setting, do full re-compile after "make clean"

# LAMMPS ifdef settings
# see possible settings in Section 2.2 (step 4) of manual

LMP_INC =	-DLAMMPS_GZIP -DLAMMPS_JPEG

# MPI library
# see discussion in Section 2.2 (step 5) of manual
# MPI wrapper compiler/linker can provide this info
# can point to dummy MPI library in src/STUBS as in Makefile.serial
# use -D MPICH and OMPI settings in INC to avoid C++ lib conflicts
# INC = path for mpi.h, MPI compiler settings
# PATH = path for MPI library
# LIB = name of MPI library

MPI_INC =       -DMPICH_SKIP_MPICXX -DOMPI_SKIP_MPICXX=1 -I/usr/local/mpi3-dynamic/include
MPI_PATH =      -L/usr/local/mpi3-dynamic/lib
MPI_LIB =       -lmpich -lmpl -lopa -lfmpich -lmpichcxx


# FFT library
# see discussion in Section 2.2 (step 6) of manaul
# can be left blank to use provided KISS FFT library
# INC = -DFFT setting, e.g. -DFFT_FFTW, FFT compiler settings
# PATH = path for FFT library
# LIB = name of FFT library

MKL_ROOT=/HOME/intel/composer_xe_2013_sp1.2.144/mkl
FFT_INC =       -DFFT_MKL -DFFT_SINGLE -I${MKL_ROOT}/include/fftw -I/HOME/nscc_ts_1/tars/chenpin/lammps-31Mar17/lib/atomistica/src/support -I/HOME/nscc_ts_1/tars/chenpin/lammps-31Mar17/lib/atomistica/build_lammps
FFT_PATH = 
FFT_LIB =       -L${MKL_ROOT}/lib/intel64/ -lmkl_intel_ilp64 \
                -lmkl_intel_thread -lmkl_core	/HOME/nscc_ts_1/tars/chenpin/lammps-31Mar17/lib/atomistica/build_lammps/libatomistica.a

# JPEG and/or PNG library
# see discussion in Section 2.2 (step 7) of manual
# only needed if -DLAMMPS_JPEG or -DLAMMPS_PNG listed with LMP_INC
# INC = path(s) for jpeglib.h and/or png.h
# PATH = path(s) for JPEG library and/or PNG library
# LIB = name(s) of JPEG library and/or PNG library

JPG_INC =       
JPG_PATH = 	
JPG_LIB =	-ljpeg

# ---------------------------------------------------------------------
# build rules and dependencies
# do not edit this section

include	Makefile.package.settings
include	Makefile.package

EXTRA_INC = $(LMP_INC) $(PKG_INC) $(MPI_INC) $(FFT_INC) $(JPG_INC) $(PKG_SYSINC)
EXTRA_PATH = $(PKG_PATH) $(MPI_PATH) $(FFT_PATH) $(JPG_PATH) $(PKG_SYSPATH)
EXTRA_LIB = $(PKG_LIB) $(MPI_LIB) $(FFT_LIB) $(JPG_LIB) $(PKG_SYSLIB)

# Path to src files

vpath %.cpp ..
vpath %.h ..

# Link target

$(EXE):	$(OBJ)
	$(LINK) $(LINKFLAGS) $(EXTRA_PATH) $(OBJ) $(EXTRA_LIB) $(LIB) -o $(EXE)
	$(SIZE) $(EXE)

# Library targets

lib:	$(OBJ)
	$(ARCHIVE) $(ARFLAGS) $(EXE) $(OBJ)

shlib:	$(OBJ)
	$(CC) $(CCFLAGS) $(SHFLAGS) $(SHLIBFLAGS) $(EXTRA_PATH) -o $(EXE) \
        $(OBJ) $(EXTRA_LIB) $(LIB)

# Compilation rules

%.o:%.cpp
	$(CC) $(CCFLAGS) $(SHFLAGS) $(EXTRA_INC) -c $<

%.d:%.cpp
	$(CC) $(CCFLAGS) $(EXTRA_INC) $(DEPFLAGS) $< > $@

%.o:%.cu
	$(CC) $(CCFLAGS) $(SHFLAGS) $(EXTRA_INC) -c $<

# Individual dependencies

DEPENDS = $(OBJ:.o=.d)
sinclude $(DEPENDS)
</code>

如果是Makefile.intel_cpu，则参考:
<code make>
# intel_cpu = USER-INTEL package with CPU optimizations, Intel MPI, MKL FFT

SHELL = /bin/sh

# ---------------------------------------------------------------------
# compiler/linker settings
# specify flags and libraries needed for your compiler

CC =		mpicxx 
CCFLAGS =	-g -O3 -openmp -DLAMMPS_MEMALIGN=64 -no-offload \
                -xHost -fno-alias -ansi-alias -restrict -override-limits
SHFLAGS =	-fPIC
DEPFLAGS =	-M

LINK =		mpicxx
LINKFLAGS =	-g -O3 -openmp -xHost
LIB =           
SIZE =		size

ARCHIVE =	ar
ARFLAGS =	-rc
SHLIBFLAGS =	-shared

# ---------------------------------------------------------------------
# LAMMPS-specific settings, all OPTIONAL
# specify settings for LAMMPS features you will use
# if you change any -D setting, do full re-compile after "make clean"

# LAMMPS ifdef settings
# see possible settings in Section 2.2 (step 4) of manual

LMP_INC =	-DLAMMPS_GZIP -DLAMMPS_JPEG

# MPI library
# see discussion in Section 2.2 (step 5) of manual
# MPI wrapper compiler/linker can provide this info
# can point to dummy MPI library in src/STUBS as in Makefile.serial
# use -D MPICH and OMPI settings in INC to avoid C++ lib conflicts
# INC = path for mpi.h, MPI compiler settings
# PATH = path for MPI library
# LIB = name of MPI library

MPI_INC =       -DMPICH_SKIP_MPICXX -DOMPI_SKIP_MPICXX=1 -I/usr/local/mpi3/include
MPI_PATH =      -L/usr/local/mpi3-dynamic/lib
MPI_LIB =       -lmpich -lmpl -lopa -lfmpich -lmpichcxx


# FFT library
# see discussion in Section 2.2 (step 6) of manaul
# can be left blank to use provided KISS FFT library
# INC = -DFFT setting, e.g. -DFFT_FFTW, FFT compiler settings
# PATH = path for FFT library
# LIB = name of FFT library

MKL_ROOT=/HOME/intel/composer_xe_2013_sp1.2.144/mkl
FFT_INC =       -DFFT_MKL -DFFT_SINGLE -I${MKL_ROOT}/include/fftw
FFT_PATH = 
FFT_LIB =       -L${MKL_ROOT}/lib/intel64/ -lmkl_intel_ilp64 \
                -lmkl_intel_thread -lmkl_core	

# JPEG and/or PNG library
# see discussion in Section 2.2 (step 7) of manual
# only needed if -DLAMMPS_JPEG or -DLAMMPS_PNG listed with LMP_INC
# INC = path(s) for jpeglib.h and/or png.h
# PATH = path(s) for JPEG library and/or PNG library
# LIB = name(s) of JPEG library and/or PNG library

JPG_INC =       
JPG_PATH = 	
JPG_LIB =	-ljpeg

# ---------------------------------------------------------------------
# build rules and dependencies
# do not edit this section

include	Makefile.package.settings
include	Makefile.package

EXTRA_INC = $(LMP_INC) $(PKG_INC) $(MPI_INC) $(FFT_INC) $(JPG_INC) $(PKG_SYSINC)
EXTRA_PATH = $(PKG_PATH) $(MPI_PATH) $(FFT_PATH) $(JPG_PATH) $(PKG_SYSPATH)
EXTRA_LIB = $(PKG_LIB) $(MPI_LIB) $(FFT_LIB) $(JPG_LIB) $(PKG_SYSLIB)

# Path to src files

vpath %.cpp ..
vpath %.h ..

# Link target

$(EXE):	$(OBJ)
	$(LINK) $(LINKFLAGS) $(EXTRA_PATH) $(OBJ) $(EXTRA_LIB) $(LIB) -o $(EXE)
	$(SIZE) $(EXE)

# Library targets

lib:	$(OBJ)
	$(ARCHIVE) $(ARFLAGS) $(EXE) $(OBJ)

shlib:	$(OBJ)
	$(CC) $(CCFLAGS) $(SHFLAGS) $(SHLIBFLAGS) $(EXTRA_PATH) -o $(EXE) \
        $(OBJ) $(EXTRA_LIB) $(LIB)

# Compilation rules

%.o:%.cpp
	$(CC) $(CCFLAGS) $(SHFLAGS) $(EXTRA_INC) -c $<

%.d:%.cpp
	$(CC) $(CCFLAGS) $(EXTRA_INC) $(DEPFLAGS) $< > $@

%.o:%.cu
	$(CC) $(CCFLAGS) $(SHFLAGS) $(EXTRA_INC) -c $<

# Individual dependencies

DEPENDS = $(OBJ:.o=.d)
sinclude $(DEPENDS)

</code>

**step 3**:编译
<code make>
nohup make intel_cpu_atomistica >& make.log &  #对于cpu版，则根据make后缀为make intel_cpu 
tail -f make.log  #查看编译过程
</code>
