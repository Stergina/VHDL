-- Basic functions of package functions_1BitALU

-- Loads necessary packages
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Package components declaration
PACKAGE functions_1BitALU IS

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
 
END PACKAGE functions_1BitALU;
-- Package functions_1BitALU body

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
--end package body functions_1BitALU;
