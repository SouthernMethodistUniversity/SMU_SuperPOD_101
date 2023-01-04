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
| CPU Cores                   | 2,56                                          |
| GPU number                  | 8                                             |
| Memory                      | 748gb                                         |
| Home Storage                | 200gb (Independence from M2)                  |
| Scratch Storage             | Unlimited (Independence from M2)              |
| Work Storage                | 8TB (shared with M2)                          |


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

## Login to SuperPOD

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

## Requesting a compute node

SuperPOD uses SLURM as scheduler so it is no different from M2 when requesting an interactive node:

For example, requesting a node with 1 GPU, 10 CPUs, 128gb memory for 12 hours:

```
$ srun -N 1 -G 1 -c 10 --mem=128G --time=12:00:00 --pty $SHELL
$ srun -N 1 -G 1 -c 10 --mem=128G --time=12:00:00 --pty bash
```

## Transfering data

- It is no difference when transfering data to-from SuperPOD if you are familiar with M2, you can use scp for regular transfer

```
scp /link/fileA username@superpod.smu.edu:/users/username
```

or using WinSCP if you dont want to use CLI

- Tips, since SuperPOD and M2 share the same work storage, you can utilize this share storage for both systems.



