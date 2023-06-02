library ieee;
use ieee.std_logic_1164.all;

entity Compare is
    generic ( Nb : integer ) ;
    port(
         a, b :in  std_logic_vector(Nb-1 downto 0);
         c    :out std_logic_vector(Nb-1 downto 0)
		);
    end Compare;
    
architecture CompareBehavior of Compare is
		 
	component FullCompare is
         port(x, y:in std_logic;
			  z :out std_logic);
	end component;
			
	begin

         hdi : for k in Nb-1 downto 0 generate
			ni : FullCompare port map(a(k), b(k), c(k));
         end generate;

		 
  
end CompareBehavior;

