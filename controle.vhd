library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity controle is
port(
	clk, nZero, reset: in std_logic;
	novoNum, acabou, carga, cargaM: out std_logic
	);
end controle;

architecture Controlearc of controle is
    type STATES is (start, setup, calcular, checar, fim);
    signal eProx, eAtual: STATES;
    

begin
    
    REG: process(clk, reset)
    begin
        if (reset = '1') then 
            eAtual <= start;
        elsif (clk'event AND clk = '1') then
            eAtual <= eProx;
        end if;
    end process;
    
    COMB: process(eAtual, nZero)
    begin
        case eAtual is
            when start =>
                novoNum <= '0';
                acabou <= '0';
                carga <= '0';
                cargaM <= '0';
                eprox <= setup;
            when setup =>
					 novoNum <= '1';
					 acabou <= '0';
                carga <= '1';
                cargaM <= '1';
                eprox <= calcular;
            when calcular =>
                acabou <= '0';
					 novoNum <= '0';
                carga <= '1';
                cargaM <= '0';
                eProx <= checar;
            when checar => 
                acabou <= '0';
					 novoNum <= '0';
                carga <= '0';
                cargaM <= '0';
                if(nZero = '1') then
                    eProx <= fim;
                else
                    eProx <= calcular;
                end if;
				when fim =>
					 acabou <= '1';
					 novoNum <= '0';
                carga <= '0';
                cargaM <= '0';
					 eProx <= start;
        end case;
    end process;
end Controlearc;