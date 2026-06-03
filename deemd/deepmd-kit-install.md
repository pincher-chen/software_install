# LAMMPS + DeePMD-kit (PyTorch 后端) 安装手册

本手册记录在本集群上为 LAMMPS 接入 DeePMD-kit 的 **PyTorch 后端** 的完整流程。
整体分两步:**先编译 DeePMD-kit C 接口库 (`libdeepmd_c_pt`)**,**再编译 LAMMPS 并链接该库**。

---

## 0. 环境与路径约定

| 项目 | 路径 |
|------|------|
| 软件根目录 | `/HOME/nscc-gz/nscc-gz_pinchen3/XYFS01_HDD_POOL/software` |
| DeePMD-kit 源码 | `…/software/deepmd-kit-3.0.0` |
| DeePMD C 库安装位置 | `…/software/libdeepmd_c_pt` |
| LAMMPS 源码 | `…/software/lammps-stable_29Aug2024_update1` (在 `src2` 下编译) |
| Conda 环境 | `deepmd203` (Python 3.9, torch 2.4.1) |
| PyTorch 库目录 | `/GLOBALFS/nscc-gz_pinchen3/anaconda3/envs/deepmd203/lib/python3.9/site-packages/torch/lib` |

> 下文用 `$SW` 代表软件根目录 `…/software`,实际命令请用完整路径。

前置要求:
- `deepmd203` 环境中已安装 **CPU 版 PyTorch**(`python -c "import torch; print(torch.__version__)"` 不含 `+cu`)。
  本机为纯 CPU 编译,若 torch 为 CUDA 版会在 CMake 阶段报 `Caffe2: CUDA cannot be found`。
- 已加载 Intel oneAPI (icc) 与 MPICH 编译环境。

---

## 第一步:编译 DeePMD-kit C 库 (PyTorch 后端)

### 1.1 编译脚本

脚本位于 `…/software/deepmd-kit-3.0.0/build_cpp_pt_no_lammps.sh`,关键参数:

```bash
SRC_DIR=…/software/deepmd-kit-3.0.0
BUILD_DIR=${SRC_DIR}/build_cpp_pt_no_lammps
INSTALL_DIR=…/software/libdeepmd_c_pt     # 直接装到 software 下,无需手动 mv

cmake \
  -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}" \
  -DUSE_PT_BACKEND=ON \
  -DUSE_TF_BACKEND=OFF \
  -DENABLE_PYTORCH=ON \
  -DENABLE_TENSORFLOW=OFF \
  -DCMAKE_PREFIX_PATH="${TORCH_PATH}" \
  -DBUILD_CPP_IF=ON \
  -DBUILD_PY_IF=OFF \
  -DBUILD_TESTING=OFF \
  -ULAMMPS_VERSION \
  -ULAMMPS_SOURCE_ROOT \
  "${SRC_DIR}/source"
make -j"$(nproc)"
make install
```

要点说明:
- `-DBUILD_CPP_IF=ON -DBUILD_PY_IF=OFF`:只编译 C/C++ 接口,不编译 Python。
- `-U LAMMPS_VERSION -U LAMMPS_SOURCE_ROOT` + `unset` 相关变量:**禁用 LAMMPS plugin 模式**,避免 deepmd 自己去编译 LAMMPS 插件。
- `-DUSE_PT_BACKEND=ON -DENABLE_PYTORCH=ON`:启用 PyTorch 后端。

### 1.2 执行

```bash
conda activate deepmd203
cd /HOME/nscc-gz/nscc-gz_pinchen3/XYFS01_HDD_POOL/software/deepmd-kit-3.0.0
bash build_cpp_pt_no_lammps.sh
```

### 1.3 产物校验

安装完成后,`…/software/libdeepmd_c_pt/` 下应有:

```
libdeepmd_c_pt/
├── include/deepmd/        # 头文件
└── lib/
    ├── libdeepmd_c.so       # ← LAMMPS 链接期使用 (-ldeepmd_c)
    ├── libdeepmd_cc.so      # C++ 推理库 (运行时)
    ├── libdeepmd_op_pt.so   # ← PyTorch 自定义算子库 (运行时 dlopen 加载)
    └── libdeepmd.so …
```

校验依赖能否解析(设置 LD_LIBRARY_PATH 后应无 `not found`):

```bash
export LD_LIBRARY_PATH=…/software/libdeepmd_c_pt/lib:/GLOBALFS/nscc-gz_pinchen3/anaconda3/envs/deepmd203/lib/python3.9/site-packages/torch/lib:$LD_LIBRARY_PATH
ldd …/software/libdeepmd_c_pt/lib/libdeepmd_op_pt.so | grep -i "not found"   # 应无输出
```

---

## 第二步:编译 LAMMPS 并链接 DeePMD

### 2.1 准备 DeePMD 的 LAMMPS 源文件

LAMMPS `src2` 目录中需包含 deepmd 提供的 pair/fix/compute 源文件
(`pair_deepmd.*`、`pair_deepspin.*`、`fix_dplr.*`、`compute_deeptensor_atom.*`、`pppm_dplr.*` 等)。
本环境已放置在 `src2/` 及 `src2/USER-DEEPMD/`。

