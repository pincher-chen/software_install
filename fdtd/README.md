# software install
## 1.FDTD_Slution 
This software needs to be installed by root user, while it is also ok to install a local linux computer with the same linux version compared to Tianhe-2 computing nodes 
## 2.Lumerical_FlexLM
This software needs to be install by root user, too. We recommend install it on cloud partition, of which nodes can connect to netwrok. As a result, the online activation can be carried out. 

# running test
```
$ cat run_job.sh 
```
```
#!/bin/sh
input_file=$1
export MPICH_NEMESIS_NETMOD=tcp # this software support tcp communication protocol. It is important to use this envirment.
mpiexe=/BIGDATA/app/FDTD/8.12/FDTD/mpich2/nemesis/bin/mpiexec #shoud check if your count can access BIGDATA partition.
fdtdexe=/BIGDATA/app/FDTD/8.12/FDTD/bin/fdtd-engine-mpich2nem
echo "$mpiexe -np 24 $fdtdexe $input_file" #here, I try to apply 1 node on Tianhe-2 supercomputer, so -np should equal to node_number*24.
$mpiexe -np 24 $fdtdexe $input_file
```
```
$ yhbatch -p free  -N 1 -c 24 run_job.sh Microring1.fsp #if you want to use 10 nodes,command like this "$yhbatch -p free  -N 10 -c 24 run_job.sh Microring1.fsp", and change the -np in run_job.sh by 240.
```
```
$ cat slurm-634368.out 
```
```
/BIGDATA/app/FDTD/8.12/FDTD/mpich2/nemesis/bin/mpiexec -np 24 /BIGDATA/app/FDTD/8.12/FDTD/bin/fdtd-engine-mpich2nem Microring1.fsp
0% complete. Max time remaining: 3 mins, 29 secs. Auto Shutoff: 1
2% complete. Max time remaining: 3 mins, 20 secs. Auto Shutoff: 1
3% complete. Max time remaining: 3 mins, 18 secs. Auto Shutoff: 1
4% complete. Max time remaining: 3 mins, 16 secs. Auto Shutoff: 0.935404
5% complete. Max time remaining: 3 mins, 14 secs. Auto Shutoff: 0.94364
6% complete. Max time remaining: 3 mins, 12 secs. Auto Shutoff: 0.929368
7% complete. Max time remaining: 3 mins, 10 secs. Auto Shutoff: 0.952873
8% complete. Max time remaining: 3 mins, 8 secs. Auto Shutoff: 0.915959
9% complete. Max time remaining: 3 mins, 6 secs. Auto Shutoff: 0.941676
10% complete. Max time remaining: 3 mins, 4 secs. Auto Shutoff: 0.910298
11% complete. Max time remaining: 3 mins, 2 secs. Auto Shutoff: 0.923446
12% complete. Max time remaining: 2 mins, 60 secs. Auto Shutoff: 0.86233
13% complete. Max time remaining: 2 mins, 58 secs. Auto Shutoff: 0.344979
14% complete. Max time remaining: 2 mins, 56 secs. Auto Shutoff: 0.13302
15% complete. Max time remaining: 2 mins, 54 secs. Auto Shutoff: 0.126484
16% complete. Max time remaining: 2 mins, 52 secs. Auto Shutoff: 0.117315
17% complete. Max time remaining: 2 mins, 50 secs. Auto Shutoff: 0.127348
18% complete. Max time remaining: 2 mins, 48 secs. Auto Shutoff: 0.128591
19% complete. Max time remaining: 2 mins, 46 secs. Auto Shutoff: 0.123492
19% complete. Max time remaining: 2 mins, 44 secs. Auto Shutoff: 0.114328
20% complete. Max time remaining: 2 mins, 42 secs. Auto Shutoff: 0.12657
21% complete. Max time remaining: 2 mins, 40 secs. Auto Shutoff: 0.121403
22% complete. Max time remaining: 2 mins, 38 secs. Auto Shutoff: 0.118002
23% complete. Max time remaining: 2 mins, 36 secs. Auto Shutoff: 0.113139
24% complete. Max time remaining: 2 mins, 34 secs. Auto Shutoff: 0.12097
25% complete. Max time remaining: 2 mins, 32 secs. Auto Shutoff: 0.111776
26% complete. Max time remaining: 2 mins, 30 secs. Auto Shutoff: 0.118384
27% complete. Max time remaining: 2 mins, 28 secs. Auto Shutoff: 0.119707
28% complete. Max time remaining: 2 mins, 26 secs. Auto Shutoff: 0.116825
29% complete. Max time remaining: 2 mins, 24 secs. Auto Shutoff: 0.104353
30% complete. Max time remaining: 2 mins, 22 secs. Auto Shutoff: 0.0948009
31% complete. Max time remaining: 2 mins, 20 secs. Auto Shutoff: 0.0894749
32% complete. Max time remaining: 2 mins, 18 secs. Auto Shutoff: 0.0820538
33% complete. Max time remaining: 2 mins, 16 secs. Auto Shutoff: 0.0760186
34% complete. Max time remaining: 2 mins, 14 secs. Auto Shutoff: 0.0826767
35% complete. Max time remaining: 2 mins, 12 secs. Auto Shutoff: 0.0796547
36% complete. Max time remaining: 2 mins, 10 secs. Auto Shutoff: 0.0780327
38% complete. Max time remaining: 2 mins, 7 secs. Auto Shutoff: 0.0769012
39% complete. Max time remaining: 2 mins, 5 secs. Auto Shutoff: 0.0769602
40% complete. Max time remaining: 2 mins, 3 secs. Auto Shutoff: 0.0761669
40% complete. Max time remaining: 2 mins, 1 secs. Auto Shutoff: 0.0748626
41% complete. Max time remaining: 1 min, 59 secs. Auto Shutoff: 0.0722435
42% complete. Max time remaining: 1 min, 57 secs. Auto Shutoff: 0.0745699
43% complete. Max time remaining: 1 min, 55 secs. Auto Shutoff: 0.0738392
44% complete. Max time remaining: 1 min, 53 secs. Auto Shutoff: 0.0736246
45% complete. Max time remaining: 1 min, 51 secs. Auto Shutoff: 0.0730401
46% complete. Max time remaining: 1 min, 49 secs. Auto Shutoff: 0.0739413
47% complete. Max time remaining: 1 min, 47 secs. Auto Shutoff: 0.0715038
48% complete. Max time remaining: 1 min, 45 secs. Auto Shutoff: 0.0558479
49% complete. Max time remaining: 1 min, 43 secs. Auto Shutoff: 0.0559999
50% complete. Max time remaining: 1 min, 41 secs. Auto Shutoff: 0.0585705
51% complete. Max time remaining: 1 min, 40 secs. Auto Shutoff: 0.0497223
53% complete. Max time remaining: 1 min, 37 secs. Auto Shutoff: 0.0492006
54% complete. Max time remaining: 1 min, 35 secs. Auto Shutoff: 0.0541471
55% complete. Max time remaining: 1 min, 33 secs. Auto Shutoff: 0.0488603
56% complete. Max time remaining: 1 min, 31 secs. Auto Shutoff: 0.0487492
57% complete. Max time remaining: 1 min, 29 secs. Auto Shutoff: 0.0522568
58% complete. Max time remaining: 1 min, 27 secs. Auto Shutoff: 0.0518217
59% complete. Max time remaining: 1 min, 25 secs. Auto Shutoff: 0.0466749
60% complete. Max time remaining: 1 min, 23 secs. Auto Shutoff: 0.0475916
61% complete. Max time remaining: 1 min, 21 secs. Auto Shutoff: 0.0524122
61% complete. Max time remaining: 1 min, 19 secs. Auto Shutoff: 0.0497101
62% complete. Max time remaining: 1 min, 17 secs. Auto Shutoff: 0.0465238
63% complete. Max time remaining: 1 min, 15 secs. Auto Shutoff: 0.0497459
64% complete. Max time remaining: 1 min, 13 secs. Auto Shutoff: 0.0488458
65% complete. Max time remaining: 1 min, 11 secs. Auto Shutoff: 0.0415275
66% complete. Max time remaining: 1 min, 9 secs. Auto Shutoff: 0.037384
67% complete. Max time remaining: 1 min, 7 secs. Auto Shutoff: 0.0377631
68% complete. Max time remaining: 1 min, 5 secs. Auto Shutoff: 0.0342379
69% complete. Max time remaining: 1 min, 3 secs. Auto Shutoff: 0.0345838
70% complete. Max time remaining: 1 min, 1 secs. Auto Shutoff: 0.0329227
71% complete. Max time remaining: 59 secs. Auto Shutoff: 0.0329711
72% complete. Max time remaining: 57 secs. Auto Shutoff: 0.0323129
73% complete. Max time remaining: 55 secs. Auto Shutoff: 0.0315833
74% complete. Max time remaining: 53 secs. Auto Shutoff: 0.0331506
75% complete. Max time remaining: 51 secs. Auto Shutoff: 0.0340063
76% complete. Max time remaining: 49 secs. Auto Shutoff: 0.0337585
77% complete. Max time remaining: 47 secs. Auto Shutoff: 0.0334409
78% complete. Max time remaining: 45 secs. Auto Shutoff: 0.0333591
79% complete. Max time remaining: 43 secs. Auto Shutoff: 0.0340361
80% complete. Max time remaining: 41 secs. Auto Shutoff: 0.0326364
81% complete. Max time remaining: 39 secs. Auto Shutoff: 0.0302897
82% complete. Max time remaining: 37 secs. Auto Shutoff: 0.0301313
84% complete. Max time remaining: 33 secs. Auto Shutoff: 0.0245425
85% complete. Max time remaining: 31 secs. Auto Shutoff: 0.0237398
86% complete. Max time remaining: 29 secs. Auto Shutoff: 0.0232386
87% complete. Max time remaining: 27 secs. Auto Shutoff: 0.0223344
88% complete. Max time remaining: 25 secs. Auto Shutoff: 0.0233986
89% complete. Max time remaining: 23 secs. Auto Shutoff: 0.0216717
90% complete. Max time remaining: 21 secs. Auto Shutoff: 0.0243344
91% complete. Max time remaining: 19 secs. Auto Shutoff: 0.021826
92% complete. Max time remaining: 17 secs. Auto Shutoff: 0.0209115
93% complete. Max time remaining: 15 secs. Auto Shutoff: 0.0243374
94% complete. Max time remaining: 13 secs. Auto Shutoff: 0.0240812
95% complete. Max time remaining: 11 secs. Auto Shutoff: 0.0221199
96% complete. Max time remaining: 9 secs. Auto Shutoff: 0.0229779
97% complete. Max time remaining: 7 secs. Auto Shutoff: 0.0239181
98% complete. Max time remaining: 5 secs. Auto Shutoff: 0.0217313
99% complete. Max time remaining: 3 secs. Auto Shutoff: 0.0201569
100% complete. Max time remaining: 1 secs. Auto Shutoff: 0.0207371
```
