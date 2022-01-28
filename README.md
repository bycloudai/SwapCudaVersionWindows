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
    
* if you get something like this:

  ![image](https://user-images.githubusercontent.com/29135514/151626349-6d0d3507-68f0-423e-a04f-a49724e93b01.png)
  
  Then it means you have CUDA installed. And in my case, it's CUDA 11.6
    
## Step 1: Swap CUDA Version 
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
   <img src="https://user-images.githubusercontent.com/29135514/151625921-57d87224-720e-44ab-9480-32e9a8b6f424.png" width="400">
</p>


