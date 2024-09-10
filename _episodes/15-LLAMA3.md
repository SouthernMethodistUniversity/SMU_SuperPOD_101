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


The Whisper models are trained for speech recognition and translation tasks, capable of transcribing speech audio into the text in the language it is spoken (ASR) as well as translated into English (speech translation). Researchers at OpenAI developed the models to study the robustness of speech processing systems trained under large-scale weak supervision. There are 9 models of different sizes and capabilities, summarized in the following table.

![image](https://github.com/user-attachments/assets/38f3bca6-854a-4f31-8aa6-ce0027a51cf9)

In December 2022, OpenAI released an improved large model named large-v2, and large-v3 in November 2023.

## How to run Whisper on SuperPOD
Powered by GPU, we can run the Whisper inference using SMU SuperPOD with lightning inferencing.
Given this [mp3 audio](https://github.com/vuminhtue/SMU_SuperPOD_101/blob/master/data/audio1.mp3)
Here are the steps to convert this audio to text transcript:

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


