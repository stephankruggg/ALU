library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity tb_geral is
end tb_geral;

architecture tb of tb_geral is
	signal clk, reset: std_logic;
	signal PQ, S: std_logic_vector(7 downto 0);
	signal flagN, flagOv, flagZ: std_logic;
   constant clk_period: time := 20ns;

begin
    UUT : entity work.geral port map 
	            (clk, reset, PQ, S, flagZ, flagN, flagOv);
	
	reset <= '0';
	
   clk_gen : process
        begin
                clk <= '1';
            wait for clk_period/2; -- 50% do periodo pra cada nivel
                clk <= '0';
                wait for clk_period/2;
        end process;
end tb;