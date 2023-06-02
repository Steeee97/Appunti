library ieee;
use ieee.std_logic_1164.all;


entity FullC2 is
    port(cin, x, y, b, change :in std_logic;
         z, cout  :out std_logic);
    end FullC2;
    
architecture FullC2Behavior of FullC2 is

	component FullAdder is
         port(
		cin, x, y	:	in std_logic;
		z, cout  	:	out std_logic
			  );
	end component;

	signal a: std_logic;
	
	begin
   	a 	<= not(x) when change = '0' else not(y) when change = '1';

	myfull:	FullAdder port map(a, cin, b, z, cout);


end FullC2Behavior;