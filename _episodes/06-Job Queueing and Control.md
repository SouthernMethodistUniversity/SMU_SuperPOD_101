---
title: "Job queueing and control in SuperPOD"
teaching: 20
exercises: 0
questions:
- "How to run control Job in SuperPOD"
objectives:
- "To teach command to work with Job in SLURM"
keypoints:
- "Job queue, control"
---

The SuperPOD cluster uses the Simple Linux Utility for Resource Management system (SLURM) to manage jobs.

# 5b. Job Queue and Control

In SLURM there are several usefull commands for checking your job:

## Lifecycle of a Job

The life of a job begins when you submit the job to the scheduler. If accepted, it will enter the Queued state.

Thereafter, the job may move to other states, as defined below:

- Queued - the job has been accepted by the scheduler and is eligible for execution; waiting for resources.
- Held - the job is not eligible for execution because it was held by user request, administrative action, or job dependency.
- Running - the job is currently executing on the compute node(s).
- Finished - the job finished executing or was canceled/deleted.
The diagram below demonstrates these relationships in graphical form.

![image](https://github.com/SouthernMethodistUniversity/SMU_SuperPOD_101/assets/43855029/5836f7b1-fe76-4c22-bca7-e77d9d227ea6)


## Useful Commands
Here are some basic SLURM commands for submitting, querying and deleting jobs in SuperPOD:

| Command                     | Actions                                       |
|-----------------------------|-----------------------------------------------|
| ```srun -N1 -G1 --pty $SHELL```      | Submit an interactive job (reserves 1 Node, 1GPU, 1CPU, 6gb RAM, 1 hour walltime)                                 |
| ```sbatch job.sh```             | submit the job script *job.sh*                                            |
| ```sstat <job id>```                   | Check the status of the job given jobID                                         |
|  ```sstat <job id> --format=AveCPU,AvePages,AveRSS,AveVMSize,JobID```             | Narrow some information on sstat                                       |
| ```squeue -u <username>``` | Check the status of all jobs submitted by given username |
| ```scontrol show job <job id>```                | Check the detailed information for job with given job ID                             |
|```scancel <job id>```           | Delete the queued or running job given job ID                                 |

#### Check pending, working job:

```
$ squeue -u $USERNAME

JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON
12345  workshop     bash     tuev  R      39:46      1 bcm-dgxa100-0002
```

The above Job has a JOBID=12345, which will be used below:

#### Check configuration of any requested job using JOBID:

```
$ scontrol show job 12345 grep ReqTRES

ReqTRES=cpu=5,mem=30G,node=1,billing=5,gres/gpu=1
```

#### Delete any job

```
$ scancel 12345
```

#### Checking how your job is running in node
When you know your working node, for example **bcm-dgxa100-0001**, from login node, you can login to the compute node and check the processing:

- Command to check working cpus:

```
$ ssh bcm-dgxa100-0001
$ top -u $USERNAME
```

- Command to check working gpus:

```
$ ssh bcm-dgxa100-0001
$ nvidia-smi
OR to refresh the command every 0.2s
$ watch -n .2 nvidia-smi
```
