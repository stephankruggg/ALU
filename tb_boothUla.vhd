library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity tb_boothUla is
end tb_boothUla;

architecture tb of tb_boothUla is
	signal M, Q: std_logic_vector(4-1 downto 0);
	signal clk: std_logic;
	signal ulaop: std_logic_vector(1 downto 0);
	signal S: std_logic_vector (4 + 4 - 1 downto 0);
    constant clk_period: time := 40ns;
begin
    UUT : entity work.boothUla port map 
	            (M, Q, clk, ulaop, S);
    M <= "1001";
    Q <= "0011";
    ulaop <= "01", "10" after 20 ns, "01" after 40 ns, "11" after 60 ns;
    clk_gen : process
        begin
                clk <= '1';
            wait for clk_period/2; -- 50% do periodo pra cada nivel
                clk <= '0';
                wait for clk_period/2;
        end process;
end tb;