# How to compile
```
$ cd gromacs-5.1.4
$ mkdir build
$ cd biuld
$ module  load cmake/3.5.1
## if you can not acess to NSFCGZ, please change NSFCGZ to WORK.
$ cmake .. -DGMX_MPI=ON  -DCMAKE_INSTALL_PREFIX=/NSFCGZ/app/gromacs/5.1.4-single-avx-256 -DCMAKE_PREFIX_PATH=/NSFCGZ/app/fftw/3.3.4-single-avx-sse2 -DGMX_GPU=OFF -DGMX_BINARY_SUFFIX="_mpi" -DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpic++ -DGMX_SIMD=AVX_256
-- The C compiler identification is Intel 14.0.2.20140120
-- The CXX compiler identification is Intel 14.0.2.20140120
-- Check for working C compiler: /usr/local/mpi3-dynamic/bin/mpicc
-- Check for working C compiler: /usr/local/mpi3-dynamic/bin/mpicc -- works
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working CXX compiler: /usr/local/mpi3-dynamic/bin/mpic++
-- Check for working CXX compiler: /usr/local/mpi3-dynamic/bin/mpic++ -- works
-- Detecting CXX compiler ABI info
....

$ make -j 16 
...
[ 98%] Building CXX object src/gromacs/CMakeFiles/libgromacs.dir/mdlib/mdrun_signalling.cpp.o
[ 98%] Building CXX object src/gromacs/CMakeFiles/libgromacs.dir/mdlib/calcmu.cpp.o
[ 98%] Building CXX object src/gromacs/CMakeFiles/libgromacs.dir/mdlib/groupcoord.cpp.o
[ 98%] Building CXX object src/gromacs/CMakeFiles/libgromacs.dir/mdlib/clincs.cpp.o
[ 98%] Building C object src/gromacs/CMakeFiles/libgromacs.dir/__/external/thread_mpi/src/errhandler.c.o
[ 98%] Building C object src/gromacs/CMakeFiles/libgromacs.dir/__/external/thread_mpi/src/tmpi_malloc.c.o
[ 98%] Building C object src/gromacs/CMakeFiles/libgromacs.dir/__/external/thread_mpi/src/atomic.c.o
[ 98%] Building C object src/gromacs/CMakeFiles/libgromacs.dir/__/external/thread_mpi/src/lock.c.o
[100%] Building C object src/gromacs/CMakeFiles/libgromacs.dir/__/external/thread_mpi/src/pthreads.c.o
[100%] Building CXX object src/gromacs/CMakeFiles/libgromacs.dir/__/external/thread_mpi/src/system_error.cpp.o
[100%] Building C object src/gromacs/CMakeFiles/libgromacs.dir/utility/baseversion-gen.c.o
[100%] Linking CXX shared library ../../lib/libgromacs_mpi.so
[100%] Built target libgromacs
Scanning dependencies of target gmx
Scanning dependencies of target template
[100%] Building CXX object src/programs/CMakeFiles/gmx.dir/gmx.cpp.o
[100%] Building CXX object src/programs/CMakeFiles/gmx.dir/legacymodules.cpp.o
[100%] Building CXX object share/template/CMakeFiles/template.dir/template.cpp.o
[100%] Linking CXX executable ../../bin/gmx_mpi
[100%] Linking CXX executable ../../bin/template
[100%] Built target gmx
[100%] Built target template

$ make install
...
-- Installing: /NSFCGZ/app/gromacs/5.1.4-single-avx-256/include/gromacs/selection/selectionoption.h
-- Installing: /NSFCGZ/app/gromacs/5.1.4-single-avx-256/include/gromacs/selection/selectionoptionmanager.h
-- Installing: /NSFCGZ/app/gromacs/5.1.4-single-avx-256/include/gromacs/trajectoryanalysis/analysismodule.h
-- Installing: /NSFCGZ/app/gromacs/5.1.4-single-avx-256/include/gromacs/trajectoryanalysis/analysissettings.h
-- Installing: /NSFCGZ/app/gromacs/5.1.4-single-avx-256/include/gromacs/trajectoryanalysis/cmdlinerunner.h
-- Installing: /NSFCGZ/app/gromacs/5.1.4-single-avx-256/bin/gmx_mpi
-- Set runtime path of "/NSFCGZ/app/gromacs/5.1.4-single-avx-256/bin/gmx_mpi" to "$ORIGIN/../lib64:/NSFCGZ/app/fftw/3.3.4-single-avx-sse2/lib"
-- Up-to-date: /NSFCGZ/app/gromacs/5.1.4-single-avx-256/bin
-- Installing: /NSFCGZ/app/gromacs/5.1.4-single-avx-256/bin/gmx-completion.bash
-- Installing: /NSFCGZ/app/gromacs/5.1.4-single-avx-256/bin/gmx-completion-gmx_mpi.bash

$ ls $ ls /NSFCGZ/app/gromacs/5.1.4-single-avx-256
bin  include  lib64  share
$ ls /NSFCGZ/app/gromacs/5.1.4-single-avx-256/bin
demux.pl                     gmx_mpi     GMXRC.csh
gmx-completion.bash          GMXRC       GMXRC.zsh
gmx-completion-gmx_mpi.bash  GMXRC.bash  xplor2gmx.pl
```
Finshed.

