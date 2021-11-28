# 16-bit ALU

**Objective**:  
The aim of this project is to design a hierarchical circuit that will implement a 16-bit Numerical and Logic Unit - ALU in VHDL.

**Structure of the code**:  
In the first part, we design and implement a 1-bit ALU, while in the second part we implement a 16-bit ALU using the 1-bit ALU of the first part as a component. More specifically:  

* **1-bit ALU:**  
We build a 1-bit ALU hierarchically using subcircuits capable of performing the operations: AND, OR, ADD, SUB, XOR, NOR and NAND. The program inputs are the following 1-bit numbers: a, b, Ainvert, Binvert, carryIn and operation whilst the program outputs are the result of the operation and the carryOut.


* **16-bit ALU:**  
The 1-bit ALU implemented in the first step, is now used in order to construct the 16-bit ALU. In addition, we implement a new entity which determines which operation will be executed by the ALU based on the input.
