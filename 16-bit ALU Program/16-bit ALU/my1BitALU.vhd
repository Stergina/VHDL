-- Implementing an 1-bit ALU responsible to perform AND, OR, ADD, SUB, NOR, NAND and XOR functions

-- Loads necessary packages
library ieee;
use ieee.std_logic_1164.all;
use work.functions_16BitALU.all;

-- Defines entity my1BitALU with inputs a, b, Ainvert, Binvert, CarryIn, Operation and outputs Result, CarryOut
entity my1BitALU is
	port (a, b, Ainvert, Binvert, CarryIn: in std_logic;
			Operation: in std_logic_vector(1 downto 0);
			Result, CarryOut: out std_logic);
end my1BitALU;

-- Defines function my1BitALU
architecture structural of my1BitALU is

-- Declares inputs to be used in the design
signal outAinvert, outBinvert, outAND, outOR, outXOR, outSum, outCarry: std_logic;

-- Architecture body
begin
	-- Inverts input a
	Output1: invA port map (a,Ainvert,outAinvert);
	
	-- Inverts input b
	Output2: invB port map (b,Binvert,outBinvert);
	
	-- Performs AND function
	Output3: myAND port map (outAinvert,outBinvert,outAND);
	
	-- Performs OR function
	Output4: myOR port map (outAinvert,outBinvert,outOR);
	
	-- Performs XOR function
	Output5: myXOR port map (outAinvert,outBinvert,outXOR);
	
	-- Performs ADD function
	Output6: myADD port map (outAinvert,outBinvert,CarryIn,outSum,outCarry);
	
	-- Process that allocates values to variables Result and CarryOut based on the given inputs
	process(Operation, Ainvert, Binvert, CarryIn, outAinvert, outBinvert, outAND, outOR, outXOR, outSum, outCarry)
		begin
		case Operation is
	
			-- Operation "00"
			when "00" =>
				-- Result is assigned with the output of function NOR and CarryOut = 0
				if Ainvert = '1' and Binvert = '1' then 
					Result <= outAinvert and outBinvert;
					CarryOut <= '0';
				-- Result is assigned with the output of function AND and CarryOut = 0
				else 
					Result <= outAND;
					CarryOut <= '0';
				end if;

			-- Operation "01"	
			when "01" => 	
				-- Result is assigned with the output of function NAND and CarryOut = 0
				if Ainvert = '1' and Binvert = '1' then 
					Result <= outAinvert or outBinvert;
					CarryOut <= '0';
				-- Result is assigned with the output of function OR and CarryOut = 0
				else 
					Result <= outOR;
					CarryOut <= '0';
				end if;		

			-- Operation "10"					
			when "10" =>
			-- Result is assigned with the output of function ADD
				Result <= outSum;
				CarryOut <= outCarry;
			
			-- Operation "11"					
			-- Result is assigned with the output of function XOR and CarryOut = 0
			when "11" => 
				Result <= outXOR;
				CarryOut <= '0';
			
			-- Rest cases				
			when others =>
				Result <= '0';
				CarryOut <= '0';
		end case;
	end process;
end structural;