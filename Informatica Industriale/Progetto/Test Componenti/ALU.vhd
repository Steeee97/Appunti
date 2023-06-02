library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ALU is 
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
end entity;

architecture ALU1 of ALU is

	component Adder is
		generic ( Nb : integer);
         port(
				a, b	: in std_logic_vector(Nb-1 downto 0);
				c  		: out std_logic_vector(Nb-1 downto 0)
			  );
	end component;
	
	component Sub is
		generic ( Nb : integer);
         port(
				a, b	: in std_logic_vector(Nb-1 downto 0);
				change	: in std_logic;
				c  		: out std_logic_vector(Nb-1 downto 0)
			  );
	end component;
	
	component C2 is
		generic ( Nb : integer);
         port(
				a, b	: in std_logic_vector(Nb-1 downto 0);
				change	: in std_logic;
				c  		: out std_logic_vector(Nb-1 downto 0)
			  );
	end component;
	
	component Compare is
		generic ( Nb : integer);
         port(
				a, b	: in std_logic_vector(Nb-1 downto 0);
				c  		: out std_logic_vector(Nb-1 downto 0)
			  );
	end component;
	
	signal ResultA  : std_logic_vector(Nb-1 downto 0);
	signal ResultS  : std_logic_vector(Nb-1 downto 0);
	signal ResultE  : std_logic_vector(Nb-1 downto 0);
	signal ResultC  : std_logic_vector(Nb-1 downto 0);
	
begin	

	ai : Adder 		generic map(Nb => 3) port map( A, B, ResultA);
	si : Sub 		generic map(Nb => 3) port map( A, B, change, ResultS);
	ei : Compare 	generic map(Nb => 3) port map( A, B, ResultE);
	ci : C2 		generic map(Nb => 3) port map( A, B, change, ResultC);

	
	process(Clk)
	begin
	   if rising_edge(Clk) then
		   if  YA = '1' then
				C <= ResultA;
		   end if;
		   if  YS = '1' then
				C <= ResultS;
		   end if;
		   if  YE = '1' then
				C <= ResultE;
		   end if;
		   if  YC = '1' then
				C <= ResultC;
		   end if;		
	   end if;
	end process;
	
end architecture;