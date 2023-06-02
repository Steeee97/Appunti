library ieee;
use ieee.std_logic_1164.all;

entity FullSub is
    port(cin, x, y, change:in std_logic;
         z, cout  :out std_logic);
    end FullSub;
    
architecture FullSubBehavior of FullSub is

	
	begin
	   cout <= ((not x) and (y or cin)) or (y and cin) when change = '0' 
				else ((not y) and (x or cin)) or (x and cin) when change = '1';
	   z    <=  (x xor y) xor cin when change = '0' else (y xor x) xor cin  when change = '1';

end FullSubBehavior;