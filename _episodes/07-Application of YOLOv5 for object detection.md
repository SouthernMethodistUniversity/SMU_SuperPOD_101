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
$ git clone https://github.com/ultralytics/yolov5.git
```

**Suggestion:**: It is better to use $WORK directory to store the code and data to avoid jamming up your $HOME directory

## Open Conda env and install requirement

Prior to training YOLOv5 model, it's better to go to your own conda env and install the missing library. For simplicit, I use NEMO Container:

```bash
$ srun -n1 --gres=gpu:1 --container-image $WORK/sqsh/nvidia+nemo+22.04.sqsh --container-mounts=$WORK --time=12:00:00 --pty $SHELL
```

Go to yolov5 folder and install missing library

```bash
$ cd yolov5
$ pip install -r requirements.txt 
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

unzip the **open-images-2019-object-detection.zip** to get the **test** folder with 100000 images.

## Inference using YOLOv5 for object detection with Kaggle data

The weight is used from pretrained model **best.pt**, 

```
$ python detect.py --weights runs/train/exp/weights/best.pt --img 1280 --conf 0.25 --source ../test
```

Output of the inference would look like:

```
detect: weights=['runs/train/exp/weights/best.pt'], source=../test, data=data/coco128.yaml, imgsz=[1280, 1280], conf_thres=0.25, iou_thres=0.45, max_det=1000, device=, view_img=False, save_txt=False, save_conf=False, save_crop=False, nosave=False, classes=None, agnostic_nms=False, augment=False, visualize=False, update=False, project=runs/detect, name=exp, exist_ok=False, line_thickness=3, hide_labels=False, hide_conf=False, half=False, dnn=False, vid_stride=1
YOLOv5 🚀 v7.0-56-gc0ca1d2 Python-3.8.13 torch-1.13.0a0+d0d6b1f CUDA:0 (NVIDIA A100-SXM4-80GB, 81251MiB)

Fusing layers... 
Model summary: 157 layers, 7225885 parameters, 0 gradients, 16.4 GFLOPs
image 1/17 /work/users/tuev/YOLO/test/000000000508.jpg: 960x1280 (no detections), 149.3ms
image 2/17 /work/users/tuev/YOLO/test/000000000510.jpg: 960x1280 1 person, 2 benchs, 1 frisbee, 8.2ms
image 3/17 /work/users/tuev/YOLO/test/000000000514.jpg: 1280x736 1 bed, 145.4ms
image 4/17 /work/users/tuev/YOLO/test/000000000520.jpg: 960x1280 3 persons, 1 boat, 5 birds, 2 kites, 8.7ms
image 5/17 /work/users/tuev/YOLO/test/000000000529.jpg: 1280x864 2 motorcycles, 144.1ms
image 6/17 /work/users/tuev/YOLO/test/000000000531.jpg: 960x1280 9 persons, 1 bicycle, 1 tennis racket, 8.6ms
image 7/17 /work/users/tuev/YOLO/test/000000000532.jpg: 960x1280 2 persons, 1 bus, 2 trucks, 2 handbags, 8.0ms
image 8/17 /work/users/tuev/YOLO/test/000000000536.jpg: 960x1280 3 persons, 1 handbag, 1 mouse, 1 cell phone, 8.0ms
image 9/17 /work/users/tuev/YOLO/test/000000000540.jpg: 864x1280 6 cars, 1 airplane, 1 truck, 145.7ms
image 10/17 /work/users/tuev/YOLO/test/000000000542.jpg: 992x1280 11 persons, 145.7ms
image 11/17 /work/users/tuev/YOLO/test/000000000544.jpg: 864x1280 14 persons, 1 sports ball, 1 baseball glove, 8.7ms
image 12/17 /work/users/tuev/YOLO/test/000000000560.jpg: 896x1280 1 potted plant, 1 bed, 1 toilet, 1 vase, 146.1ms
image 13/17 /work/users/tuev/YOLO/test/000000000562.jpg: 1280x864 3 toothbrushs, 8.6ms
Speed: 0.5ms pre-process, 68.9ms inference, 6.7ms NMS per image at shape (1, 3, 1280, 1280)
Results saved to runs/detect/exp
```
The model output images can be found in /run/detect/exp.

Sample model result:

![image](https://user-images.githubusercontent.com/43855029/210882960-04a62669-22b6-43b0-b885-98756f7f62cd.png)


## Inference using YOLOv5 for object detection with video

We can also use YOLOv5 for video detection.
From the sample video like this:

https://user-images.githubusercontent.com/43855029/222778747-b5312f6d-58c9-4f63-9233-93dfa65f8345.mp4

We run the inference with the best pretrained model using following command:

```
$ python detect.py --weights runs/train/exp/weights/best.pt --source  video.mp4
```

output of the inference would look like:

```
detect: weights=['runs/train/exp/weights/best.pt'], source=../test/before_short.mp4, data=data/coco128.yaml, imgsz=[640, 640], conf_thres=0.25, iou_thres=0.45, max_det=1000, device=, view_img=False, save_txt=False, save_conf=False, save_crop=False, nosave=False, classes=None, agnostic_nms=False, augment=False, visualize=False, update=False, project=runs/detect, name=exp, exist_ok=False, line_thickness=3, hide_labels=False, hide_conf=False, half=False, dnn=False, vid_stride=1
YOLOv5 🚀 v7.0-56-gc0ca1d2 Python-3.8.13 torch-1.13.0a0+d0d6b1f CUDA:0 (NVIDIA A100-SXM4-80GB, 81251MiB)

Fusing layers... 
Model summary: 157 layers, 7225885 parameters, 0 gradients, 16.4 GFLOPs
video 1/1 (1/120) /work/users/tuev/YOLO/test/before_short.mp4: 384x640 2 trains, 156.8ms
video 1/1 (2/120) /work/users/tuev/YOLO/test/before_short.mp4: 384x640 2 trains, 8.2ms
video 1/1 (3/120) /work/users/tuev/YOLO/test/before_short.mp4: 384x640 2 trains, 8.2ms
video 1/1 (4/120) /work/users/tuev/YOLO/test/before_short.mp4: 384x640 2 trains, 8.1ms
video 1/1 (5/120) /work/users/tuev/YOLO/test/before_short.mp4: 384x640 2 trains, 8.1ms
video 1/1 (6/120) /work/users/tuev/YOLO/test/before_short.mp4: 384x640 2 trains, 8.1ms
video 1/1 (7/120) /work/users/tuev/YOLO/test/before_short.mp4: 384x640 3 trains, 8.1ms
video 1/1 (8/120) /work/users/tuev/YOLO/test/before_short.mp4: 384x640 2 trains, 8.1ms
video 1/1 (9/120) /work/users/tuev/YOLO/test/before_short.mp4: 384x640 2 trains, 8.2ms
video 1/1 (10/120) /work/users/tuev/YOLO/test/before_short.mp4: 384x640 2 trains, 8.2ms
Speed: 0.3ms pre-process, 9.4ms inference, 2.2ms NMS per image at shape (1, 3, 640, 640)
Results saved to runs/detect/exp2
```

and the output video is saved in runs/detect/exp2 folder:

https://user-images.githubusercontent.com/43855029/222778650-f68c4a4f-ad51-4237-92a8-bfb0ad37cd54.mp4





