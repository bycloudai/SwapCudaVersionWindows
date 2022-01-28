# Swap CUDA Toolkit Versions on Windows
Here I will do a quick run down on how to swap CUDA versions.

For ease, I will be demonstrating switching from **CUDA 11.6** to **CUDA 11.3**, the same methods apply to other versions.
## Step 0: Check CUDA Version
Check what version of CUDA you have. You can enter this to any command prompt (cmd, anaconda, etc)
```
nvcc --version
```
* if you get something like this:
    ```
    'nvcc' is not recognized as an internal or external command,
     operable program or batch file.
    ```
    This means you don't have any CUDA installed. You can download your desired CUDA Toolkit version [here](https://developer.nvidia.com/cuda-toolkit-archive) (everything default would be fine)
    
    A quick rule of thumb: 
    * NVIDIA GPU >= 30 series --> CUDA 11.0+
    * NVIDIA GPU < 30 series --> CUDA 10.2 (CUDA 10.0 & 10.1 kinda outdated, use 10.2 unless specified)
    
    You can also check your GPU compatibility [here](https://github.com/pytorch/pytorch/issues/31285#issuecomment-641434931) for NVIDIA GPU < 30 series. If your GPU has CC >= 3.7, then it supports PyTorch.
    
    If you just freshly downloaded CUDA, then you would not need to proceed in the following steps, because you would have the CUDA version you want. You can do another quick check with `nvcc --version` to check your version in any command prompt.
    
* if you get something like this:

  ![image](https://user-images.githubusercontent.com/29135514/151626349-6d0d3507-68f0-423e-a04f-a49724e93b01.png)
  
  Then it means you have CUDA installed. And in my case, it's CUDA 11.6. I will be swapping to CUDA 11.3 in the following steps.
    
## Step 1: Locate System Environment Variables
Open up your environment variables. You can search "env" in the search tab, it should look something like this.
<p align="center">
   <img src="https://user-images.githubusercontent.com/29135514/151625223-18027e0a-1bb4-48f6-aacf-1afb5dd4fdcf.png" width="250">
</p>
Then open it. Then click "Environment Variables"
<p align="center">
   <img src="https://user-images.githubusercontent.com/29135514/151625750-dc5fc2ec-ef62-4f06-a87e-78c61f4dfc01.png" width="400">
</p>
Then it should open up a winodw like this
<p align="center">
   <img src="https://user-images.githubusercontent.com/29135514/151625921-57d87224-720e-44ab-9480-32e9a8b6f424.png" width="600">
</p>

## Step 2: Change System Variables
Double check on `CUDA_PATH` and this window should pop up
<p align="center">
   <img src="https://user-images.githubusercontent.com/29135514/151626793-e6ea1837-4547-44a7-b39c-7a63f078354d.png" width="600">
</p>
Then enter the target version of your CUDA there. In my case it's changing 11.6 to 11.3
<p align="center">
   <img src="https://user-images.githubusercontent.com/29135514/151626887-c7c239a2-3f06-4705-a242-511df611c16c.png" width="600">
</p>

Press ok and proceed next step.

## Step 3: Change System Paths
Scroll down and find `Path`, double click to open
<p align="center">
   <img src="https://user-images.githubusercontent.com/29135514/151627109-59345099-d736-44ac-b38c-37d61cb9e624.png" width="600">
</p>
You should see your current version on the very top. You going have to move your desired version to the very top
<p align="center">
   <img src="https://user-images.githubusercontent.com/29135514/151627505-f7fb27ba-86ef-415d-9f1c-cb666364ab45.png" width="600">
</p>
So it should look like this after moving
<p align="center">
   <img src="https://user-images.githubusercontent.com/29135514/151627544-0ec9dcce-6b13-4d34-b627-b530fd42aad2.png" width="600">
</p>
Press ok and you may now close all the windows for environment variables & system properties.

## Step 4: Check if succeed
**Close** the last command prompt, and **open a new one**. Enter the following command:
```
nvcc --version
```
![image](https://user-images.githubusercontent.com/29135514/151627878-c6dddbab-adf6-4e79-b5cf-3dfb462b1e1d.png)

If it outputs your desired version, then you have succeed in swapping CUDA version.
