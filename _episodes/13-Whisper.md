---
title: "Using OpenAI Whisper"
teaching: 20
exercises: 0
questions:
- "How to use OpenAI Whisper"
objectives:
- "Using Whisper with GPU"
keypoints:
- "OpenAI, whisper, gpu"
---

# Whisper
- Introduced by OpenAI and now open-source since 09/2022
- Speech Recognigtion


## Detail:

Whisper is an automatic speech recognition (ASR) system trained on 680,000 hours of multilingual and multitask supervised data collected from the web. We show that the use of such a large and diverse dataset leads to improved robustness to accents, background noise and technical language. Moreover, it enables transcription in multiple languages, as well as translation from those languages into English. We are open-sourcing models and inference code to serve as a foundation for building useful applications and for further research on robust speech processing.

![image](https://github.com/user-attachments/assets/aa8e6c55-1e61-4983-982c-3cb446d76b60)

The Whisper architecture is a simple end-to-end approach, implemented as an encoder-decoder Transformer. Input audio is split into 30-second chunks, converted into a log-Mel spectrogram, and then passed into an encoder. A decoder is trained to predict the corresponding text caption, intermixed with special tokens that direct the single model to perform tasks such as language identification, phrase-level timestamps, multilingual speech transcription, and to-English speech translation.

More information can be found [here](https://openai.com/index/whisper/)



### Models:
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
$ whisper audio1.mp3 --device cuda --model small --language en --output_format txt > audio3.txt
```

In the example above, the run is less than 30s using GPU
- flag **--device cuda**: enable GPU processing
- flag **--model small**: use the model size 244M for processing
- the pipe **>**: to print out the output name
- to get more header for whisper, run the command:

```
$ whisper -h
```


