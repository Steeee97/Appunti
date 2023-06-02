library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity MOALU is 
	generic ( Nb : integer);
	port(
		Clk		: in std_logic; 
		nRst	: in std_logic; 
		change	: in std_logic;
		X		: in std_logic;
		Y		: out std_logic;
		Error	: out std_logic;
		YALU	: out std_logic_vector(Nb-1 downto 0);
		Done	: out std_logic
	);
end entity;

architecture MOALU1 of MOALU is

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
		Y9		: out std_logic;
		Y10		: out std_logic
	);
	end component;
	
	component sipo is
    generic ( Nb : integer) ;
    port( DATA_IN  	:in std_logic;
          Clk      	:in std_logic;
          Enable   	:in std_logic;   
          reset    	:in std_logic;   
          DATA_OUT 	:out std_logic_vector(Nb-1 downto 0)
    );
    end component;	
	
	component pipo is
    generic ( Nb : integer);
    port( DATA_IN  	:in  std_logic_vector(Nb-1 downto 0);
          Clk      	:in std_logic;
          Enable   	:in std_logic;   
          reset    	:in std_logic;   
          DATA_OUT 	:out std_logic_vector(Nb-1 downto 0)
    );
    end component;
	
	component ALU is
	generic ( Nb : integer);
	port(
		Clk		: in std_logic; 
		nRst	: in std_logic; 
		change	: in std_logic; 
		A		: in std_logic_vector(Nb-1 downto 0); 
		B		: in std_logic_vector(Nb-1 downto 0);
		YA		: in std_logic;
		YS		: in std_logic;
		YE		: in std_logic;
		YC		: in std_logic;
		C		: out std_logic_vector(Nb-1 downto 0)
	);
	end component;
		
	component TX is
    generic ( Nb : integer);
    port( 	A  		 	:in  std_logic_vector(Nb-1 downto 0);
			B  		 	:in  std_logic_vector(Nb-1 downto 0);
			Clk      	:in std_logic;
			Enable   	:in std_logic; 
			C		 	:out std_logic
    );
    end component;
	
	
	signal Somma 			: std_logic;
	signal C2 				: std_logic;
	signal Sottrazione 		: std_logic;
	signal Comparazione 	: std_logic;
	signal RXA				: std_logic;
	signal RXB				: std_logic;
	signal TXAB				: std_logic;
	signal StB				: std_logic;
	signal EnableRegOut		: std_logic := '0';
	signal A				: std_logic_vector(Nb-1 downto 0);
	signal B				: std_logic_vector(Nb-1 downto 0);
		
	signal C				: std_logic_vector(Nb-1 downto 0);
	
begin	


	myfsm 	: FSM 	generic map(Nb => Nb) port map(Clk, nRst, X, RXA, Error, Comparazione, Sottrazione, C2, Somma, TXAB, StB, RXB, Done);
	
	RegA	: sipo 	generic map(Nb => Nb) port map(X, Clk, RXA, nRst, A);
	RegB	: sipo 	generic map(Nb => Nb) port map(X, Clk, RXB, nRst, B);
	
	myalu	: ALU 	generic map(Nb => Nb) port map(Clk, nRst, change, A, B, Somma, Sottrazione, Comparazione, C2, C);	
	
	RegOut	: pipo 	generic map(Nb => Nb) port map(C, Clk, EnableRegOut, nRst, YALU);

	myTX 	: TX  	generic map(Nb => Nb) port map(A, B, Clk, TXAB, Y);
	
	
	EnableRegOut <= Comparazione or Sottrazione or C2 or Somma;
	
	
end architecture;