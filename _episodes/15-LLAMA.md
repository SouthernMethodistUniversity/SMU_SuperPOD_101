---
title: "Using LLAMA"
teaching: 20
exercises: 0
questions:
- "How to use LLAMA"
objectives:
- "Using LLAMA3 on SuperPOD"
keypoints:
- "Meta, LLAMA, SuperPOD"
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

## How to use LLaMA on SuperPOD


### LLaMA

### Step 1: Install libraries:
Load one of the conda environment in SuperPOD (also load corresponding cuda, cudnn library as in Step 2) and install whisper:

```
pip install git+https://github.com/openai/whisper.git
pip install ffmpeg
```

### Step 2: Run whisper inference with GPU supported:

The file [audio1.mp3](https://github.com/vuminhtue/SMU_SuperPOD_101/blob/master/data/audio1.mp3) has the size of 21mb and is 23 minutes long in speech.

Let's run an Whisper API inference in the commandline interface (I change the directory of running to the same directory as audio1):

```
$ whisper audio1.mp3 --device cuda --model small --language en --output_format txt > audio1.txt
```

In the example above, the run is less than 30s using GPU
- flag **--device cuda**: enable GPU processing
- flag **--model small**: use the model size 244M for processing
- the pipe **>**: to print out the output name
- to get more header for whisper, run the command:

```
$ whisper -h
```


