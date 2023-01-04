---
title: "Using Jupyter Notebook in SuperPOD"
teaching: 20
exercises: 0
questions:
- "How to use Jupter Notebook in SuperPOD?"
objectives:
- "Learn port forwarding technique to enable Jupter Notebook"
keypoints:
- "Jupter Notebook, Port-Forwarding"
---

# 3. Jupter Notebook on SuperPOD

- There is no display config and Open OnDemand setup in SuperPOD, so it is not quite straighforward to use Jupter Notebook

- However, it is still possible to use Port-Forwarding in SuperPOD in order to run JupyterNotebook.

The following procedure are for Window and MacOS

## Using Window OS

For Window, I use MobaXTerm (https://mobaxterm.mobatek.net/) and Firefox to configure port-forwarding

### Setup in MobaXTerm

Open MobaXTerm and Select Tunneling tab:

![image](https://user-images.githubusercontent.com/43855029/189714886-2e90e9fc-123c-48ac-8c2d-c817441b5a09.png)

- Select New SSH tunnel, then select Dynamic port forwarding (SOCKS proxy)
- Filling the information as follows:
    <Forwarded port>: 8080
    <SSH server>: superpod.smu.edu
    <SSH login>: $USERNAME
    <SSH port>: 22
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

- Select Manual Proxy Configuration
- In the SOCKS Host, enter localhost, Port 8080
- Check SOCKS v5.
- Check Proxy DNS when using SOCKS v5.
- Check Enable DNS over HTTPS.
- Make sure everything else is unchecked, then click OK.
- Your screenshot should look like below:        
![image](https://user-images.githubusercontent.com/43855029/189716896-4415fb80-9b1f-4287-9ecf-6adc2b1357ef.png)

## Test Proxy
        
Go back to MobaXTerm and login into SuperPOD using regular SSH 
Request a compute node with container
        
```
srun -N1 -G1 --pty $SHELL
```        

Next insert the following command:
        
```
$ jupyter notebook --ip=0.0.0.0 --no-browser
```

The following screen appears
        
![image](https://user-images.githubusercontent.com/43855029/189718392-0535d2a7-080c-4717-8f69-f25383263416.png)
        
Copy the highlighted URLs to **Firefox**, you will see Jupyter Notebook port forward to this:
        
![image](https://user-images.githubusercontent.com/43855029/189718616-1e34e20e-9553-4b64-818c-fb8e998f62a5.png)
        
        
        
