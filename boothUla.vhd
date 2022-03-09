library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity boothUla is
	generic(X : natural := 8);
	port(M, Q: in std_logic_vector(X-1 downto 0);
	clk: in std_logic;
	ulaop: in std_logic_vector(1 downto 0);
	S: out std_logic_vector (x + x - 1 downto 0)
	);

end boothUla;

architecture arc of boothUla is

component trabalhoGrupo
	port (
			M, Q: in std_logic_vector(x - 1 downto 0);
			clk, reset: in std_logic;
			S: out std_logic_vector(x + x - 1 downto 0);
			acabou: out std_logic
		);
end component;

signal tempS, soma, subtracao, mult, mult1: std_logic_vector (x + x - 1 downto 0);
signal superQ, superM: std_logic_vector (x + x - 1 downto 0); 
signal zero: std_logic_vector (x + x - 1 downto 0) := (OTHERS => '0');
signal extendPositive: std_logic_vector (x - 1 downto 0) := (OTHERS => '0');
signal extendNegative: std_logic_vector (x - 1 downto 0) := (OTHERS => '1');
signal extensionM, extensionQ: std_logic_vector (x - 1 downto 0);
signal acabou, qx: std_logic;

begin

superQ <= extensionQ & Q;
superM <= extensionM & M;
booth: trabalhoGrupo port map (M, Q, clk, '0', mult, acabou);

soma <= superQ + superM;
subtracao <= superQ - superM;
with Q(x - 1) select
	extensionQ <= extendPositive when '0',
				extendNegative when others;

with M(x - 1) select
extensionM <= extendPositive when '0',
			extendNegative when others;

with acabou select
	mult1 <= mult when '1',
			 zero when others;

with ulaop select
	tempS <= soma when "01",
				subtracao when "10",
				mult1 when others;
		
S <= tempS;

end arc;