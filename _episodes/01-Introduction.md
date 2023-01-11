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

- The SMU SuperPOD is a high-performance computing (HPC) cluster, specifically tailored to meet the demands of cutting-edge research

- This shared resource machine consists of 20 NVIDIA DGX A100 nodes, each with 8 advanced and powerful graphical processing units (GPUs) to accelerate calculations and train AI models.

- The SMU Office of Information Technology (OIT) and the Center for Research Computing (CRC) jointly manage and provide both access and support for this top of the line machine.


## NVIDIA DGX SuperPOD Advantage Specifications

| Specification               | Values                                        |
|-----------------------------|-----------------------------------------------|
| Computational Ability       | 1,644 TFLOPS                                  |
| Number of Nodes             | 20                                            |
| CPU Cores                   | 2,560                                         |
| GPU Accelerator Cores       | 1,392,640                                     |
| Total Memory                | 52.5 TB                                       |
| Node Interconnect Bandwidth | 10 - 200 Gb/s Infiniband Connections Per Node |
| Work Storage                | 768 TB (Shared)                               |
| Scratch Storage             | 750 TB (Raw)                                  |
| Archival Storage            | N/A                                           |
| Operating System            | Ubuntu 20.04                                  |

## Specification for each compute node:

| Specification               | Values                                        |
|-----------------------------|-----------------------------------------------|
| CPU number                  | 128                                          |
| GPU number                  | 8                                             |
| Memory                      | 1910gb                                         |
| Home Storage                | 200gb (Independence from M2)                  |
| Scratch Storage             | Unlimited (Independence from M2)              |
| Work Storage                | 8TB (shared with M2)                          |

```
$ sinfo --Format="PartitionName,Nodes:10,CPUs:8,Memory:12,Time:15,Features:18,Gres:14
```

## Storage 

Note that: 
- SuperPOD's home & scratch directory is different from M2's home.
- However, both SuperPOD and M2 share the same $WORK storage

Variable       | Path                       | Quota  | Usage                      |
-------------- | -------------------------- | ------ | -------------------------  |
${HOME}        | /users/${USER}             | 200 GB | Home directory, backed up  |
${WORK}        | /work/users/${USER}        | 8 TB   | Long term storage          |
${SCRATCH}     | /scratch/users/${USER}     | None   | Temporary scratch space    |
${JOB_SCRATCH} | /scratch/_tmp/${USER:0:1}/  | None   | Per job scratch space,    |
${JOB_SCRATCH} | ${USER}/${SLURM_JOB_ID}_   |        | ${SLURM_ARRAY_TASK_ID} is   |
${JOB_SCRATCH} | ${SLURM_ARRAY_TASK_ID}     |        | zero for standard jobs     |

# Login to SuperPOD

- Make sure you have a SuperPOD account created for you. You can ask your supervisor to request for an account by submitting this [form](https://smu.az1.qualtrics.com/jfe/form/SV_6WIK4HsRuE4N6JL)
- There are several ways to login to SuperPOD: you can login directly or via login nodes (must be on VPN)

```
$ ssh username@superpod.smu.edu
$ ssh username@slogin-01.superpod.smu.edu
$ ssh username@slogin-02.superpod.smu.edu
```

If you do not use VPN off campus, you can login to ManeFrame II and then ssh to SuperPOD:

```
$ ssh username@m2.smu.edu
$ ssh username@slogin-01.superpod.smu.edu
```

SuperPOD is using the same module system as M2 so nearly all commands are similar.

# Requesting a compute node

SuperPOD uses SLURM as scheduler so it is no different from M2 when requesting an interactive node:

For example, requesting a node with 1 GPU, 10 CPUs, 128gb memory for 12 hours:

```
$ srun -N 1 -G 1 -c 10 --mem=128G --time=12:00:00 --pty $SHELL
$ srun -N 1 -G 1 -c 10 --mem=128G --time=12:00:00 --pty bash
```

# Transfering data

- It is no difference when transfering data to-from SuperPOD if you are familiar with M2, you can use scp for regular transfer

```
scp /link/fileA username@superpod.smu.edu:/users/username
```

or using WinSCP if you dont want to use CLI

- Tips, since SuperPOD and M2 share the same work storage, you can utilize this share storage for both systems.

# Working with module
By default, very few modules available when using **module avail**

```
$ module avail

------------------------------------------------------ /hpc/mp/modules -------------------------------------------------------  
amber/16    gaussian/g16c02         hpcx/hpcx-debug      hpcx/hpcx-ompi         hpcx/hpcx-stack        singularity/1.0.2
   conda       hpc-sdk/21.3            hpcx/hpcx-mt-ompi    hpcx/hpcx-prof-ompi    hpcx/hpcx       (D)    spack
   dev/1       hpcx/hpcx-debug-ompi    hpcx/hpcx-mt         hpcx/hpcx-prof         lammps/may22
```

Similar to M2, SuperPOD also uses [Spack](https://spack.io/) as its module manager. Therefore you can find all your needed modules after loading spack:

```
$ module load spack
$ module avail

---------------------------------- /hpc/mp/spack/share/spack/modules/linux-ubuntu20.04-zen2 ----------------------------------   autoconf-2.69-gcc-9.4.0-ebln5y6                          libxml2-2.9.13-gcc-10.3.0-zirv7w5
   autoconf-archive-2022.02.11-gcc-9.4.0-vl5t5da            libxml2-2.9.13-gcc-9.4.0-in2l3or
   automake-1.16.5-gcc-9.4.0-5c2yujw                        llvm-12.0.1-gcc-9.4.0-r2q3sru
   berkeley-db-18.1.40-gcc-10.3.0-mlszo5e                   lmod-8.7.2-gcc-10.3.0-uutt23p
   berkeley-db-18.1.40-gcc-9.4.0-cxlb2jo                    lua-5.3.5-gcc-10.3.0-qw2i56f
   binutils-2.38-gcc-9.4.0-bpjscr5                          lua-lpeg-1.0.2-1-gcc-10.3.0-ttjpelo
   bison-3.8.2-gcc-10.3.0-yaxkxvj                           lua-luafilesystem-1_8_0-gcc-10.3.0-2dihlqw
   blt-0.5.1-gcc-10.3.0-qcy3gp3                             lua-luajit-openresty-2.1-20220111-gcc-10.3.0-scft7rz
   bzip2-1.0.8-gcc-10.3.0-vqphlps                           lua-luaposix-35.0-gcc-10.3.0-l4ljchh
   ....
```

As we are on installation process, if you do not see the modules that you needed available, please inform us so we can install that for you

