---
title: "Using Pre-trained model from HuggingFace"
teaching: 20
exercises: 0
questions:
- "How to use pre-trained model already available from Hugging Face hub"
objectives:
- "To master the usage of pre-trained deep learning model from Hugging Face"
keypoints:
- "Hugging Face, pre-trained, pipeline"
---

# Hugging Face hub
- Hugging Face hub is considered to be Github of Machine Learning
- It is a platform with over **120k models, 20k datasets and 50k demo apps**, All open source and publicly available
- All in one platform where people can easily deploy, collaborate and build ML model

# Transformers library
- The Transformers library, developed by Hugging Face, has played a significant role in making state-of-the-art NLP models more accessible to researchers and developers. 
- It includes pre-trained models like BERT, GPT, RoBERTa, and more, which can be fine-tuned for specific tasks such as text classification, language generation, question answering, and more.
- The library offers a consistent API for various NLP tasks, making it easier for practitioners to experiment with and deploy these models.
  
# Model task
The screenshot below describes the model task from Hugging Face that covers many different aspecs from Computer Vision to NLP, Audio or Reinforcement Learning
![image](https://github.com/vuminhtue/SMU_SuperPOD_101/assets/43855029/11f2feda-8dc8-4fe8-8d26-10bacd3cac53)

# Pipeline for inference

- The ```pipeline()``` makes it simple to use any model from the Hub for inference on any language, computer vision, speech, and multimodal tasks. 
- Even if you don’t have experience with a specific modality or aren’t familiar with the underlying code behind the models, you can still use them for inference with the pipeline()!

## Pipeline for NLP Sentiment Analysis

```
from transformers import pipeline

classifier = pipeline("sentiment-analysis")
classifier("I am so excited to use the new SuperPOD from NVIDIA")

[{'label': 'POSITIVE', 'score': 0.9995261430740356}]
```

```
classifier(
    ["I am so excited to use the new SuperPOD from NVIDIA", "I hate running late"])

[{'label': 'POSITIVE', 'score': 0.9995261430740356},
 {'label': 'NEGATIVE', 'score': 0.9943193197250366}]
```

## Pipeline Text Generation

```
from transformers import pipeline
generator = pipeline("text-generation")
generator("Using SMU latest HPC cluster NVIDIA SuperPOD,  you will be able to")

[{'generated_text': 'Using SMU latest HPC cluster NVIDIA SuperPOD,  you will be able to connect to other SSE nodes such as the following and use them as a HPC node:\n\n[CPU: CPU1, GIGABYTE'}]
```

## Pipeline for Mask filling

```
from transformers import pipeline

unmasker = pipeline("fill-mask")
unmasker("This course will teach you all about <mask> models.", top_k=2)

[{'score': 0.19619698822498322,
  'token': 30412,
  'token_str': ' mathematical',
  'sequence': 'This course will teach you all about mathematical models.'},
 {'score': 0.04052705690264702,
  'token': 38163,
  'token_str': ' computational',
  'sequence': 'This course will teach you all about computational models.'}]
```

## Pipeline for Name Entity Recognition

```
from transformers import pipeline

ner = pipeline("ner", grouped_entities=True)
ner("My name is Tue Vu and I work at SMU in Dallas")

[{'entity_group': 'PER',
  'score': 0.9868829,
  'word': 'Tue Vu',
  'start': 11,
  'end': 17},
 {'entity_group': 'ORG',
  'score': 0.9965092,
  'word': 'SMU',
  'start': 32,
  'end': 35},
 {'entity_group': 'LOC',
  'score': 0.9950755,
  'word': 'Dallas',
  'start': 39,
  'end': 45}]
```

## Pipeline for Question Answering

```
from transformers import pipeline

question_answerer = pipeline("question-answering")
question_answerer(
    question="Where do I work?",
    context="My name is Tue Vu and I work at SMU in Dallas",
)

{'score': 0.3651700019836426, 'start': 32, 'end': 35, 'answer': 'SMU'}
```

## Pipeline for Computer Vision - Image Classification

```
from transformers import pipeline
clf = pipeline("image-classification")
```

Display the image:

```
import urllib.request
from io import BytesIO

url = 'https://t4.ftcdn.net/jpg/02/66/72/41/360_F_266724172_Iy8gdKgMa7XmrhYYxLCxyhx6J7070Pr8.jpg'
with urllib.request.urlopen(url) as url:
    img = Image.open(BytesIO(url.read()))
img
```

![360_F_266724172_Iy8gdKgMa7XmrhYYxLCxyhx6J7070Pr8](https://github.com/vuminhtue/SMU_SuperPOD_101/assets/43855029/6170fc20-3cec-4049-a363-9c4f3f85660f)


### Model Inference

```
clf(img)

[{'score': 0.49216628074645996, 'label': 'Egyptian cat'},
 {'score': 0.41306015849113464, 'label': 'tabby, tabby cat'},
 {'score': 0.050162095576524734, 'label': 'tiger cat'},
 {'score': 0.012556081637740135, 'label': 'lynx, catamount'},
 {'score': 0.00524393143132329, 'label': 'ping-pong ball'}]
```

