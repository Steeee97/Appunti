library ieee;
use ieee.std_logic_1164.all;

entity Sub is
    generic ( Nb : integer ) ;
    port(
         a, b 	:in  std_logic_vector(Nb-1 downto 0);
		 change	:in std_logic;
         c    	:out std_logic_vector(Nb-1 downto 0)
		);
    end Sub;
    
architecture SubBehavior of Sub is
		
	component FullSub is
         port(
			cin, x, y, change	:in std_logic;
			z, cout  			:out std_logic
			);
	end component;
		
	signal carry0: std_logic;
	
	signal carry: std_logic_vector(Nb downto 0);
	
	begin

         hdi : for k in Nb-1 downto 0 generate
         ni : FullSub port map(carry(k), a(k), b(k), change, c(k), carry(k+1));
         end generate;

		 carry(0) <= '0';
  
end SubBehavior;