# How to run
```
$ module load gromacs/5.1.4
$ which gmx_mpi
/WORK/app/gromacs/5.1.4-single-avx-256/bin/gmx_mpi
$ cd ~/../villin/villin_vsites
## run by yhrun
$ yhrun -n 8 gmx_mpi mdrun -ntomp 1 -deffnm pme 
                   :-) GROMACS - gmx mdrun, VERSION 5.1.4 (-:

                            GROMACS is written by:
     Emile Apol      Rossen Apostolov  Herman J.C. Berendsen    Par Bjelkmar   
 Aldert van Buuren   Rudi van Drunen     Anton Feenstra   Sebastian Fritsch 
  Gerrit Groenhof   Christoph Junghans   Anca Hamuraru    Vincent Hindriksen
 Dimitrios Karkoulis    Peter Kasson        Jiri Kraus      Carsten Kutzner  
    Per Larsson      Justin A. Lemkul   Magnus Lundborg   Pieter Meulenhoff 
   Erik Marklund      Teemu Murtola       Szilard Pall       Sander Pronk   
   Roland Schulz     Alexey Shvetsov     Michael Shirts     Alfons Sijbers  
   Peter Tieleman    Teemu Virolainen  Christian Wennberg    Maarten Wolf   
                           and the project leaders:
        Mark Abraham, Berk Hess, Erik Lindahl, and David van der Spoel

Copyright (c) 1991-2000, University of Groningen, The Netherlands.
Copyright (c) 2001-2015, The GROMACS development team at
Uppsala University, Stockholm University and
the Royal Institute of Technology, Sweden.
check out http://www.gromacs.org for more information.

GROMACS is free software; you can redistribute it and/or modify it
under the terms of the GNU Lesser General Public License
as published by the Free Software Foundation; either version 2.1
of the License, or (at your option) any later version.

GROMACS:      gmx mdrun, VERSION 5.1.4
Executable:   /WORK/app/gromacs/5.1.4-single-avx-256/bin/gmx_mpi
Data prefix:  /WORK/app/gromacs/5.1.4-single-avx-256
Command line:
  gmx_mpi mdrun -ntomp 1 -deffnm pme


Back Off! I just backed up pme.log to ./#pme.log.4#

Running on 1 node with total 24 cores, 24 logical cores
Hardware detected on host cn5019 (the node of MPI rank 0):
  CPU info:
    Vendor: GenuineIntel
    Brand:  Intel(R) Xeon(R) CPU E5-2692 v2 @ 2.20GHz
    SIMD instructions most likely to fit this hardware: AVX_256
    SIMD instructions selected at GROMACS compile time: AVX_256

Reading file pme.tpr, VERSION 5.1.1 (single precision)
Using 8 MPI processes
Using 1 OpenMP thread per MPI process


NOTE: The number of threads is not equal to the number of (logical) cores
      and the -pin option is set to auto: will not pin thread to cores.
      This can lead to significant performance degradation.
      Consider using -pin on (and -pinoffset in case you run multiple jobs).


Back Off! I just backed up pme.edr to ./#pme.edr.3#
starting mdrun 'SMP-ensv-03 t=   0.00000 in water'
10000 steps,     50.0 ps.

NOTE: Turning on dynamic load balancing


Writing final coordinates.

Back Off! I just backed up pme.gro to ./#pme.gro.3#

 Average load imbalance: 2.9 %
 Part of the total run time spent waiting due to load imbalance: 1.2 %
 Steps where the load balancing was limited by -rdd, -rcon and/or -dds: X 0 % Y 0 % Z 0 %


NOTE: 4 % of the run time was spent in domain decomposition,
      10 % of the run time was spent in pair search,
      you might want to increase nstlist (this has no effect on accuracy)


               Core t (s)   Wall t (s)        (%)
       Time:      150.065       19.078      786.6
                 (ns/day)    (hour/ns)
Performance:      226.467        0.106

gcq#100: "Step Aside, Butch" (Pulp Fiction)
```
## run by yhbatch 
$ module load gromacs/5.1.4
$ touch run_job.sh
$ vi run_job.sh
#!/bin/sh
yhrun -n 8 gmx_mpi mdrun -ntomp 1 -deffnm pme 

$ yhbatch -N 1 run_job.sh
```
