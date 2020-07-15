-- Basic functions of package functions_1BitALU

-- Loads necessary packages
library ieee;
use ieee.std_logic_1164.all;

-- Package components declaration
package functions_1BitALU is

	-- logical AND gate with 2 inputs
	component myAND
		port (a, b: in std_logic; outAND: out std_logic);
	end component;
	 
	-- logical OR gate with 2 inputs
	component myOR
		port (a, b: in std_logic; outOR: out std_logic);
	end component;
		 
	-- logical XOR gate with 2 inputs
	component myXOR
		port (a, b: in std_logic; outXOR: out std_logic);
	end component;
	
	-- Full adder
	component myADD
		port (a, b, CarryIn: in std_logic; sum, cout: out std_logic);
	end component;	
		
	-- Inverts input a
	component invA
		port (a, Ainvert: in std_logic; outAinvert: out std_logic);
	end component;
					
	-- Inverts input b
	component invB
		port (b, Binvert: in std_logic; outBinvert: out std_logic);
	end component;	
	
end package functions_1BitALU;
 
 
-- Package functions_1BitALU body

-- Implementing a logical AND gate with 2 inputs
library ieee;
use ieee.std_logic_1164.all;

entity myAND is
	port (a, b: in std_logic; outAND: out std_logic);
end myAND;

architecture andGate of myAND is
begin
	outAND <= a and b;
end andGate;
	
-- Implementing a logical OR gate with 2 inputs
library ieee;
use ieee.std_logic_1164.all;

entity myOR is
	port (a, b: in std_logic; outOR: out std_logic);
end myOR;

architecture orGate of myOR is
begin
	outOR <= a or b;
end orGate;
		
-- Implementing a logical XOR gate with 2 inputs
library ieee;
use ieee.std_logic_1164.all;

entity myXOR is
	port (a, b: in std_logic; outXOR: out std_logic);
end myXOR;

architecture xorGate of myXOR is
begin
	outXOR <= a xor b;
end xorGate;
 
-- Implementing a full adder
library ieee;
use ieee.std_logic_1164.all;

entity myADD is
	port (a, b, CarryIn: in std_logic; sum, cout: out std_logic);
end myADD;

architecture addGate of myADD is
begin
	sum <= ((a and (not b) and (not CarryIn)) or ((not a) and b and (not CarryIn)) or ((not a) and (not b) and CarryIn) or (a and b and CarryIn));
	cout <= (b and CarryIn) or (a and CarryIn) or (a and b);
end addGate;
 
-- Inverts input a
library ieee;
use ieee.std_logic_1164.all;

entity invA is
	port (a, Ainvert: in std_logic; outAinvert: out std_logic);
end invA;

architecture AinvertMux of invA is
begin
	with Ainvert select
		outAinvert <= a when '0',
					not a when '1',
					null when others;	
end AinvertMux;

-- Inverts input b
library ieee;
use ieee.std_logic_1164.all;

entity invB is
	port (b, Binvert: in std_logic; outBinvert: out std_logic);
end invB;

architecture BinvertMux of invB is
begin
	with Binvert select
		outBinvert <= b when '0',
					not b when '1',
					null when others;	
end BinvertMux;
--end package body functions_1BitALU;