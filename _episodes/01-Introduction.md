---
title: "Introduction to SMU SuperPOD"
teaching: 10
exercises: 0
objectives:
- "Onboarding to SMU SuperPOD"
keypoints:
- "SuperPOD 101"
---

# Introduction

- The SMU SuperPOD is a high-performance computing (HPC) cluster, made by NVIDIA, specifically tailored to meet the demands of cutting-edge research

- This shared resource machine consists of 20 NVIDIA DGX A100 nodes, each with 8 advanced and powerful graphical processing units (GPUs) to accelerate calculations and train AI models.

- The SMU Office of Information Technology (OIT) and the Center for Research Computing (CRC) jointly manage and provide both access and support for this top of the line machine.


## NVIDIA DGX SuperPOD Advantage Specifications

| Specification               | Values                                        |
|-----------------------------|-----------------------------------------------|
| Computational Ability       | 1,644 TFLOPS                                  |
| Number of Nodes             | 20                                            |
| CPU Cores                   | 2,560                                         |
| Total Memory                | 52.5 TB                                       |
| Node Interconnect Bandwidth | 200 Gb/s Infiniband Connections Per Node |
| Scratch Storage             | 750 TB (Raw)                                  |
| Archival Storage            | N/A                                           |
| Operating System            | Ubuntu 20.04                                  |

## Specification for each compute node:

| Specification               | Values                                        |
|-----------------------------|-----------------------------------------------|
| CPU number                  | 128                                           |
| GPU number                  | 8                                             |
| Memory                      | 1910gb                                        |
| Time Limit                  | 2 days                                        |
| Home Storage                | 200gb (Independence from M3)                  |
| Scratch Storage             | Unlimited (Independence from M3)              |

Command to check number the configuration of All nodes:

```
$ sinfo --Format="PartitionName,Nodes:10,CPUs:8,Memory:12,Time:15,Features:18,Gres:14"
```

## Storage 

Note that: 
- SuperPOD's home & scratch directory is different from M3's home.
- However, both SuperPOD and M3 share the same project work storage (refer to from SMU ColdFront HPC Management)

Variable       | Path                       | Quota  | Usage                      |
-------------- | -------------------------- | ------ | -------------------------  |
${HOME}        | /users/${USER}             | 200 GB | Home directory, backed up  |
${SCRATCH}     | /scratch/users/${USER}     | None   | Temporary scratch space    |
${JOB_SCRATCH} | /scratch/_tmp/${USER:0:1}/  | None   | Per job scratch space,    |
${JOB_SCRATCH} | ${USER}/${SLURM_JOB_ID}_   |        | ${SLURM_ARRAY_TASK_ID} is   |
${JOB_SCRATCH} | ${SLURM_ARRAY_TASK_ID}     |        | zero for standard jobs     |

# Login to SuperPOD

