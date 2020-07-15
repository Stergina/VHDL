-- Basic functions of package functions_16BitALU

-- Loads necessary packages
library ieee;
use ieee.std_logic_1164.all;

-- Package components declaration
package functions_16BitALU is

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
	
	-- Control Circuit
	component myControlCircuit
		port(opcode: in std_logic_vector (2 downto 0);
			 Ainvert, Binvert, CarryIn: out std_logic;
		     Operation: out std_logic_vector(1 downto 0));
	end component;	
	
end package functions_16BitALU;
 
 
-- Package functions_16BitALU body

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

-- Implementing the control circuit
library ieee;
use ieee.std_logic_1164.all;

entity myControlCircuit is 
	port(opcode: in std_logic_vector (2 downto 0);
		 Ainvert, Binvert, CarryIn: out std_logic;
		 Operation: out std_logic_vector(1 downto 0));
end myControlCircuit;

architecture ctrlCircuit of myControlCircuit is   
begin
	process(opcode)
	begin
		case opcode is 
		 --Function AND--
		when "000"=>
			Operation <= "00";
			Ainvert   <= '0';
			Binvert   <= '0';
			CarryIn   <= '0';

		 --Function OR--
		when "001" =>
			Operation <= "01";
			Ainvert   <= '0';
			Binvert   <= '0';
			CarryIn	  <= '0';

		 --Function ADD--
		 when "010" =>
			Operation <= "10";
			Ainvert   <= '0';
			Binvert   <= '0';
			CarryIn	  <= '0';

		 --Function SUB--         
		when "011" =>
			Operation <= "10";
			Ainvert   <= '0';
			Binvert   <= '1';
			CarryIn   <= '1';

		 --Function NOR--
		when "100" =>
			Operation <= "00";
			Ainvert   <= '1';
			Binvert   <= '1';
			CarryIn   <= '0';

		 --Function NAND--
		when "101"=>
			Operation <= "01";
			Ainvert   <= '1';
			Binvert	  <= '1';
			CarryIn	  <= '0';

		 --Function XOR--
		when "110"=>
			Operation <= "11";
			Ainvert   <= '0';
			Binvert   <= '0';
			CarryIn	  <= '0';

		 --Other cases--
		when others =>
			Operation <= "00";
			Ainvert   <= '0';
			Binvert	  <= '0';
			CarryIn   <= '0';
		end case;
	end process;
end ctrlCircuit;
--end package body functions_16BitALU;