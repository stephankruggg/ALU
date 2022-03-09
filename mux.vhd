LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


ENTITY mux IS
    generic(X : natural := 8);
  PORT ( a, b : IN std_logic_vector(x - 1 DOWNTO 0);
         sel: IN STD_LOGIC;
         y : OUT std_logic_vector(x - 1 DOWNTO 0));
  END mux;

ARCHITECTURE comportamento OF mux IS
BEGIN
     WITH sel SELECT
         y <= a WHEN '0',
              b WHEN OTHERS;
END comportamento;