-- Implementing an 1-bit ALU responsible to perform AND, OR, ADD, SUB, NOR, NAND and XOR functions

-- Loads necessary packages
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.functions_1BitALU.ALL;

-- Defines entity my1BitALU with inputs a, b, Ainvert, Binvert, CarryIn, Operation and outputs Result, CarryOut
ENTITY my1BitALU IS
	PORT (
		a, b, Ainvert, Binvert, CarryIn : IN std_logic;
		Operation : IN std_logic_vector(1 DOWNTO 0);
		Result, CarryOut : OUT std_logic
	);
END my1BitALU;

-- Defines function my1BitALU
ARCHITECTURE structural OF my1BitALU IS

	-- Declares inputs to be used in the design
	SIGNAL outAinvert, outBinvert, outAND, outOR, outXOR, outSum, outCarry : std_logic;

	-- Architecture body
BEGIN
	-- Inverts input a
	Output1 : invA
	PORT MAP(a, Ainvert, outAinvert);
 
	-- Inverts input b
	Output2 : invB
	PORT MAP(b, Binvert, outBinvert);
 
	-- Performs AND function
	Output3 : myAND
	PORT MAP(outAinvert, outBinvert, outAND);
 
-- Performs OR function
Output4 : myOR
PORT MAP(outAinvert, outBinvert, outOR);
 
-- Performs XOR function
Output5 : myXOR
PORT MAP(outAinvert, outBinvert, outXOR);
 
-- Performs ADD function
Output6 : myADD
PORT MAP(outAinvert, outBinvert, CarryIn, outSum, outCarry);

-- Process that allocates values to variables Result and CarryOut based on the given inputs
PROCESS (Operation, Ainvert, Binvert, CarryIn, outAinvert, outBinvert, outAND, outOR, outXOR, outSum, outCarry)
BEGIN
	CASE Operation IS
 
		-- Operation "00"
		WHEN "00" => 
			-- Result is assigned with the output of function NOR and CarryOut = 0
			IF Ainvert = '1' AND Binvert = '1' THEN
				Result <= outAinvert AND outBinvert;
				CarryOut <= '0';
				-- Result is assigned with the output of function AND and CarryOut = 0
			ELSE
				Result <= outAND;
				CarryOut <= '0';
			END IF;

			-- Operation "01" 
		WHEN "01" => 
			-- Result is assigned with the output of function NAND and CarryOut = 0
			IF Ainvert = '1' AND Binvert = '1' THEN
				Result <= outAinvert OR outBinvert;
				CarryOut <= '0';
				-- Result is assigned with the output of function OR and CarryOut = 0
			ELSE
				Result <= outOR;
				CarryOut <= '0';
			END IF; 

			-- Operation "10" 
		WHEN "10" => 
			-- Result is assigned with the output of function ADD
			Result <= outSum;
			CarryOut <= outCarry;

			-- Operation "11" 
			-- Result is assigned with the output of function XOR and CarryOut = 0
		WHEN "11" => 
			Result <= outXOR;
			CarryOut <= '0';
 
			-- Rest cases 
		WHEN OTHERS => 
			Result <= '0';
			CarryOut <= '0';
	END CASE;
END PROCESS;
END structural;
