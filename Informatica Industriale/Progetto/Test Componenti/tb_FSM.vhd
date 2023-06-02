library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tbFSM is
end tbFSM;

architecture tbFSM1 of tbFSM is

	component FSM is
	generic ( Nb : integer);	
	port(
		Clk		: in std_logic;
		nRst	: in std_logic;
		X		: in std_logic;
		Y1		: out std_logic;
		Y2		: out std_logic;
		Y3		: out std_logic;
		Y4		: out std_logic;
		Y5		: out std_logic;
		Y6		: out std_logic;
		Y7		: out std_logic;
		Y8		: out std_logic;
		Y9		: out std_logic
		);
	end component;

	
	signal tb_Clk		: std_logic := '1';
	signal tb_nRst		: std_logic := '0';
	signal tb_X			: std_logic;
	signal tb_Y1		: std_logic;
	signal tb_Y2		: std_logic;
	signal tb_Y3		: std_logic;
	signal tb_Y4		: std_logic;
	signal tb_Y5		: std_logic;
	signal tb_Y6		: std_logic;
	signal tb_Y7		: std_logic;
	signal tb_Y8		: std_logic;
	signal tb_Y9		: std_logic;
	
	begin	


	
	process
       begin
       tb_X <= '1'; wait for 10 ns;
       tb_X <= '1'; wait for 10 ns;
	   tb_X <= '1'; wait for 10 ns;   
	end process;	 
	
	
	
	process is
	begin		
		tb_nRst <= '1';
		
		wait;
	end process;
	
	process
       begin	   
       tb_Clk <= '1'; wait for 10 ns;
       tb_Clk <= '0'; wait for 10 ns;   
	end process;
	
	ci : FSM generic map(Nb => 3) port map(tb_Clk, tb_nRst, tb_X, tb_Y1, tb_Y2, tb_Y3, tb_Y4, tb_Y5, tb_Y6, tb_Y7, tb_Y8, tb_Y9);
	
end architecture;