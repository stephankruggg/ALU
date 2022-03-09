library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity shiftRight is
	generic(x : natural := 8);
	port(
        A, Q: in std_logic_vector (x - 1 downto 0);
        AF,  QF: out std_logic_vector (x - 1 downto 0);
        Q0F: out std_logic
    );

end shiftRight;

architecture arc of shiftRight is
signal juntos, juntosF: std_logic_vector(X + X downto 0);
begin

    AF <= A(X - 1) & A(X-1 downto 1);
    QF <= A(0) & Q(X - 1 downto 1);
    Q0F <= Q(0); 

end arc;