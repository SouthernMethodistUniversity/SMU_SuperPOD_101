---
title: "Using LLAMA3"
teaching: 20
exercises: 0
questions:
- "How to use LLAMA3"
objectives:
- "Using LLAMA3 on SuperPOD"
keypoints:
- "Meta, LLAMA3, SuperPOD"
---

# LLAMA
- Introduced by META in [Introducing Meta Llama 3: The most capable openly available LLM to date](https://huggingface.co/docs/transformers/en/model_doc/llama3)
- Several version:
  - LLaMA1: released early 2023, was designed to be smaller and more efficient than other large models like GPT-3, while maintaining competitive performance. It was released in various sizes, such as 7B, 13B, 30B, and 65B parameters.
  - LLaMA2: released in July 2023, LLaMA 2 improved upon the original version with enhanced performance, training techniques, and increased scalability. It also includes versions with 7B, 13B, and 70B parameters. Meta open-sourced LLaMA 2, and it was made available for both research and commercial use.
  - LLaMA3: released in Apr 2024 and came with 3 versions 8B, 70B and 405B parameters
  
## Models:
All LLaMA models can be found from the HuggingFace:
- [LLaMA](https://huggingface.co/docs/transformers/en/model_doc/llama)
- [LLaMA2](https://huggingface.co/docs/transformers/en/model_doc/llama2)
- [LLaMA3](https://huggingface.co/docs/transformers/en/model_doc/llama3)

## How to use LLaMA3 on SuperPOD
- In order to use LLaMA (any version) on SuperPOD, we will use the pytorch_1.13 conda environment created in [Chapter 2](https://southernmethodistuniversity.github.io/SMU_SuperPOD_101/02-Working%20with%20Conda/index.html) and use port-forwarding for JupyterLab as in [Chapter 4](https://southernmethodistuniversity.github.io/SMU_SuperPOD_101/04-Using%20JupterLab/index.html)

### Step 1: Request a compute node & Load the conda environment
- Once logged in to SuperPOD, let's request a compute node and load the conda environment:
- We will request for a node with 1 GPU:
  
```
$ srun -N1 -c10 -G1 --mem=64gb --time=12:00:00 --pty $SHELL
$ module load conda gcc/11.2.0
$ module load cuda/11.8.0-vbvgppx cudnn
$ conda activate ~/pytorch_1.13
$ jupyter lab --ip=0.0.0.0 --no-browser --allow-root
```
- Following are the instruction on how to use SuperPOD to run [LLaMA3](https://huggingface.co/meta-llama/Meta-Llama-3-8B) on SuperPOD

### Step 2: Request LLaMA3 access
- For a new HuggingFace account, in order to access the open source LLaMA3, you will need to agree the license:
![image](https://github.com/user-attachments/assets/0c2aedb3-f0a3-4011-8f13-7b565f1896ec)

![image](https://github.com/user-attachments/assets/ad76cf75-e637-498b-b001-7539f0e1008b)

Sometimes, it takes a day for you to get approval.

### Step 3: Install HuggingFace Hub
Following the guideline [here](https://huggingface.co/docs/huggingface_hub/en/quick-start) to install HuggingFace Hub into your SuperPOD home folder

### Step 4: Create HuggingFace Token

- Create a HuggingFace account and click on your account logo and choose setting:
![image](https://github.com/user-attachments/assets/60fd8665-6294-47ca-9cb8-ed33711b2961)

- Select Access Tokens:
![image](https://github.com/user-attachments/assets/1d0ed016-2a40-44d2-bdd8-e2b39ea3249c)

- Create new token:
![image](https://github.com/user-attachments/assets/caaf5237-ba16-4f10-8a7c-b2ac9711f1b1)

- Save token into your huggingface folder (created from Step 3). Note that a huggingface folder is hidden, so you need to use "." in front of that folder for access

### Step 5: Get ready to load LLaMA3 model in your port-forwared JupyterLab env:
![image](https://github.com/user-attachments/assets/5e1ce719-b7c7-4be2-ae88-412e48481e3f)

Follow the example from HuggingFace, we have the following result:

![image](https://github.com/user-attachments/assets/0a377a1f-c935-4488-93be-0bbd7c87e56d)










