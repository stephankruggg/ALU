library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity tb_ulamem is
end tb_ulamem;

architecture tb of tb_ulamem is
    signal clock: std_logic;
    signal address: std_logic_vector(5 downto 0);
	 signal q: std_logic_vector(7 downto 0);
	 constant clk_period: time := 20ns;
begin
    UUT : entity work.ulamem port map 
	            (address, clock, q);
    
	 address <= "000111", "001110" after clk_period*2, "100010" after clk_period*4;
	 
    clk_gen : process
        begin
                clock <= '1';
            wait for clk_period/2; -- 50% do periodo pra cada nivel
                clock <= '0';
                wait for clk_period/2;
        end process;
end tb;