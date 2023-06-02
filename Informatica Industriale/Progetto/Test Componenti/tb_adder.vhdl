library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tbAdder is
    end tbAdder;
    
architecture tbAdderBehavior of tbAdder is
		
	component Adder is
		generic ( Nb : integer );
		port(
			a, b 	:in  std_logic_vector(Nb - 1 downto 0);
			c    	:out std_logic_vector(Nb - 1 downto 0);
			enable	:in std_logic);
	end component;
	
	component counter is
		generic ( Nb : integer) ;
		port( 	
			T     		:in std_logic;
			clk         :in std_logic; 
			OUT_COUNT   :out std_logic_vector(Nb-1 downto 0));
	end component;
	
	signal tb_Nb 			: integer := 3;		
	signal tb_a				: std_logic_vector(tb_Nb - 1 downto 0) := "100";
	signal tb_b				: std_logic_vector(tb_Nb - 1 downto 0) := "101";
	signal tb_c				: std_logic_vector(tb_Nb - 1 downto 0);
	signal tb_enable		: std_logic := '0';
	signal datatot			: std_logic_vector(tb_Nb - 1 downto 0);
	signal clock_internal   : std_logic;
	
	begin
	 	
	co : counter generic map (Nb => 3) port map('1', clock_internal, datatot);
	ci : Adder generic map(Nb => 3) port map(tb_a, tb_b, tb_c, tb_enable);
	
	process
    begin
        clock_internal <= '0'; wait for 10 ns;
		clock_internal <= '1'; wait for 10 ns;
    end process;

end tbAdderBehavior;