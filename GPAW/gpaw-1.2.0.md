# 1. how to install
## 1.1 install ase
```
$ module load Python/2.7.9-fPIC
$ pip install --upgrade --user numpy scipy matplotlib
$ pip install --upgrade --user ase
```

## 1.2 install gpaw

```
$ export LIBRARY_PATH=/WORK/app/libxc/2.2.2/lib:/WORK/app/LAPACK/3.5.0/lib:/WORK/app/BLAS/3.5.0/lib
```

```
$ pip install --upgrade --user gpaw
Collecting gpaw
  Using cached https://pypi.tuna.tsinghua.edu.cn/packages/3c/ed/c06fc0960c1ddc8bb5ae6a23d1164ffa78324758a3bfb50c677278bef14a/gpaw-1.2.0.tar.gz
Installing collected packages: gpaw
  Running setup.py install for gpaw ... done
Successfully installed gpaw-1.2.0
```

# 2. how to run 
We recommand user to use local gpaw
```
module load GPAW/1.2.0              #add relevant envirment;
source /WORK/app/toolshs/setproxy.sh 12.10.133.131  #connect to network
$ pip install --upgrade --user gpaw
Collecting gpaw
  Downloading gpaw-1.2.0.tar.gz (1.2MB)
    25% |?..?..?..?..?.                      | 296kB 2.0MB/s eta 0:00:0
    26% |?..?..?..?..?.                      | 307kB 2.0MB/s eta 0:00:0
    27% |?..?..?..?..?.                      | 317kB 3.1MB/s eta 0:00:0
    27% |?..?..?..?..?.                      | 327kB 3.0MB/s eta 0:00:0
    28% |?..?..?..?..?..                      | 337kB 3.0MB/s eta 0:00
    29% |?..?..?..?..?..                      | 348kB 2.4MB/s eta 0:00
    30% |?..?..?..?..?..                      | 358kB 2.4MB/s eta 0:00
    31% |?..?..?..?..?..                      | 368kB 3.7MB/s eta 0:00
    32% |?..?..?..?..?..?.                    | 378kB 2.8MB/s eta 0:
    33% |?..?..?..?..?..?.                    | 389kB 2.8MB/s eta 0:
    34% |?..?..?..?..?..?.                    | 399kB 4.7MB/s eta 0:
    34% |?..?..?..?..?..?..                    | 409kB 2.0MB/s eta 
    35% |?..?..?..?..?..?..                    | 419kB 2.0MB/s eta 
    36% |?..?..?..?..?..?..                    | 430kB 2.0MB/s eta 
    37% |?..?..?..?..?..?..                    | 440kB 2.0MB/s eta 
    38% |?..?..?..?..?..?..?.                  | 450kB 2.4MB/s et
    39% |?..?..?..?..?..?..?.                  | 460kB 2.2MB/s et
    40% |?..?..?..?..?..?..?.                  | 471kB 2.2MB/s et
    41% |?..?..?..?..?..?..?..                  | 481kB 2.2MB/s 
    41% |?..?..?..?..?..?..?..                  | 491kB 2.2MB/s 
    42% |?..?..?..?..?..?..?..                  | 501kB 2.2MB/s 
    43% |?..?..?..?..?..?..?..                  | 512kB 5.9MB/s 
    44% |?..?..?..?..?..?..?..?.                | 522kB 5.9MB/
    45% |?..?..?..?..?..?..?..?.                | 532kB 3.7MB/
    46% |?..?..?..?..?..?..?..?.                | 542kB 3.7MB/
    47% |?..?..?..?..?..?..?..?.                | 552kB 3.9MB/
    48% |?..?..?..?..?..?..?..?..                | 563kB 4.4M
    48% |?..?..?..?..?..?..?..?..                | 573kB 3.5M
    49% |?..?..?..?..?..?..?..?..                | 583kB 5.0M
    50% |?..?..?..?..?..?..?..?..?.              | 593kB 5.
    51% |?..?..?..?..?..?..?..?..?.              | 604kB 5.
    52% |?..?..?..?..?..?..?..?..?.              | 614kB 3.
    53% |?..?..?..?..?..?..?..?..?.              | 624kB 3.
    54% |?..?..?..?..?..?..?..?..?..              | 634kB 
    55% |?..?..?..?..?..?..?..?..?..              | 645kB 
    55% |?..?..?..?..?..?..?..?..?..              | 655kB 
    56% |?..?..?..?..?..?..?..?..?..?.            | 665k
    57% |?..?..?..?..?..?..?..?..?..?.            | 675k
    58% |?..?..?..?..?..?..?..?..?..?.            | 686k
    59% |?..?..?..?..?..?..?..?..?..?.            | 696k
    60% |?..?..?..?..?..?..?..?..?..?..            | 70
    61% |?..?..?..?..?..?..?..?..?..?..            | 71
    62% |?..?..?..?..?..?..?..?..?..?..            | 72
    62% |?..?..?..?..?..?..?..?..?..?..?.          | 
    63% |?..?..?..?..?..?..?..?..?..?..?.          | 
    64% |?..?..?..?..?..?..?..?..?..?..?.          | 
    65% |?..?..?..?..?..?..?..?..?..?..?.          | 
    66% |?..?..?..?..?..?..?..?..?..?..?..          
    67% |?..?..?..?..?..?..?..?..?..?..?..          
    68% |?..?..?..?..?..?..?..?..?..?..?..          
    69% |?..?..?..?..?..?..?..?..?..?..?..          
    69% |?..?..?..?..?..?..?..?..?..?..?..?.      
    70% |?..?..?..?..?..?..?..?..?..?..?..?.      
    71% |?..?..?..?..?..?..?..?..?..?..?..?.      
    72% |?..?..?..?..?..?..?..?..?..?..?..?..    
    73% |?..?..?..?..?..?..?..?..?..?..?..?..    
    74% |?..?..?..?..?..?..?..?..?..?..?..?..    
    75% |?..?..?..?..?..?..?..?..?..?..?..?..    
    76% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    76% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    77% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    78% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    79% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    80% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    81% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    82% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    83% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    83% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    84% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    85% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    86% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    87% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    88% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    89% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    90% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    90% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    91% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    92% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    93% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    94% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    95% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    96% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    97% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    97% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    98% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    99% |?..?..?..?..?..?..?..?..?..?..?..?..?.
    100% |?..?..?..?..?..?..?..?..?..?..?..?..?.?..?..?..| 1.2MB 24kB/s 
Installing collected packages: gpaw
  Running setup.py install for gpaw ... done
  
$ ls ~/.local/bin/
gpaw                gpaw-mpisim                 gpaw-runscript
gpaw-analyse-basis  gpaw-plot-parallel-timings  gpaw-setup
gpaw-basis          gpaw-python                 gpaw-upfplot

$ export PATH=~/.local/bin:$PATH

```
## test
```
$ gpaw info
python-2.7.9    /WORK/app/Python/2.7.9-fPIC/bin/python
gpaw-1.2.0      /HOME/nscc-gz_pinchen/.local/lib/python2.7/site-packages/gpaw/
ase-3.13.0      /WORK/app/Python/2.7.9-fPIC/lib/python2.7/site-packages/ase/
numpy-1.9.1     /WORK/app/Python/2.7.9-fPIC/lib/python2.7/site-packages/numpy/
scipy-0.16.0b2  /WORK/app/Python/2.7.9-fPIC/lib/python2.7/site-packages/scipy/
_gpaw           /HOME/nscc-gz_pinchen/.local/lib/python2.7/site-packages/_gpaw.so
parallel        /HOME/nscc-gz_pinchen/.local/bin/gpaw-python
FFTW            yes
scalapack       no
libvdwxc        no
PAW-datasets    1: /usr/local/share/gpaw-setups
                2: /usr/share/gpaw-setups
```
```
$ source /WORK/app/osenv/ln1/set3.sh
$ yhrun -n 4 gpaw-python `which gpaw` test
yhrun: job 810969 queued and waiting for resources
yhrun: job 810969 has been allocated resources
python-2.7.9    /HOME/nscc-gz_pinchen/.local/bin/gpaw-python
gpaw-1.2.0      /HOME/nscc-gz_pinchen/.local/lib/python2.7/site-packages/gpaw/
ase-3.13.0      /WORK/app/Python/2.7.9-fPIC/lib/python2.7/site-packages/ase/
numpy-1.9.1     /WORK/app/Python/2.7.9-fPIC/lib/python2.7/site-packages/numpy/
scipy-0.16.0b2  /WORK/app/Python/2.7.9-fPIC/lib/python2.7/site-packages/scipy/
_gpaw           built-in
parallel        no
FFTW            yes
scalapack       no
libvdwxc        no
PAW-datasets    1: /usr/local/share/gpaw-setups
                2: /usr/share/gpaw-setups
Running tests in /tmp/gpaw-test-SyaYxE
Jobs: 1, Cores: 4, debug-mode: False
=============================================================================
linalg/gemm_complex.py                        0.460  OK
ase_features/ase3k_version.py                 0.032  OK
kpt.py                                        0.299  OK
mpicomm.py                                    0.054  OK
pathological/numpy_core_multiarray_dot.py     0.019  OK
eigen/cg2.py                                  0.052  OK
fd_ops/laplace.py                             0.000  SKIPPED
linalg/lapack.py                              0.266  OK
linalg/eigh.py                                0.674  OK
parallel/submatrix_redist.py                  0.000  SKIPPED
lfc/second_derivative.py                      0.051  OK
parallel/parallel_eigh.py                     0.021  OK
lfc/gp2.py                                    0.027  OK
linalg/blas.py                                0.064  OK
Gauss.py                                      0.143  OK
symmetry/check.py                             1.129  OK
fd_ops/nabla.py                               0.121  OK
linalg/dot.py                                 0.021  OK
linalg/mmm.py                                 0.024  OK
xc/lxc_fxc.py                                 0.036  OK
xc/pbe_pw91.py                                0.024  OK
fd_ops/gradient.py                            0.064  OK
maths/erf.py                                  0.222  OK
lfc/lf.py                                     0.030  OK
maths/fsbt.py                                13.099  OK
parallel/compare.py                           0.066  OK
vdw/libvdwxc_functionals.py                   0.000  SKIPPED
radial/integral4.py                           0.081  FAILED! (rank 0,1,2,3)
#############################################################################
RANK 0,1,2,3:
```

