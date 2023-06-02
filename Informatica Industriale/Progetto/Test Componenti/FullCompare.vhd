library ieee;
use ieee.std_logic_1164.all;

entity FullCompare is
    port( x, y	:in std_logic;
          z  	:out std_logic);
    end FullCompare;

architecture FullCompareBehavior of FullCompare is
begin
  
	z <= '1' when x = y else '0';
  
end FullCompareBehavior;

