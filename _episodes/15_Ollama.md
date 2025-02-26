---
title: "How to use Ollama with SuperPOD"
teaching: 20
exercises: 0
questions:
- "How to use Ollama"
objectives:
- "OLLAMA on SuperPOD"
keypoints:
- "Meta, Ollama, SuperPOD"
---

# OLLAMA
- Ollama is an open-source framework that enables users to run, create, and manage large language models (LLMs) locally on their computers and on HPC system

## Key Features of Ollama:

- **Model Library**: Ollama provides access to a diverse collection of pre-built models, including Llama 3.2, Phi 3, Mistral, and Gemma 2, among others. Users can easily download and run these models for various applications. 
- **Customization**: Users can create and customize their own models using a straightforward API, allowing for tailored solutions to specific tasks. 
- **Cross-Platform Support**: Ollama is compatible with macOS, Linux, and Windows operating systems, ensuring broad accessibility. 

## Ollama on SuperPOD
- Although user can run Ollama on their personal PCs but with very large LLM model like LLAMA3 with 70B or 450B, you would need a strong GPU as A100 in SuperPOD
- The model like LLAMA3 450B can easily consumes 200gb storage of your PCs, so we have that saved locally for user to just load and run it
- Ollama version 4 has been pre-installed as module on SuperPOD, making it easier to work with

## How to use LLaMA3 on SuperPOD

### Step 1: request a compute node with 1 GPU:

```bash
$ srun -A Allocation -N1 -G1 --mem=64gb --time=12:00:00 --pty $SHELL
```

### Step 2: Load Ollama model:

```bash
$ module load ollama
```

### Step 3: Export path to Ollama model

Here we use Ollama models from STARS Project storage. Please inform me if you need access to that location.

```bash
$ export OLLAMA_MODELS=/projects/tuev/LLMs/LLMs/Ollama_models/
```

### Step 4: Serve Ollama

```bash
$ ollama serve &
```

### Step 5: Now Ollama has been loaded and served. Let's check the local models:

```bash
$ ollama list
```

You should see the screen like this:

![image](https://github.com/user-attachments/assets/bef9b961-8672-4d7f-9c3e-220ad1fde389)

If there are any other models that you want us to download, please email me: tuev@smu.edu

### Step 6: Download Ollama model

You can download any LLM model that you downloaded previously to chat:

```bash
$ ollama pull llama3:70
```

### Step 7: Run Ollama model

You can run any LLM model that you downloaded previously to chat:

```bash
$ ollama run llama3:70
```

![image](https://github.com/user-attachments/assets/1cd89849-03f6-4d50-acc4-b3c0252cac6d)


### Step 8: Stop Ollama model

```bash
$ killall ollama
```

