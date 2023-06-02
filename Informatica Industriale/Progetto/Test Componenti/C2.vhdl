library ieee;
use ieee.std_logic_1164.all;

entity C2 is
    generic ( Nb : integer );
    port(
         a, b  	:in  std_logic_vector(Nb-1 downto 0);
		 change	: in std_logic; 
         c    	:out std_logic_vector(Nb-1 downto 0)
		);
    end C2;
    
architecture C2behavior of C2 is
		
	component FullC2 is
            port(cin, x, y, b, change :in std_logic;
			z, cout  :out std_logic);
	end component;
		
	signal carry0: std_logic;
	
	signal carry: std_logic_vector(Nb downto 0);

	
	begin
	
		carry0 <= '1';
	
		 n0 : FullC2 port map(carry(0), a(0), b(0), carry0, change,  c(0), carry(1));

         hdi : for k in Nb-1 downto 1 generate
         ni : FullC2 port map(carry(k), a(k), b(k), '0',  change, c(k), carry(k+1));
         end generate;

		 carry(0) <= '0';
		 
  
end C2behavior;
