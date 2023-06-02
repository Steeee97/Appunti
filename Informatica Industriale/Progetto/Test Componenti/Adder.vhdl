library ieee;
use ieee.std_logic_1164.all;

entity Adder is
    generic ( Nb : integer ) ;
    port(
        a, b 	:in  std_logic_vector(Nb-1 downto 0); --Due valori da sommare
        c    	:out std_logic_vector(Nb-1 downto 0)
		);
    end Adder;
    
architecture AdderBehavior of Adder is
		
	component FullAdder is
         port(cin, x, y	:	in std_logic;
			  z, cout  	:	out std_logic
			  );
	end component;
		
	signal carry0	: std_logic;	
	signal carry	: std_logic_vector(Nb downto 0);
	
	begin

         hdi : for k in Nb-1 downto 0 generate
			ni : FullAdder port map(carry(k), a(k), b(k), c(k), carry(k+1));
         end generate;
		 
		 carry(0) <= '0';
		 
  
end AdderBehavior;