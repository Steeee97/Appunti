library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tbMOALU is
    end tbMOALU;
    
architecture tbMOALUBehavior of tbMOALU is
		
	component MOALU is
		generic ( Nb : integer);
		port(
		Clk		: in std_logic; 
		nRst	: in std_logic; 
		X		: in std_logic;
		change	: in std_logic;
		Y		: out std_logic;
		YALU	: out std_logic_vector(Nb-1 downto 0);
		Done	: out std_logic
	);
	end component;

	constant tb_Nb 			: integer := 3;		
	signal tb_x				: std_logic := '0';
	signal tb_y				: std_logic := '0';	
	signal tb_done			: std_logic := '0';	
	signal tb_y2			: std_logic_vector(2 downto 0);
	signal clock_internal   : std_logic;
	signal count   			: integer range 0 to 20 := 0;
	
	begin
	 	

	ci : MOALU generic map(Nb => 3) port map(clock_internal, '1', tb_x, '0', tb_y, tb_y2, tb_done);
	
	process
    begin
        clock_internal <= '0'; wait for 10 ns;
		clock_internal <= '1'; wait for 10 ns;
    end process;
	process
	begin
	
	-- --RX
	-- 	tb_x <= '1'; wait for 20 ns;
	-- 	tb_x <= '1'; wait for 20 ns;
	-- 	tb_x <= '1'; wait for 20 ns;
	-- --A            
	-- 	tb_x <= '0'; wait for 20 ns;
	-- 	tb_x <= '0'; wait for 20 ns;
	-- 	tb_x <= '1'; wait for 20 ns;	
	-- --B            
	-- 	tb_x <= '1'; wait for 20 ns;
	-- 	tb_x <= '1'; wait for 20 ns;
	-- 	tb_x <= '0'; wait for 20 ns;
	-- --Sottrazione  
	-- 	tb_x <= '1'; wait for 20 ns;
	-- 	tb_x <= '0'; wait for 20 ns;
	-- 	tb_x <= '0'; wait for 20 ns;
	-- --BUSY         
	-- 	tb_x <= '1'; wait for 20 ns;
	-- 	tb_x <= '1'; wait for 20 ns;
	-- --TX           
	-- 	tb_x <= '0'; wait for 20 ns;
	-- 	tb_x <= '0'; wait for 20 ns;		
	-- 	tb_x <= '1'; wait for 20 ns;
	-- --BUSY         
	-- 	tb_x <= '1'; wait for 20 ns;
	-- 	tb_x <= '1'; wait for 20 ns;
	-- 	tb_x <= '1'; wait for 20 ns;
	-- 	tb_x <= '1'; wait for 20 ns;
	-- 	tb_x <= '1'; wait for 20 ns;
	-- 	tb_x <= '1'; wait for 20 ns;
	-- --C2           
	-- 	tb_x <= '0'; wait for 20 ns;
	-- 	tb_x <= '1'; wait for 20 ns;		
	-- 	tb_x <= '1'; wait for 20 ns;	
	-- --BUSY         
	-- 	tb_x <= '1'; wait for 20 ns;
	-- 	tb_x <= '1'; wait for 20 ns;
	-- --StandBy         
	-- 	tb_x <= '0'; wait for 20 ns;
	-- 	tb_x <= '0'; wait for 20 ns;
	-- 	tb_x <= '0'; wait for 20 ns;
	
	-- --StandBy         
	-- 	tb_x <= '0'; wait for 20 ns;
	-- 	tb_x <= '0'; wait for 20 ns;
	-- 	tb_x <= '0'; wait for 20 ns;
	-- --RX
	-- 	tb_x <= '1'; wait for 20 ns;
	-- 	tb_x <= '1'; wait for 20 ns;
	-- 	tb_x <= '1'; wait for 20 ns;
	-- --A            
	-- 	tb_x <= '0'; wait for 20 ns;
	-- 	tb_x <= '0'; wait for 20 ns;
	-- 	tb_x <= '1'; wait for 20 ns;	
	-- --B            
	-- 	tb_x <= '1'; wait for 20 ns;
	-- 	tb_x <= '1'; wait for 20 ns;
	-- 	tb_x <= '0'; wait for 20 ns;
	-- --Comparazione           
	-- 	tb_x <= '1'; wait for 20 ns;
	-- 	tb_x <= '0'; wait for 20 ns;	
	-- 	tb_x <= '1'; wait for 20 ns;
	-- --BUSY         
	-- 	tb_x <= '1'; wait for 20 ns;
	-- 	tb_x <= '1'; wait for 20 ns;
	-- --TX           
	-- 	tb_x <= '0'; wait for 20 ns;
	-- 	tb_x <= '0'; wait for 20 ns;		
	-- 	tb_x <= '1'; wait for 20 ns;

	--RX
		tb_x <= '1'; wait for 20 ns;
		tb_x <= '1'; wait for 20 ns;
		tb_x <= '1'; wait for 20 ns;
	--A            
		tb_x <= '0'; wait for 20 ns;
		tb_x <= '0'; wait for 20 ns;
		tb_x <= '1'; wait for 20 ns;	
	--B            
		tb_x <= '1'; wait for 20 ns;
		tb_x <= '1'; wait for 20 ns;
		tb_x <= '0'; wait for 20 ns;
	--Somma  
		tb_x <= '0'; wait for 20 ns;
		tb_x <= '1'; wait for 20 ns;
		tb_x <= '0'; wait for 20 ns;
	--BUSY         
		tb_x <= '1'; wait for 20 ns;
		tb_x <= '1'; wait for 20 ns;
	--TX           
		tb_x <= '0'; wait for 20 ns;
		tb_x <= '0'; wait for 20 ns;		
		tb_x <= '1'; wait for 20 ns;
	--BUSY         
		tb_x <= '1'; wait for 20 ns;
		tb_x <= '1'; wait for 20 ns;
		tb_x <= '1'; wait for 20 ns;
		tb_x <= '1'; wait for 20 ns;
		tb_x <= '1'; wait for 20 ns;
		tb_x <= '1'; wait for 20 ns;
	
		
    end process;

end tbMOALUBehavior;