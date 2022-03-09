library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity tb_projeto is
GENERIC (N : INTEGER := 8);
end tb_projeto;

architecture tb of tb_projeto is
    signal M, Q:std_logic_vector(3 downto 0);
    signal S1, S0: std_logic_vector (3 downto 0);
    signal clk, reset, acabou: std_logic;
    constant clk_period: time := 20ns;
begin
    UUT : entity work.trabalhoGrupo port map 
	            (M, Q, clk, reset, S1, S0, acabou);
    reset <= '1', '0' after clk_period; 
    M <= "0000", "0010" after 11*clk_period, "1001" after 21*clk_period, "1111" after 31*clk_period, "0001" after 41*clk_period, "0100" after 51*clk_period;
    Q <= "0000", "0100" after 11*clk_period, "1000" after 21*clk_period, "1111" after 31*clk_period, "0000" after 41*clk_period, "0010" after 51*clk_period;
    clk_gen : process
        begin
                clk <= '1';
            wait for clk_period/2; -- 50% do periodo pra cada nivel
                clk <= '0';
                wait for clk_period/2;
        end process;
end tb;