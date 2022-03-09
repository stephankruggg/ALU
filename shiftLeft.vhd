library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity shiftLeft is
	generic(x : natural := 8);
	port(
        AP, QP: in std_logic_vector (x - 1 downto 0);
        Ashift,  Qshift: out std_logic_vector (x - 1 downto 0)
    );

end shiftLeft;

architecture arc of shiftLeft is
begin

    Ashift <= AP(X - 2 downto 0) & QP(X - 1);
    Qshift <= QP(X - 2 downto 0) & '0';

end arc;