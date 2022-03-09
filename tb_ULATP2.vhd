library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity tb_ULATP2 is
end tb_ULATP2;

architecture tb of tb_ULATP2 is
	signal M, Q: std_logic_vector(3 downto 0);
	signal clk: std_logic;
	signal ulaop: std_logic_vector(3 downto 0);
	signal Saida1, Saida0: std_logic_vector (4 - 1 downto 0);
	signal neg, ov, fzero: std_logic;
   constant clk_period: time := 20ns;

begin
    UUT : entity work.ULATP2 port map 
	            (M, Q, clk, ulaop, Saida1, Saida0, neg, fzero, ov);
    M <= "1000";
    Q <= "0111";
    ulaop <= "0001", "0010" after 20 ns, "0011" after 40 ns, "0100" after 60 ns,
				  "0101" after 80 ns, "0110" after 100 ns, "0111" after 120 ns, "1000" after 140 ns,
				  "1001" after 160 ns, "1010" after 180 ns;
    
	 clk_gen : process
        begin
                clk <= '1';
            wait for clk_period/2; -- 50% do periodo pra cada nivel
                clk <= '0';
                wait for clk_period/2;
        end process;
end tb;