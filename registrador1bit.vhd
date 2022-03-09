LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY registrador1bit IS
PORT (clk, reset, carga : IN STD_LOGIC;
	  d : IN STD_LOGIC;
	  q : OUT STD_LOGIC);
END registrador1bit;

ARCHITECTURE estrutura OF registrador1bit is
signal zero: std_logic := '0';
BEGIN
	PROCESS(clk, reset)
	BEGIN
		IF(reset = '1') THEN
			q <= zero;
		ELSIF(clk'EVENT AND clk = '1' AND carga = '1') THEN
			q <= d;
		END IF;
	END PROCESS;
END estrutura;