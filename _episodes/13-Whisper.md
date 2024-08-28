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

