---
title: "Using Stable Diffusion with SuperPOD"
teaching: 20
exercises: 0
questions:
- "How to use Stable Diffusion model "
objectives:
- "Learn how to download and install Stable Diffusion from HuggingFace"
keypoints:
- "Stable Diffusion, Prompt, HuggingFace"
---

User can now access to Stable Diffusion from HuggingFace but still utilizing the power of SPOD's A100 GPU to inference the data with any incoming prompt.
The following take an example from [Stable Diffusion model from HuggingFace](https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0)

- First of all, download the library:

```
pip install diffusers --upgrade
```

- Then use the following command with prompt to generate images:

```
from diffusers import DiffusionPipeline
import torch

pipe = DiffusionPipeline.from_pretrained("stabilityai/stable-diffusion-xl-base-1.0", torch_dtype=torch.float16, use_safetensors=True, variant="fp16")
pipe.to("cuda")

# if using torch < 2.0
# pipe.enable_xformers_memory_efficient_attention()

prompt = "An astronaut riding a green horse"

images = pipe(prompt=prompt).images[0]

```

![image](https://github.com/SouthernMethodistUniversity/SMU_SuperPOD_101/assets/43855029/851f55a8-35d5-479d-a1aa-9d11aa005ebb)

