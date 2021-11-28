-- Implementing a 16-bit ALU responsible to perform AND, OR, ADD, SUB, NOR, NAND and XOR functions

-- Loads necessary packages
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.functions_16BitALU.ALL;

-- Defines entity my16BitALU with inputs a, b, opcode and outputs Result, Overflow
ENTITY my16BitALU IS
	PORT (
		a, b : IN std_logic_vector(15 DOWNTO 0);
		opcode : IN std_logic_vector(2 DOWNTO 0);
		Result : OUT std_logic_vector(15 DOWNTO 0);
		Overflow : OUT std_logic
	);
END my16BitALU;

-- Defines function my16BitALU
ARCHITECTURE structural OF my16BitALU IS

	-- Declares 1-bit ALU as a component
	COMPONENT my1BitALU
		PORT (
			a, b, Ainvert, Binvert, CarryIn : IN std_logic;
			Operation : IN std_logic_vector(1 DOWNTO 0);
			Result, CarryOut : OUT std_logic
		);
	END COMPONENT; 

	-- Declares inputs to be used in the design
	SIGNAL Ainvert, Binvert, CarryIn, CarryOut : std_logic;
	SIGNAL Operation : std_logic_vector(1 DOWNTO 0);
	SIGNAL result1BitALU, cin, cout : std_logic_vector(15 DOWNTO 0);

	-- Architecture body
BEGIN
	-- Implements the control circuit that declares the function that will take place based on the operation code (opcode)
	Output1 : myControlCircuit
	PORT MAP(opcode, Ainvert, Binvert, CarryIn, Operation);

	-- Isolates the first realization of my1BitALU from the loop. We perform my1BitALU function for the first bit of each input a and b
	Output2 : my1BitALU
	PORT MAP(a(0), b(0), Ainvert, Binvert, CarryIn, Operation, result1BitALU(0), cout(0)); 
	Result(0) <= result1BitALU(0);
	cin(0) <= cout(0);
 
	-- Performs my1BitALU function for the remaining 15 bits of each input (a and b)
	for_loop : 
	FOR i IN 1 TO 15 GENERATE 
		Output3 : my1BitALU
		PORT MAP(a(i), b(i), Ainvert, Binvert, cin(i - 1), Operation, result1BitALU(i), cout(i));
 
		-- Result of the function between the i-th bit of input a and input b
		Result(i) <= result1BitALU(i);
 
		-- CarryIn of the i-th repetition equals with the CarryOut of the previous repetition
		cin(i) <= cout(i);
END GENERATE;
 
-- Calculates overflow as the result of XOR function between the CarryOuts of the last two result digits
Overflow <= (cout(14) XOR cout(15));
END structural;
