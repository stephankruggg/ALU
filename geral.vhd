library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity geral is
    generic(X : natural := 8);
	port (
		clk, reset: in std_logic;
		PQ, S: out std_logic_vector(x - 1 downto 0);
      flagZ, flagN, flagOv: out std_logic
	);
end geral;

architecture arch of geral is

	component boULA
    port (
	   clk, enPC, enOp, enA, enB, enOut, rst: in std_logic;
		PQ, S: out std_logic_vector(x - 1 downto 0);
      flagZ, flagOv, flagN: out std_logic;
		opcode: out std_logic_vector(3 downto 0);
		acabou_ula: out std_logic
	);
	end component;

    component bcULA
    port(
		clk, reset: in std_logic;
		opcode: in std_logic_vector(3 downto 0);
		acabou_ula: in std_logic;
		enPC, enA, rst, enB, enOp, enOut: out std_logic
	);
    end component;
	
	signal tenPC, tenA, tenB, trst, tenOp, tenOut: std_logic;
	signal topcode: std_logic_vector(3 downto 0);
	signal tacabou_ula: std_logic;
	
begin

    bo1: boULA port map (clk, tenPC, tenOp, tenA, tenB, tenOut, trst, PQ, S, flagZ, flagN, flagOv, topcode, tacabou_ula);
	 bc1: bcULA port map (clk, reset, topcode, tacabou_ula, tenPC, tenA, trst, tenB, tenOp, tenOut);
	
end arch;