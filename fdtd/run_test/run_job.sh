#!/bin/sh
input_file=$1
export MPICH_NEMESIS_NETMOD=tcp
mpiexe=/BIGDATA/app/FDTD/8.12/FDTD/mpich2/nemesis/bin/mpiexec
fdtdexe=/BIGDATA/app/FDTD/8.12/FDTD/bin/fdtd-engine-mpich2nem
echo "$mpiexe -np 24 $fdtdexe $input_file"
$mpiexe -np 24 $fdtdexe $input_file

#while(( $# > 0 ))
#do
#    set -x
#     $mpiexe -np 840 $fdtdexe $1
#    "$MPIEXEC" -n $PROCS "$ENGINE" -nw "$1" 
#    set +x
#    shift
#done
