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

# 4. Jupter Lab on SuperPOD

- There is **NO display config and Open OnDemand setup in SuperPOD**, so it is not quite straighforward to use Jupter Lab

- However, it is still possible to use **Port-Forwarding** in SuperPOD in order to run Jupyter Lab.

The following procedure are for Window and MacOS

## 4.1 Using Window OS

For Window, I use MobaXTerm (https://mobaxterm.mobatek.net/) and Firefox to configure port-forwarding

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
   
### 4.2 Using MacsOS/Linux

Open terminal/vscode or similar and type in:
   
```bash
$ ssh -C -D 8000 username@superpod.smu.edu
```   
The C stands for Compression and D stands for Dynamic port-forwarding with SOCKS4/5 to port number 8080. Feel free to change the port and remember to set it up in your browser
   
## 4.3 Setup browser to enable proxy viewing (similar for MacOS/Linux as well)
### 4.3.1 Using Firefox as browser:
   
Open Firefox, my version is 104.0.2.
Use combination Alt+T+S to open up the settings tab. Scroll to bottom and select Settings from Network Settings:
        
![image](https://user-images.githubusercontent.com/43855029/189716620-973851c3-255c-4f21-9af3-ca156f16c980.png)

- Select **Manual Proxy Configuration**
- In the **SOCKS Host**, enter localhost, **Port 8000**
- Check **SOCKS v5**.
- Check **Proxy DNS when using SOCKS v5**.
- Check **Enable DNS over HTTPS**.
- Make sure everything else is unchecked, then click OK.
- Your screenshot should look like below:        
![image](https://user-images.githubusercontent.com/43855029/189716896-4415fb80-9b1f-4287-9ecf-6adc2b1357ef.png)

### 4.3.2 Using Chrome/Safari as browser:

Search for proxies and set a Socks proxy with sever localhost and port 8080.
![image](https://user-images.githubusercontent.com/43855029/228646182-f376dbd2-f850-4ac0-b300-2269e7394321.png)
   
## 4.4 Test Proxy
#### 4.4.1. Test Proxy using conda environment:   
        
Go back to MobaXTerm and login into SuperPOD using regular SSH 
Request a compute node
        
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
$ pip install jupyterlab
```   
   
Next insert the following command:
        
```
$ jupyter notebook --ip=0.0.0.0 --no-browser
# or
$ jupyter lab --ip=0.0.0.0 --no-browser   
```

The following screen appears
   
![image](https://user-images.githubusercontent.com/43855029/211889136-0eb5ef90-b306-454b-8fd9-8fab290b79b4.png)
   
       
Copy the highlighted URLs to **Firefox**, you will see Jupyter Notebook port forward to this:
        
![image](https://user-images.githubusercontent.com/43855029/211889462-ea4ebe65-9f2f-4bc4-9980-493ffe74bed7.png)
   
Select TensorflowGPU29 kernel notebook and Check GPU device:
   
![image](https://user-images.githubusercontent.com/43855029/211889805-da9d0740-3383-4b74-a347-b16525708ba3.png)

#### 4.4.2. Test Proxy using docker container:   
   
For docker container, the command line need to have 1 additional flag:
   
```
$ jupyter lab --ip=0.0.0.0 --no-browser --allow-root
```   

You will need to replace the hostname to the name of the node that you are having:
   
![image](https://user-images.githubusercontent.com/43855029/227258008-3fa4dc64-8b27-4aa3-9844-c476e212b78c.png)
   
For example in the previous command, you need to copy and paste the following line to Firefox browser:
   
```
$ http://bcm-dgxa100-0016:8888/?token=daefb1c3e2754b37b6b94b619387cb3fd9710608e0152182 
```

### Troubleshoot for notebook requesting password
In certain case, your Jupyter Notebook requires password to be enable, you can setup the password using the command below prior to requesting jupyter lab instance:
   
```
$ jupyter notebook password   
```   
   
   
        
        
