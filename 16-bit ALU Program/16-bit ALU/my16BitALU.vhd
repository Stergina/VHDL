-- Implementing a 16-bit ALU responsible to perform AND, OR, ADD, SUB, NOR, NAND and XOR functions

-- Loads necessary packages
library ieee;
use ieee.std_logic_1164.all;
use work.functions_16BitALU.all;

-- Defines entity my16BitALU with inputs a, b, opcode and outputs Result, Overflow
entity my16BitALU is
	port (a, b: in std_logic_vector(15 downto 0);
			opcode: in std_logic_vector(2 downto 0);
			Result: out std_logic_vector(15 downto 0);
			Overflow: out std_logic);
end my16BitALU;

-- Defines function my16BitALU
architecture structural of my16BitALU is

-- Declares 1-bit ALU as a component
component my1BitALU
	port (a, b, Ainvert, Binvert, CarryIn: in std_logic;
			Operation: in std_logic_vector(1 downto 0);
			Result, CarryOut: out std_logic);
end component;	

-- Declares inputs to be used in the design
signal Ainvert, Binvert, CarryIn, CarryOut: std_logic;
signal Operation: std_logic_vector(1 downto 0);
signal result1BitALU, cin, cout: std_logic_vector(15 downto 0);

-- Architecture body
begin
	-- Implements the control circuit that declares the function that will take place based on the operation code (opcode)
	Output1: myControlCircuit port map (opcode,Ainvert,Binvert,CarryIn,Operation);

	-- Isolates the first realization of my1BitALU from the loop. We perform my1BitALU function for the first bit of each input a and b
	Output2: my1BitALU port map(a(0),b(0),Ainvert,Binvert,CarryIn,Operation,result1BitALU(0),cout(0));	
			Result(0) <= result1BitALU(0);
			cin(0) <= cout(0);
			
	-- Performs my1BitALU function for the remaining 15 bits of each input (a and b)
		for_loop: 
			for i in 1 to 15 generate	 
				Output3: my1BitALU port map (a(i),b(i),Ainvert,Binvert,cin(i-1),Operation,result1BitALU(i),cout(i)); 
				
				-- Result of the function between the i-th bit of input a and input b
				Result(i) <= result1BitALU(i);
				
				-- CarryIn of the i-th repetition equals with the CarryOut of the previous repetition
				cin(i) <= cout(i);
			end generate; 
							
	-- Calculates overflow as the result of XOR function between the CarryOuts of the last two result digits 
	Overflow <= (cout(14) xor cout(15));
end structural;