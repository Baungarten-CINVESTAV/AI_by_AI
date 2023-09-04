# AI by AI

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![UPRJ_CI](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml)

Author: Emilio Baungarten

Description: CNN-based MNIST Classifier Integrated Circuit (IC) using ChatGPT-4

## Objective:

<p align="justify">
Develop a dedicated hardware Integrated Circuit (IC) for a Convolutional Neural Network (CNN) that classifies the MNIST dataset. The main aim is for ChatGPT-4 to generate the Register-Transfer Level (RTL) code necessary to create the IC, incorporating insights and optimizations along the way.
</p>

## Background:

<p align="justify">
The MNIST dataset is a well-known collection of handwritten digits widely used in the machine-learning community for benchmarking and testing. A CNN is particularly suited for image classification tasks like those posed by the MNIST dataset. By moving from software to a hardware implementation, we can achieve faster computation times and lower power consumption.
</p>
<p align="justify">
Furthermore, the integration of AI in IC development has ushered in a new era of hardware design, where iterative processes and optimization techniques previously reserved for software can now be applied directly to hardware architectures. Using AI to facilitate and streamline the design process can lead to more efficient and effective IC designs that can adapt and evolve. Choosing the MNIST dataset for this venture serves as an ideal proof of concept, given its historical significance in machine learning. The fusion of AI-driven RTL code development, especially with tools like ChatGPT-4, and the time-tested MNIST dataset, symbolizes the confluence of the traditional and the cutting-edge in the world of computational design.
</p>

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

<p align="justify">
By changing the architecture to include fewer filters in the convolutional layers and adjusting pooling dimensions, we aim to create a more compact model, reducing computational complexity. Using the float16 data type can further reduce the memory footprint and potentially speed up calculations while retaining reasonable precision for the task of classifying MNIST images.
</p>   
<p align="center">
<img src="https://github.com/Baungarten-CINVESTAV/AI_by_AI/assets/101527680/e28288d8-dc1f-486e-94be-5f7f35e94a8a">
  </p>
  
## Block Diagram

<p align="center">
<img src="https://github.com/Baungarten-CINVESTAV/AI_by_AI/assets/101527680/181bd530-28a7-42e6-a044-27f6fd596962" width=80% height=80%>
</p>

### Pinout

<p align="center">

| Caravel       | AI by AI      | Type|
|  :---: |  :---: |  :---: |
| wb_clk_i   | o_mux_clk   | Input   |
| io_in[36]    | o_mux_clk   | Input   |
| io_in[37]    | s_mux_clk   | Input   |
| o_mux_clk  | ap_clk   | Input   |
| la_data_in[1]  | in_ap_rst  | Input  |
| io_in[35]  | in_ap_rst  | Input  |
| io_in[35]  | ap_start   | Input |
| la_data_out[3]  | ap_done | output |
| la_data_out[4]   | ap_ready   | output   |
| io_out[16:5]   | image_r_Addr_A   | output   |
| io_out[17]    | image_r_EN_A   | output   |
| N/A   | image_r_WEN_A   | output   |
| N/A   | image_r_Din_A   | output   |
| io_in[33:18]   | image_r_Dout_A   |Input   |
| io_out[34]   | image_r_Clk_A   | output   |
| N/A    | image_r_Rst_A   | output   |
| la_data_out[31:28]    | ap_return   | output   |
</p>


## Testing and validation:

<p align="justify">
The accuracy of the IC will be compared with software-based CNN implementations on the MNIST dataset.
At each step of the design flow, the correctness of the system has been corroborated, in order to ensure its correct implementation at the IC level.

</p>  

# Workflow:

<p align="justify">
The intricate design process for realizing the CNN-based circuit on hardware was orchestrated by a generative AI, ChatGPT-4. This AI-driven methodology facilitated a seamless transition from a high-level software representation to a hardware-efficient implementation. The workflow encompassed five pivotal stages:
</p>  

### CNN Creation with TensorFlow:

<p align="justify">
ChatGPT-4 initiated the design by crafting the CNN using TensorFlow. This deep learning framework was leveraged by the AI to design, train, and evaluate the model on the MNIST dataset. With its trained model parameters and architectural details in hand, ChatGPT-4 proceeded to the subsequent stages.
</p>  

### Inference Function Implementation Without Libraries:

<p align="justify">
The AI then re-architected the core essence of the neural network, the inference function, without depending on any high-level deep learning libraries. This purified and streamlined approach removed any TensorFlow overheads and provided a robust standalone function, setting the foundation for the next steps.
</p>  


### Translation to C++:

<p align="justify">
Transitioning from the Python environment of TensorFlow to a more hardware-oriented language, ChatGPT-4 adeptly translated the inference function into C++. This transformation was pivotal as C++ caters better to low-level optimizations and interfaces more harmoniously with hardware synthesis tools.
</p>  

### Translation from C++ to High-Level Synthesis (HLS):

<p align="justify">
With expertise in both software and hardware domains, ChatGPT-4 adeptly translated the C++ rendition into an HLS representation. HLS tools offer the ability to generate hardware description files directly from high-level code. After the translation, the outcome of the HLS process was a Verilog file, designed to encapsulate the operations and flow of the CNN. Utilizing HLS allowed the AI to finetune and optimize the design in alignment with specific hardware constraints, resulting in an efficient and streamlined Verilog blueprint.
</p>  

### Synthesis of the Verilog Code with Caravel:

<p align="justify">
Caravel, a well-regarded framework for ASIC design, was employed to further synthesize the Verilog output from HLS. This hardware description language, once synthesized with Caravel, captures the circuit's precise behavior and structure, making it primed for deployment onto FPGA platforms or more intensive design phases leading to ASIC production.
</p>  
   
<p align="center">
<img src="https://github.com/Baungarten-CINVESTAV/AI_by_AI/assets/101527680/7dbcafe6-070c-4d56-8515-60a5cdccf61c" width=80% height=80%>
</p>

<p align="justify">
By integrating ChatGPT-4 into this workflow, the strengths of generative AI were seamlessly married with the rigor and precision of hardware design methodologies. This synergy resulted in a state-of-the-art, high-performance, and pinpoint accurate hardware representation of the CNN.
</p>  

# Large Language Models conversation flowchart

<p align="justify">
Large Language Models (LLMs) are a type of machine learning model designed to understand and generate human-like text based on vast amounts of data. They fall under the broader category of deep learning, and more specifically, they are a kind of recurrent neural network known as transformers. LLMs are trained on diverse datasets containing parts of the internet, which includes websites, books, articles, and other forms of written content. This helps them understand context, nuances, and the intricacies of human language.
</p>  

<p align="justify">
Using conversational models, there are countless ways to engage in a dialogue. However, to understand the potential for creating a uniform and automated process with these large language models, we've established a fixed, predefined conversation structure for a set of benchmarks.

   </p>  
<p align="center">
<img src="https://github.com/Baungarten-CINVESTAV/AI_by_AI/assets/101527680/80ef5644-7ef0-4402-abce-fa2fa61da126" width=60% height=60% />
</p>

<p align="center">
LLM conversation flowchart
</p>

# Forked from the Caravel User Project


| :exclamation: Important Note            |
|-----------------------------------------|

## Caravel information follows

Refer to [README](docs/source/index.rst#section-quickstart) for a quickstart of how to use caravel_user_project

Refer to [README](docs/source/index.rst) for this sample project documentation. 

Refer to the following [readthedocs](https://caravel-sim-infrastructure.readthedocs.io/en/latest/index.html) for how to add cocotb tests to your project. 
