library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity uladiv is
	generic (X : natural := 8);
	port(Asub, Qshift, Ashift: in std_logic_vector(X-1 downto 0);
	ulaop: in std_logic;
	AF, QF: out std_logic_vector(X - 1 downto 0)
	);

end uladiv;

architecture arc of uladiv is
signal temp, zero, um: std_logic_vector (X + X - 1 downto 0);
begin

zero <= Qshift(X - 1 downto 1) & '1' & Asub;
um <= Qshift(X - 1 downto 1) & '0' & Ashift;

with ulaop select
	temp <= um when '1',
			  zero when '0',
			  (others => 'U') when others;

				
AF <= temp(X - 1 downto 0);
QF <= temp(X + X - 1 downto X);			

end arc;