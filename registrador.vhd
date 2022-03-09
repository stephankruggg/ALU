LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


ENTITY registrador IS
generic(X : natural := 8);
PORT (clk, reset, carga : IN STD_LOGIC;
	  d : IN std_logic_vector(x - 1 DOWNTO 0);
	  q : OUT std_logic_vector(x - 1 DOWNTO 0));
END registrador;

ARCHITECTURE estrutura OF registrador is
signal zero: std_logic_vector(x - 1 downto 0) := (OTHERS => '0');
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