# AI by AI

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![UPRJ_CI](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml) [![Caravel Build](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml)

Author: Emilio Baungarten

Description: Integrated Circuit (IC) for a CNN-based MNIST Classifier using ChatGPT-4

## Objective:
Develop a dedicated hardware integrated circuit (IC) for a convolutional neural network (CNN) that classifies the MNIST dataset. The primary aim is for ChatGPT-4 to generate the RTL (Register-Transfer Level) code necessary to create the IC, incorporating insights and optimizations along the way.

## Background:
The MNIST dataset is a well-known collection of handwritten digits widely used in the machine-learning community for benchmarking and testing. A CNN is particularly suited for image classification tasks like those posed by the MNIST dataset. By moving from software to a hardware implementation, we can achieve faster computation times and lower power consumption.

Furthermore, the integration of AI in IC development has ushered in a new era of hardware design, where iterative processes and optimization techniques previously reserved for software can now be applied directly to hardware architectures. Using AI to facilitate and streamline the design process can lead to more efficient and effective IC designs that can adapt and evolve. Choosing the MNIST dataset for this venture serves as an ideal proof of concept, given its historical significance in machine learning. The fusion of AI-driven RTL code development, especially with tools like ChatGPT-4, and the time-tested MNIST dataset, symbolizes the confluence of the traditional and the cutting-edge in the world of computational design.

## Components:
1. Dataset: MNIST
   - 60,000 training images
   - 10,000 testing images
   - Grayscale images of size 28x28 pixels

2. CNN Architecture:
   - Input Layer:
      - Dimensions: 28x28x1 (reflecting the grayscale images)
      - The input data is normalized by dividing it by 255 to scale values between 0 and 1.
      - Data Type: float16
   
   - Convolutional Layer 1:
      - Filters: 4
      - Kernel Size: 3x3
      - Activation: ReLU

   - Max Pooling Layer 1:
      - Pooling Size: 4x4

   - Convolutional Layer 2:
      - Filters: 8
      - Kernel Size: 3x3
      - Activation: ReLU

   - Max Pooling Layer 2:
      - Pooling Size: 2x2

   - Flattening Layer:
      - The output of the previous layer is flattened to prepare it for the fully connected layer.

   - Output Layer:
      - Neurons: 10 (corresponding to the 10-digit classes)
      - Note: The data type for this layer is specifically set to float16.

By changing the architecture to include fewer filters in the convolutional layers and adjusting pooling dimensions, we aim to create a more compact model, reducing computational complexity. Using the float16 data type can further reduce the memory footprint and potentially speed up calculations while retaining reasonable precision for the task of classifying MNIST images.

![CNN_arch](https://github.com/Baungarten-CINVESTAV/AI_by_AI/assets/101527680/e28288d8-dc1f-486e-94be-5f7f35e94a8a)


## Hardware Specifications:
* Digital logic gates
* Register for Weights & Biases storage
* Hardware multipliers and accumulators for convolution operations
* Efficient pooling operation units
* On-chip non-linear activation function units (ReLu)

   Number of wires: 209315, Number of wire bits: 209933, Number of public wires: 209315, Number of public wire bits: 209933,  Number of cells: 209528.
  
## Testing and validation:
The accuracy of the IC will be compared with software-based CNN implementations on the MNIST dataset.
At each step of the design flow, the correctness of the system has been corroborated, in order to ensure its correct implementation at the IC level.

# Forked from the Caravel User Project


| :exclamation: Important Note            |
|-----------------------------------------|

## Caravel information follows

Refer to [README](docs/source/index.rst#section-quickstart) for a quickstart of how to use caravel_user_project

Refer to [README](docs/source/index.rst) for this sample project documentation. 

Refer to the following [readthedocs](https://caravel-sim-infrastructure.readthedocs.io/en/latest/index.html) for how to add cocotb tests to your project. 
