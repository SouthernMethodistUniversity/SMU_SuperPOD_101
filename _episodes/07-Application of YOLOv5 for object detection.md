---
title: "Using YOLOv5 for object detection"
teaching: 20
exercises: 0
questions:
- "How to use train YOLOv5 to detect objects"
objectives:
- "Download pretrained YOLOv5 and images then apply YOLO to detect object"
keypoints:
- "YOLOv5, object detection, inference"
---

# YOLOv5

YOLOv5 🚀 is the world's most loved vision AI, representing Ultralytics open-source research into future vision AI methods, incorporating lessons learned and best practices evolved over thousands of hours of research and development.

To download YOLO, simply go to the github page and clone it to your home or work directory:

```bash
git clone https://github.com/ultralytics/yolov5.git
```

**Suggestion:**: It is better to use $WORK directory to store the code and data to avoid jamming up your $HOME directory

## Open Conda env and install requirement

Prior to training YOLOv5 model, it's better to go to your own conda env and install the missing library. For simplicit, I use NEMO Container:

```bash
$ srun -n1 --gres=gpu:1 --container-image $WORK/sqsh/nvidia+nemo+22.04.sqsh --container-mounts=$WORK --time=12:00:00 --pty $SHELL
```

Go to yolov5 folder and install missing library

```bash
cd yolov5
pip install -r requirements.txt 
```

## Select Pretrained model

Refer to this [table](https://github.com/ultralytics/yolov5#pretrained-checkpoints) for full comparison of models.
Here let's use **yolov5l6** for better performance

![image](https://user-images.githubusercontent.com/43855029/210874334-2cd63117-f730-4e8f-b704-82d1bac329d5.png)

## Dataset for training:

YOLOv5 is trained by using COCO (Common Object in Context) dataset, here we use coco128 which is 128 classes of images from larger COCO dataset. 

The dataset is automatically downloaded when using flag **--data coco128.yaml**

## Train YOLOv5

Let's train model with image size of 1280 pixels, 32 batches and 10 epochs, the data in use is coco128  and pretrained model is yolov5l6:

```bash
$ python train.py --img 1280 --batch 32 --epochs 10 --data coco128.yaml --weights yolov5l6.pt
```

Tail of The output from model training:

```
 Epoch    GPU_mem   box_loss   obj_loss   cls_loss  Instances       Size
        9/9      75.5G    0.02099    0.05281   0.006695        573       1280: 100%|██████████| 4/4 [00:03<00:00,  1.17it/s]
                 Class     Images  Instances          P          R      mAP50   mAP50-95: 100%|██████████| 2/2 [00:01<00:00,  1.01it/s]
                   all        128        929      0.905      0.805      0.902      0.736

10 epochs completed in 0.031 hours.
Optimizer stripped from runs/train/exp/weights/last.pt, 154.9MB
Optimizer stripped from runs/train/exp/weights/best.pt, 154.9MB
```

Here we see that there are 2 pretrained model created from the training process **last.pt and best.pt** from corresponding output location.

We will use the **best.pt** weight for model inference:

## To validate the model inference, we use the data from Kaggle

The Kaggle dataset can be found here: https://www.kaggle.com/competitions/open-images-2019-object-detection/data#

Using Kaggle API, one can simply download the dataset from CLI:

```
kaggle competitions download -c open-images-2019-object-detection
```

unzip the **open-images-2019-object-detection.zip** to get the **test** folder with 10000 images.

## Inference using NEMO for object detection with Kaggle data

The weight is used from pretrained model **best.pt**, 

```
python detect.py --weights runs/train/exp/weights/best.pt --img 1280 --conf 0.25 --source ../test
```

The model output can be found in /run/detect/exp
