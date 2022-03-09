library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity bodiv is
    generic(X : natural := 8);
	port (
	   M, Q: in std_logic_vector(x - 1 downto 0);
		clk, novoNum, carga, cargaM: in std_logic;
		quotient, remainder: out std_logic_vector(x - 1 downto 0);
      nZero: out std_logic       
	);
end bodiv;

architecture arch of bodiv is

	component registrador
    PORT (clk, reset, carga : IN STD_LOGIC;
	  d : IN std_logic_vector(x - 1 DOWNTO 0);
	  q : OUT std_logic_vector(x - 1 DOWNTO 0));
	end component;

    component igualazero
    PORT (a : IN std_logic_vector(X-1 downto 0);
    igual : OUT STD_LOGIC);
    end component;

    component uladiv
    port(Asub, Qshift, Ashift: in std_logic_vector(X-1 downto 0);
		ulaop: in std_logic;
		AF, QF: out std_logic_vector(X - 1 downto 0));
    end component;

    component shiftLeft
    port(
        AP, QP: in std_logic_vector (x - 1 downto 0);
        Ashift,  Qshift: out std_logic_vector (x - 1 downto 0));
    end component;

    component mux
    PORT ( a, b : IN std_logic_vector(x - 1 DOWNTO 0);
         sel: IN STD_LOGIC;
         y : OUT std_logic_vector(x - 1 DOWNTO 0));
    end component;
	 	
	 signal AP, AF, MP, QF, QM, QP, Ashift, Qshift, Asub, Nsub, NM, NP: std_logic_vector(x - 1 downto 0);
	 signal entN: std_logic_vector(X - 1 downto 0) := std_logic_vector(to_unsigned(X, X));

begin

    regisA: registrador port map (clk, novoNum, carga, AF, AP);
	 regisM: registrador port map (clk, '0', cargaM, M, MP);
	 muxQ: mux port map (QF, Q, novoNum, QM);
	 regisQ: registrador port map (clk, '0', carga, QM, QP);
	 shiftLeft1: shiftLeft port map (AP, QP, Ashift, Qshift);
	 Asub <= Ashift - MP;
	 ULA1: uladiv port map (Asub, Qshift, Ashift, Asub(x - 1), AF, QF);
	 muxN: mux port map (Nsub, entN, novoNum, NM);
	 regisN: registrador port map (clk, '0', carga, NM, NP);
	 Nsub <= NP - 1;
	 igualaZero1: igualazero port map (NP, nZero);
	 
	 quotient <= QP;
	 remainder <= AP;

end arch;