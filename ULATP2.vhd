library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ULATP2 is
	generic(X : natural := 8);
	port(M, Q: in std_logic_vector(X-1 downto 0);
	clk: in std_logic;
	ulaop: in std_logic_vector(3 downto 0);
	Saida1, Saida0: out std_logic_vector (x - 1 downto 0);
	neg, fzero, ov: out std_logic;
	acabou_ula: out std_logic
	);

end ULATP2;

architecture arc of ULATP2 is

component trabalhoGrupo
	port (
			M, Q: in std_logic_vector(x - 1 downto 0);
			clk, reset: in std_logic;
			S1, S0: out std_logic_vector(x - 1 downto 0);
			acabou: out std_logic
		);
end component;

component Division 
	port (
			M, Q: in std_logic_vector(x - 1 downto 0);
			clk, reset: in std_logic;
			quotient, remainder: out std_logic_vector(x - 1 downto 0);
			acabou: out std_logic
		);
end component;

signal tempS1, tempS0, soma, subtracao, incremento, decremento, nao: std_logic_vector (x - 1 downto 0);
signal e, ou, xou, mults1, mults0, multsaida1, multsaida0, divs1, divs0, divsaida1, divsaida0: std_logic_vector (x - 1 downto 0);
signal superQ, superM: std_logic_vector (x - 1 downto 0); 
signal zero: std_logic_vector (x - 1 downto 0) := (OTHERS => '0');
signal acabou_mult, acabou_div: std_logic;
signal checkZero, checkNeg, checkOv: std_logic;

begin

booth: trabalhoGrupo port map (M, Q, clk, '0', multsaida1, multsaida0, acabou_mult);
restoring: Division port map (M, Q, clk, '0', divsaida1, divsaida0, acabou_div);

soma <= Q + M;
subtracao <= Q - M;
incremento <= Q + 1;
decremento <= Q - 1;
nao <= not(Q);
e <= Q and M;
ou <= Q or M;
xou <= Q xor M;

with acabou_mult select
	mults1 <= multsaida1 when '1',
				 zero when others;

with acabou_mult select
	mults0 <= multsaida0 when '1',
				 zero when others;
			 
with acabou_div select
	divs1 <= divsaida1 when '1',
			  zero when others;

with acabou_div select	  
	divs0 <= divsaida0 when '1',
				zero when others;

with ulaop select
	tempS0 <= soma when "0001",
				 subtracao when "0010",
				 incremento when "0011",
				 decremento when "0100",
				 nao when "0101",
				 e when "0110",
				 ou when "0111",
				 xou when "1000",
				 mults0 when "1001",
				 divs0 when "1010",
				 (others => 'U') when others;

with ulaop select
	tempS1 <= zero when "0001",
				 zero when "0010",
				 zero when "0011",
				 zero when "0100",
				 zero when "0101",
				 zero when "0110",
				 zero when "0111",
				 zero when "1000",
				 mults1 when "1001",
				 divs1 when "1010",
				 (others => 'U') when others;

with ulaop select
	acabou_ula <= '1' when "0001",
				 '1' when "0010",
				 '1' when "0011",
				 '1' when "0100",
				 '1' when "0101",
				 '1' when "0110",
				 '1' when "0111",
				 '1' when "1000",
				 acabou_mult when "1001",
				 acabou_div when "1010",
				 'U' when others;

process (tempS1, tempS0)
begin		 
	if (tempS1 & tempS0 = zero & zero) then
		checkZero <= '1';
	else
		checkZero <= '0';
	end if;
end process;

process (tempS0)
begin
	if (tempS0(x - 1) = '1') then
		checkNeg <= '1';
	else
		checkNeg <= '0';
	end if;
end process;

process (ulaop, tempS0, Q, M)
begin
	if (ulaop = "0001") then
		if (tempS0(x - 1) = '1' and Q(x - 1) = '0' and M(x - 1) = '0') then
			checkOv <= '1';
		elsif (tempS0(x - 1) = '0' and Q(x - 1) = '1' and M(x - 1) = '1') then
			checkOv <= '1';
		else
			checkOv <= '0';
		end if;
	elsif (ulaop = "0011") then
		if (tempS0(x - 1) = '1' and Q(x - 1) = '0') then
			checkOv <= '1';
		else
			checkOv <= '0';
		end if;
	elsif (ulaop = "0010") then
		if (Q(x - 1) /= M(x - 1) and tempS0(x - 1) = M(x - 1)) then
			checkOv <= '1';
		else
			checkOv <= '0';
		end if;
	elsif (ulaop = "0100") then
		if (Q(x - 1) /= '0' and tempS0(x - 1) = '0') then
			checkOv <= '1';
		else
			checkOv <= '0';
		end if;
	else
		checkOv <= '0';
	end if;
end process;
	
Saida1 <= tempS1;
Saida0 <= tempS0;
ov <= checkOv;
fzero <= checkZero;
neg <= checkNeg;

end arc;