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

## Pipeline for Computer Vision - Image Classification

```
from transformers import pipeline
clf = pipeline("image-classification")
...

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


### Image classification model Inference

```
clf(img)

[{'score': 0.49216628074645996, 'label': 'Egyptian cat'},
 {'score': 0.41306015849113464, 'label': 'tabby, tabby cat'},
 {'score': 0.050162095576524734, 'label': 'tiger cat'},
 {'score': 0.012556081637740135, 'label': 'lynx, catamount'},
 {'score': 0.00524393143132329, 'label': 'ping-pong ball'}]
```