### 2.2 配置 `Makefile.package` 指向 libdeepmd_c_pt

文件:`…/software/lammps-stable_29Aug2024_update1/src2/Makefile.package`

```make
PKG_INC = -I../../lib/voronoi/includelink -I../../lib/plumed/includelink \
          -DLAMMPS_VERSION_NUMBER=20240829 \
          -I/HOME/nscc-gz/nscc-gz_pinchen3/XYFS01_HDD_POOL/software/libdeepmd_c_pt/include/ \
          -I.../lib/plumed/include/

PKG_PATH = -L../../lib/voronoi/liblink \
           -L/HOME/nscc-gz/nscc-gz_pinchen3/XYFS01_HDD_POOL/software/libdeepmd_c_pt/lib \
           -L/usr/local/mpi_glex/mpich4.1.2_ch3_gcc11.4.0_shared/lib \
           -L.../lib/plumed/lib

PKG_LIB = -lvoro++ -Wl,--no-as-needed -ldeepmd_c \
          -Wl,-rpath=/HOME/nscc-gz/nscc-gz_pinchen3/XYFS01_HDD_POOL/software/libdeepmd_c_pt/lib
```

**关键点:**
- 链接期只需 `-ldeepmd_c`(对应 `libdeepmd_c.so`)。
- **不要** 把 `libdeepmd_op_pt.so` 写进 `-l`:它不是链接期依赖,而是 deepmd 运行时用
  `dlopen("libdeepmd_op_pt.so")`(裸文件名)动态加载的。写进去反而会链接失败。
- `-Wl,-rpath=…/libdeepmd_c_pt/lib` 把库路径写入可执行文件,运行时优先到此处找
  `libdeepmd_c.so` / `libdeepmd_cc.so`。

### 2.3 编译

```bash
conda activate deepmd203
cd /HOME/nscc-gz/nscc-gz_pinchen3/XYFS01_HDD_POOL/software/lammps-stable_29Aug2024_update1/src2
make -j32 intel_cpu_mpich
```

生成的可执行文件:`lmp_intel_cpu_mpich`。

### 2.4 校验链接

```bash
ldd lmp_intel_cpu_mpich | grep -iE "deepmd|torch"
# 应看到 libdeepmd_c.so / libdeepmd_cc.so / libtorch* 均已解析,无 not found
```

---

## 第三步:运行时环境(重要)

由于 `libdeepmd_op_pt.so` 由 deepmd 在运行时按 **裸文件名 dlopen 加载**,且它自身还依赖
torch (`libc10/libtorch_cpu/libtorch`),**运行 LAMMPS 前必须设置 `LD_LIBRARY_PATH`**,
同时包含 deepmd 库目录与 torch 库目录:

```bash
conda activate deepmd203
export LD_LIBRARY_PATH=/HOME/nscc-gz/nscc-gz_pinchen3/XYFS01_HDD_POOL/software/libdeepmd_c_pt/lib:/GLOBALFS/nscc-gz_pinchen3/anaconda3/envs/deepmd203/lib/python3.9/site-packages/torch/lib:$LD_LIBRARY_PATH
```

建议把上面两行写进作业脚本或 `~/.bashrc`。

LAMMPS 输入文件中调用 PyTorch 模型的写法示例:

```
pair_style  deepmd  frozen_model.pth
pair_coeff  * *
```

> 模型文件需为 PyTorch 后端导出的 `.pth`(TorchScript)模型。

---

## 常见问题排查

| 现象 | 原因 / 解决 |
|------|------|
| CMake 报 `Caffe2: CUDA cannot be found` | torch 为 CUDA 版,但无 CUDA 库。改装 CPU 版 torch,或指定 `CUDA_TOOLKIT_ROOT_DIR`。 |
| 编译报 `catastrophic error: cannot open source file "dump.h"` | LAMMPS `src/src2` 缺核心 dump 文件。从同版本干净源码补回 `dump*.{cpp,h}`、`read_dump.*`、`write_dump.*` 共 26 个核心文件。 |
| 运行报算子未注册 / 找不到 `libdeepmd_op_pt.so` | 未设置 `LD_LIBRARY_PATH`,见第三步。 |
| `icc: warning #10145: no action performed for file '…/voro++'` | `lib/voronoi/Makefile.lammps` 里 voro++ 路径少了 `-I`,仅警告,不影响编译。 |

---

## 附:一键运行环境脚本

可创建 `…/software/env_lammps_pt.sh`:

```bash
#!/bin/bash
source ~/.bashrc
conda activate deepmd203
export LD_LIBRARY_PATH=/HOME/nscc-gz/nscc-gz_pinchen3/XYFS01_HDD_POOL/software/libdeepmd_c_pt/lib:/GLOBALFS/nscc-gz_pinchen3/anaconda3/envs/deepmd203/lib/python3.9/site-packages/torch/lib:$LD_LIBRARY_PATH
```

运行前 `source …/software/env_lammps_pt.sh` 即可。
