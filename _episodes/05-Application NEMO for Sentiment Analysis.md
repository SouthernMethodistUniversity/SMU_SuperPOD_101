---
title: "Sample Application of NEMO for Sentiment Analysis"
teaching: 20
exercises: 0
questions:
- "How to use NEMO in container"
objectives:
- "Apply NEMO to run sentiment analysis"
keypoints:
- "NGC Container, NEMO, Sentiment Analysis"
---

# NeMo

- **Neural Module - NeMo**  is a toolkit for building new state-of-the-art conversational AI models.
- NeMo has separate collections for Automatic Speech Recognition (ASR), Natural Language Processing (NLP), and Text-to-Speech (TTS) synthesis models.
- Each collection consists of prebuilt modules that include everything needed to train on your data. Every module can easily be customized, extended, and composed to create new conversational AI model architectures.

## Import and Create NeMo sqsh file:

The NGC for NeMo can be found here: https://catalog.ngc.nvidia.com/orgs/nvidia/containers/nemo

```
$ enroot import docker://nvcr.io#nvidia/nemo:22.09
$ enroot create nvidia+nemo+22.09.sqsh
```

## Sentiment Analysis using NeMo

Here we use this [sentiment sample](https://docs.nvidia.com/deeplearning/nemo/user-guide/docs/en/stable/nlp/text_classification.html) from NVIDIA

## SST2 data:

We download the Stanford Sentiment Treebank v2 (SST-2) and preprocess to nemo format for training and testing data

```
cd $WORK
mkdir nemo && cd nemo

curl -s -O https://dl.fbaipublicfiles.com/glue/data/SST-2.zip\
 && unzip -o SST-2.zip -d ./\
 && sed 1d ./SST-2/train.tsv > ./train_nemo_format.tsv\
 && sed 1d ./SST-2/dev.tsv > ./dev_nemo_format.tsv &
```

## Requesting a compute node with NeMo container enable with a GPU:

```
srun -N1 -G1 -c10 --mem=64G --time=12:00:00 --container-image $WORK/sqsh/nvidia+nemo+22.09.sqsh --container-mounts=$WORK --pty bash -i
```

## Let's run Sentiment Analysis using NeMo
- The model named 'bert-base-cased'
- Computation using 2 GPUs and 20 epochs

```
cd $WORK/nemo/SST-2
python /workspace/nemo/examples/nlp/text_classification/text_classification_with_bert.py \
      model.dataset.num_classes=2 \
      model.dataset.max_seq_length=256 \
      model.train_ds.batch_size=64 \
      model.validation_ds.batch_size=64 \
      model.language_model.pretrained_model_name='bert-base-cased' \
      model.train_ds.file_path=train_nemo_format.tsv \
      model.validation_ds.file_path=dev_nemo_format.tsv \
      trainer.num_nodes=1 \
      trainer.max_epochs=20 \
      trainer.precision=16 \
      model.optim.name=adam \
      model.optim.lr=1e-4
```       

Check the GPU usage with **nvidia-smi** command

Output of the model training is text_classification_model.nemo

### Model Evaluation and Inference
- After saving the model in **.nemo** format, you can load the model and perform evaluation or inference on the model.
- Following is the content of python file to load the trained nemo model and evaluate it:

```python
from nemo.collections.nlp.models.text_classification import TextClassificationModel
model = TextClassificationModel.restore_from("text_classification_model.nemo")
model.to("cuda")

# define the list of queries for inference
queries = ['legendary irish writer brendan behan memoir , borstal boy',
           'demonstrates that the director of such hollywood blockbusters as patriot games can still turn out a small , personal film with an emotional wallop ', 
           'on the worst revenge-of-the-nerds clichés the filmmakers could dredge up', 
           'uneasy mishmash of styles and genres']

results = model.classifytext(queries=queries, batch_size=3, max_seq_length=512)

print('The prediction results of some sample queries with the trained model:')
for query, result in zip(queries, results):
    print(f'Query : {query}')
    print(f'Predicted label: {result}')
```

