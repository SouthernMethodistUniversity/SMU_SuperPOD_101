---
title: "Using Jupyter Lab in SuperPOD"
teaching: 20
exercises: 0
questions:
- "How to use Jupter Lab in SuperPOD?"
objectives:
- "Learn port forwarding technique to enable Jupter Lab"
keypoints:
- "Jupter Lab, Port-Forwarding"
---

# 3. Jupter Notebook on SuperPOD

- There is no display config and Open OnDemand setup in SuperPOD, so it is not quite straighforward to use Jupter Lab

- However, it is still possible to use Port-Forwarding in SuperPOD in order to run Jupyter Lab.

The following procedure are for Window and MacOS

## Using Window OS

For Window, I use MobaXTerm (https://mobaxterm.mobatek.net/) and Firefox to configure port-forwarding

### Setup in MobaXTerm

Open MobaXTerm and Select Tunneling tab:

![image](https://user-images.githubusercontent.com/43855029/189714886-2e90e9fc-123c-48ac-8c2d-c817441b5a09.png)

- Select **New SSH tunnel**, then select **Dynamic port forwarding (SOCKS proxy)**
- Filling the information as follows:
    **<Forwarded port>**: 8080
    **<SSH server>**: superpod.smu.edu
    **<SSH login>**: $USERNAME
    **<SSH port>**: 22
- Click Save
       
![image](https://user-images.githubusercontent.com/43855029/189715197-37ce44ee-b4f7-4b88-900c-dc9d2442168f.png)

The Graphical port forwarding tool appears, Click on play button
      
![image](https://user-images.githubusercontent.com/43855029/189715476-66ca7a82-87d6-4230-8aca-e508d1db96ae.png)

The Duo screen appears, enter 1 to authenticate the Duo
Once you pass the Duo screen, the port forwarding tool enabled:
      
![image](https://user-images.githubusercontent.com/43855029/189716103-1ac8f8b4-e822-4ed7-a7e8-a6d3e1f9c9c8.png)

Leave the port-forwarding screen opened and we switch to Firefox

### Setup Firefox to enable proxy viewing (similar for MacOS as well)

Open Firefox, my version is 104.0.2.
Use combination Alt+T+S to open up the settings tab. Scroll to bottom and select Settings from Network Settings:
        
![image](https://user-images.githubusercontent.com/43855029/189716620-973851c3-255c-4f21-9af3-ca156f16c980.png)

- Select **Manual Proxy Configuration**
- In the **SOCKS Host**, enter localhost, **Port** 8080
- Check **SOCKS v5**.
- Check **Proxy DNS when using SOCKS v5**.
- Check **Enable DNS over HTTPS**.
- Make sure everything else is unchecked, then click OK.
- Your screenshot should look like below:        
![image](https://user-images.githubusercontent.com/43855029/189716896-4415fb80-9b1f-4287-9ecf-6adc2b1357ef.png)

## Test Proxy
        
Go back to MobaXTerm and login into SuperPOD using regular SSH 
Request a compute node with container
        
```bash
$ srun -N1 -G1 -c10 --mem=64G --time=12:00:00 --pty $SHELL
```        

Load cuda, cudnn and activate any of your conda environment, for example Tensorflow_2.9
   
```bash
$ module load spack conda
$ module load cuda-11.4.4-gcc-10.3.0-ctldo35 cudnn-8.2.4.15-11.4-gcc-10.3.0-eluwegp
$ source activate ~/tensorflow_2.9   
``` 
   
Make sure to install jupyter
   
```
$ pip install jupyter   
```   
   
Next insert the following command:
        
```
$ jupyter notebook --ip=0.0.0.0 --no-browser
# or
$ jupyter lab --ip=0.0.0.0 --no-browser   
```

The following screen appears
        
![image](https://user-images.githubusercontent.com/43855029/211874487-99ead2fa-83c9-457f-947b-e369b02ac713.png)
        
Copy the highlighted URLs to **Firefox**, you will see Jupyter Notebook port forward to this:
        
![image](https://user-images.githubusercontent.com/43855029/211874565-034ade54-349a-4025-a0f0-5f6a6434b0b5.png)        

Select TensorflowGPU29 kernel

![image](https://user-images.githubusercontent.com/43855029/211874741-3b5ddf7e-4ac9-4b8c-b822-a3520abb527d.png)
   
Check GPU device:
   
![image](https://user-images.githubusercontent.com/43855029/211874984-b0f0dd88-ff18-442e-b892-66537fe43bfa.png)
   
   

   
        
        
