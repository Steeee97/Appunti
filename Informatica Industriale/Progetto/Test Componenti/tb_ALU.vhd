library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tbALU is
    end tbALU;
    
architecture tbALUBehavior of tbALU is
		
	component ALU is
		generic ( Nb : integer);
		port(
			Clk		: in std_logic; 
			nRst	: in std_logic; 
			A		: in std_logic_vector(Nb-1 downto 0); 
			B		: in std_logic_vector(Nb-1 downto 0);
			YA		: in std_logic;
			YS		: in std_logic;
			YE		: in std_logic;
			YC		: in std_logic;
			C		: out std_logic_vector(Nb-1 downto 0)
		);
	end component;

	
	signal tb_Nb 			: integer := 3;		
	signal tb_a				: std_logic_vector(tb_Nb - 1 downto 0) := "100";
	signal tb_b				: std_logic_vector(tb_Nb - 1 downto 0) := "101";
	signal tb_c				: std_logic_vector(tb_Nb - 1 downto 0);
	signal tb_enable		: std_logic := '0';
	signal tb_enable2		: std_logic := '0';
	signal tb_enable3		: std_logic := '0';
	signal tb_enable4		: std_logic := '0';
	signal clock_internal   : std_logic;
	
	begin
	 	

	ci : ALU generic map(Nb => 3) port map(clock_internal, '1', tb_a, tb_b,tb_enable, tb_enable2, tb_enable3, tb_enable4, tb_c);
	
	process
    begin
        clock_internal <= '0'; wait for 10 ns;
		clock_internal <= '1'; wait for 10 ns;
    end process;

end tbALUBehavior;