library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity boULA is
   generic(X : natural := 8);
	port (
		clk, enPC, enOp, enA, enB, enOut, rst: in std_logic;
		PQ, S: out std_logic_vector(x - 1 downto 0);
      flagZ, flagOv, flagN: out std_logic;
		opcode: out std_logic_vector(3 downto 0);
		acabou_ula: out std_logic
	);
end boULA;

architecture arch of boULA is

	component registrador
    PORT (clk, reset, carga : IN STD_LOGIC;
	  d : IN std_logic_vector(x - 1 DOWNTO 0);
	  q : OUT std_logic_vector(x - 1 DOWNTO 0));
	end component;
	
	component registrador1bit 
	 PORT (clk, reset, carga : IN STD_LOGIC;
	  d : IN STD_LOGIC;
	  q : OUT STD_LOGIC);
	end component;

   component ULATP2
	 PORT (M, Q: in std_logic_vector(X - 1 downto 0);
			clk: in std_logic;
			ulaop: in std_logic_vector(3 downto 0);
			Saida1, Saida0: out std_logic_vector (x - 1 downto 0);
			neg, fzero, ov: out std_logic;
			acabou_ula: out std_logic);
	end component;
	
	component ulamem
	 PORT (address: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		clock: IN STD_LOGIC;
		q: OUT STD_LOGIC_VECTOR (x - 1 DOWNTO 0));
	end component;
	 	
	signal outPC, outmem, outA, outB, outOp: std_logic_vector(x - 1 downto 0);
	signal inPC: std_logic_vector(x - 1 downto 0) := (others => '0');
	signal outPQ, outS: std_logic_vector(x - 1 downto 0);
	signal outflagN, outflagZ, outflagOv: std_logic;
	
	
begin
	regPC: registrador port map (clk, rst, enPC, inPC, outPC);
	
	inPC <= outPC + 1;
	
	memoria: ulamem port map (outPC(5 downto 0), clk, outmem);
	
	regOp: registrador port map (clk, rst, enOp, outmem, outOp);
	regA: registrador port map (clk, rst, enA, outmem, outA);
	regB: registrador port map (clk, rst, enB, outmem, outB);
	
	opcode <= outOp(3 downto 0);
	
	ula: ULATP2 port map (outB, outA, clk, outOp(3 downto 0), 
								 outPQ, outS, outflagN, outflagZ, 
								 outflagOv, acabou_ula);
	
	regPQ: registrador port map (clk, rst, enOut, outPQ, PQ);
	regS: registrador port map (clk, rst, enOut, outS, S);
	regZ: registrador1bit port map (clk, rst, enOut, outflagZ, flagZ);
	regOv: registrador1bit port map (clk, rst, enOut, outflagOv, flagOv);
	regN: registrador1bit port map (clk, rst, enOut, outflagN, flagN);
	
end arch;