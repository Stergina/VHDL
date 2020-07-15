-- Basic functions of package functions_16BitALU

-- Loads necessary packages
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Package components declaration
PACKAGE functions_16BitALU IS

	-- logical AND gate with 2 inputs
	COMPONENT myAND
		PORT (
			a, b : IN std_logic;
			outAND : OUT std_logic
		);
	END COMPONENT;
 
	-- logical OR gate with 2 inputs
	COMPONENT myOR
		PORT (
			a, b : IN std_logic;
			outOR : OUT std_logic
		);
	END COMPONENT;
 
	-- logical XOR gate with 2 inputs
	COMPONENT myXOR
		PORT (
			a, b : IN std_logic;
			outXOR : OUT std_logic
		);
	END COMPONENT;
 
	-- Full adder
	COMPONENT myADD
		PORT (
			a, b, CarryIn : IN std_logic;
			sum, cout : OUT std_logic
		);
	END COMPONENT; 

	-- Inverts input a
	COMPONENT invA
		PORT (
			a, Ainvert : IN std_logic;
			outAinvert : OUT std_logic
		);
	END COMPONENT;
 
	-- Inverts input b
	COMPONENT invB
		PORT (
			b, Binvert : IN std_logic;
			outBinvert : OUT std_logic
		);
	END COMPONENT;
 
	-- Control Circuit
	COMPONENT myControlCircuit
		PORT (
			opcode : IN std_logic_vector (2 DOWNTO 0);
			Ainvert, Binvert, CarryIn : OUT std_logic;
			Operation : OUT std_logic_vector(1 DOWNTO 0)
		);
	END COMPONENT; 
 
END PACKAGE functions_16BitALU;
-- Package functions_16BitALU body

-- Implementing a logical AND gate with 2 inputs
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY myAND IS
	PORT (
		a, b : IN std_logic;
		outAND : OUT std_logic
	);
END myAND;

ARCHITECTURE andGate OF myAND IS
BEGIN
	outAND <= a AND b;
END andGate;
 
-- Implementing a logical OR gate with 2 inputs
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY myOR IS
	PORT (
	a, b : IN std_logic;
	outOR : OUT std_logic
	);
END myOR;

ARCHITECTURE orGate OF myOR IS
BEGIN
	outOR <= a OR b;
END orGate;
 
-- Implementing a logical XOR gate with 2 inputs
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY myXOR IS
	PORT (
	a, b : IN std_logic;
	outXOR : OUT std_logic
	);
END myXOR;

ARCHITECTURE xorGate OF myXOR IS
BEGIN
	outXOR <= a XOR b;
END xorGate;

-- Implementing a full adder
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY myADD IS
	PORT (
	a, b, CarryIn : IN std_logic;
	sum, cout : OUT std_logic
	);
END myADD;

ARCHITECTURE addGate OF myADD IS
BEGIN
	sum <= ((a AND (NOT b) AND (NOT CarryIn)) OR ((NOT a) AND b AND (NOT CarryIn)) OR ((NOT a) AND (NOT b) AND CarryIn) OR (a AND b AND CarryIn));
	cout <= (b AND CarryIn) OR (a AND CarryIn) OR (a AND b);
END addGate;
 
-- Inverts input a
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY invA IS
	PORT (
	a, Ainvert : IN std_logic;
	outAinvert : OUT std_logic
	);
END invA;

ARCHITECTURE AinvertMux OF invA IS
BEGIN
	WITH Ainvert SELECT
	outAinvert <= a WHEN '0', 
	              NOT a WHEN '1', 
	              NULL WHEN OTHERS; 
END AinvertMux;

-- Inverts input b
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY invB IS
	PORT (
	b, Binvert : IN std_logic;
	outBinvert : OUT std_logic
	);
END invB;

ARCHITECTURE BinvertMux OF invB IS
BEGIN
	WITH Binvert SELECT
	outBinvert <= b WHEN '0', 
	              NOT b WHEN '1', 
	              NULL WHEN OTHERS; 
END BinvertMux;

-- Implementing the control circuit
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY myControlCircuit IS
	PORT (
	opcode : IN std_logic_vector (2 DOWNTO 0);
	Ainvert, Binvert, CarryIn : OUT std_logic;
	Operation : OUT std_logic_vector(1 DOWNTO 0)
	);
END myControlCircuit;

ARCHITECTURE ctrlCircuit OF myControlCircuit IS 
BEGIN
	PROCESS (opcode)
	BEGIN
		CASE opcode IS
			--Function AND--
			WHEN "000" => 
				Operation <= "00";
				Ainvert <= '0';
				Binvert <= '0';
				CarryIn <= '0';

				--Function OR--
			WHEN "001" => 
				Operation <= "01";
				Ainvert <= '0';
				Binvert <= '0';
				CarryIn <= '0';

				--Function ADD--
			WHEN "010" => 
				Operation <= "10";
				Ainvert <= '0';
				Binvert <= '0';
				CarryIn <= '0';

				--Function SUB-- 
			WHEN "011" => 
				Operation <= "10";
				Ainvert <= '0';
				Binvert <= '1';
				CarryIn <= '1';

				--Function NOR--
			WHEN "100" => 
				Operation <= "00";
				Ainvert <= '1';
				Binvert <= '1';
				CarryIn <= '0';

				--Function NAND--
			WHEN "101" => 
				Operation <= "01";
				Ainvert <= '1';
				Binvert <= '1';
				CarryIn <= '0';

				--Function XOR--
			WHEN "110" => 
				Operation <= "11";
				Ainvert <= '0';
				Binvert <= '0';
				CarryIn <= '0';

				--Other cases--
			WHEN OTHERS => 
				Operation <= "00";
				Ainvert <= '0';
				Binvert <= '0';
				CarryIn <= '0';
		END CASE;
	END PROCESS;
END ctrlCircuit;
--end package body functions_16BitALU;
