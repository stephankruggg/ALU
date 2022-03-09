library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity bcULA is
generic(x : natural := 8);
port(
	clk, reset: in std_logic;
	opcode: in std_logic_vector(3 downto 0);
	acabou_ula: in std_logic;
	enPC, enA, rst, enB, enOp, enOut: out std_logic
	);
end bcULA;

architecture Controlearc of bcULA is
    type STATES is (init, LOP, LMEMOp, LA, LMEMA, LB, LMEMB, checar, calcular, fim);
    signal eProx, eAtual: STATES;
    
begin
	 
    REG: process(clk, reset)
    begin
        if (reset = '1') then 
            eAtual <= init;
        elsif (clk'event AND clk = '1') then
            eAtual <= eProx;
        end if;
    end process;
    
    COMB: process(eAtual, opcode, acabou_ula)
    begin
        case eAtual is
            when init =>
					 enPC <= '1';
					 enA <= '0';
					 enB <= '0';
					 enOp <= '0';
					 enOut <= '0';
					 rst <= '1';
					 
					 eProx <= LOP;
				
            when LOP =>
					 enPC <= '1';
					 enA <= '0';
					 enB <= '0';
					 enOp <= '0';
					 enOut <= '0';
					 rst <= '0';
					 
					 eProx <= LMEMOp;
				
				when LMEMOp =>
					enPC <= '0';
					 enA <= '0';
					 enB <= '0';
					 enOp <= '1';
					 enOut <= '0';
					 rst <= '0';
					 
					 eProx <= LA;
				
            when LA =>
					 enPC <= '1';
					 enA <= '0';
					 enB <= '0';
					 enOp <= '0';
					 enOut <= '0';
					 rst <= '0';
					 
					 eProx <= LMEMA;
				
				when LMEMA =>
					enPC <= '0';
					 enA <= '1';
					 enB <= '0';
					 enOp <= '0';
					 enOut <= '0';
					 rst <= '0';
					 
					 eProx <= LB;
					 
				when LB =>
					 enPC <= '1';
					 enA <= '0';
					 enB <= '0';
					 enOp <= '0';
					 enOut <= '0';
					 rst <= '0';
					 
					 eProx <= LMEMB;
				
				when LMEMB =>
					 enPC <= '0';
					 enA <= '0';
					 enB <= '1';
					 enOp <= '0';
					 enOut <= '0';
					 rst <= '0';
					 
					 eProx <= checar;
					 
				when checar =>
					 enPC <= '0';
					 enA <= '0';
					 enB <= '0';
					 enOp <= '0';
					 enOut <= '0';
					 rst <= '0';
					 
					 if (opcode = "1111") then
						eProx <= init;
					 elsif (opcode = "0000") then
						eProx <= fim;
					 else
						eProx <= calcular;
					 end if;
				
				when calcular =>
                enPC <= '0';
					 enA <= '0';
					 enB <= '0';
					 enOp <= '0';
					 enOut <= '1';
					 rst <= '0';
					
					if acabou_ula = '1' then
						eProx <= fim;
					else
						eProx <= calcular;
					end if;
				
				when fim => 
                enPC <= '0';
					 enA <= '0';
					 enB <= '0';
					 enOp <= '0';
					 enOut <= '0';
					 rst <= '0';
					 
					 eProx <= LOP;
        end case;
    end process;
end Controlearc;