- Make sure you have a SuperPOD account created for you. You can ask your supervisor to request for an account by submitting this [form](https://smu.az1.qualtrics.com/jfe/form/SV_6WIK4HsRuE4N6JL)
- There are several ways to login to SuperPOD: via 2 login nodes (must be on VPN)

```
$ ssh username@superpod.smu.edu
$ ssh username@slogin-01.superpod.smu.edu
$ ssh username@slogin-02.superpod.smu.edu
```
SuperPOD is using the same module system as M3 so nearly all commands are similar.

# Requesting a compute node

SuperPOD uses SLURM as scheduler so it is no different from M3 when requesting an interactive node:

For example, requesting a node with **1 GPU, 10 CPUs, 128gb memory for 12 hours**: using my workshop Allocation **-A tuev_oitrts_workshop_0001**

```
$ srun -A tuev_oitrts_workshop_0001 -N 1 -G 1 -c 10 --mem=128G --time=12:00:00 --pty $SHELL
$ srun -A tuev_oitrts_workshop_0001 -N 1 -G 1 -c 10 --mem=128G --time=12:00:00 --pty bash
```

# Transfering data

- It is no difference when transfering data to-from SuperPOD if you are familiar with M3, you can use scp for regular transfer

```
scp /link/fileA username@superpod.smu.edu:/users/username
```

or using WinSCP on Windows machine if you dont want to use CLI

- Tips, since SuperPOD and M3 share the same work storage, you can utilize this share storage for both systems.

# Working with module
By default, very few modules available when using **module avail**

```
$ module avail

------------------------------------------------------------------------- /hpc/mp/module_files/compilers -------------------------------------------------------------------------
   amd/aocc/4.1.0    gcc/11.2.0    intel/oneapi/2023.2    nvidia/nvhpc/23.7

--------------------------------------------------------------------------- /hpc/mp/module_files/apps ----------------------------------------------------------------------------
   amber/22    apptainer/1.1.9    conda    gaussian/g16c02    julia/1.9.2    lammps/may22    spack

```

Similar to M3, SuperPOD also uses [Spack](https://spack.io/) as its module manager. Therefore you can find all your needed modules after loading spack:

```
$ module load spack
$ module avail

------------------------------------------------------------------ /hpc/mp/spack_modules/linux-ubuntu22.04-zen2 ------------------------------------------------------------------
   aocc-4.1.0/aocl-sparse/4.0-t2kjb3u                               gcc-11.2.0/aocl-sparse/4.0-zczy7ug                          gcc-11.2.0/lz4/1.9.4-gtzsc3c
   aocc-4.1.0/autoconf-archive/2023.02.20-inwkm6b                   gcc-11.2.0/autoconf-archive/2023.02.20-r5lazua              gcc-11.2.0/lzo/2.10-x6itbky
   aocc-4.1.0/autoconf/2.69-x53b2ii                                 gcc-11.2.0/autoconf/2.69-xlmuzvq                            gcc-11.2.0/m4/1.4.19-sv4d5ah
   aocc-4.1.0/automake/1.16.5-hfcjabg                               gcc-11.2.0/automake/1.16.5-nsy2ron                          gcc-11.2.0/mbedtls/2.28.2-xvf3rc3
   aocc-4.1.0/berkeley-db/18.1.40-5po7n7c                           gcc-11.2.0/berkeley-db/18.1.40-hlnjdqn                      gcc-11.2.0/mbedtls/2.28.2-42lnomn         (D)     
   aocc-4.1.0/binutils/2.40-eivqxcw                                 gcc-11.2.0/binutils/2.40-u6hr2wz                            gcc-11.2.0/meson/1.1.0-teqdfz5
   aocc-4.1.0/bzip2/1.0.8-5ag7qmi                                   gcc-11.2.0/bison/3.8.2-tifozqf                              gcc-11.2.0/metis/5.1.0-coza6f3
   aocc-4.1.0/cmake/3.26.3-p6v5a7t                                  gcc-11.2.0/boost/1.82.0-xpmd3v6                             gcc-11.2.0/mpfr/4.2.0-meodww2
   aocc-4.1.0/diffutils/3.9-bzq7rzo                                 gcc-11.2.0/bzip2/1.0.8-qaxdt7f                              gcc-11.2.0/msgpack-c/3.1.1-d624eki
   aocc-4.1.0/expat/2.5.0-kav5ad4                                   gcc-11.2.0/cmake/3.26.3-r23mmbq                             gcc-11.2.0/nasm/2.15.05-mdqravc
   aocc-4.1.0/gdbm/1.23-6r6asdl                                     gcc-11.2.0/cmake/3.26.3-utseokk                      (D)    gcc-11.2.0/ncurses/6.4-rfw5ur5
   aocc-4.1.0/gettext/0.21.1-dmnukqt                                gcc-11.2.0/curl/8.0.1-cp7iioq                               gcc-11.2.0/neovim/0.8.3-mdppjp3
   ....
```

Note: Press **"q"** to quit checking module

As we are on installation process, if you do not see the modules that you needed available, please inform us so we can install that for you

