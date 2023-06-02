library ieee;
use ieee.std_logic_1164.all;

entity flip_flop_D is
    port(D  	:in  std_logic; 
         clk	:in  std_logic;
         enable	: in std_logic;
         reset	: in std_logic;
         Q,QN  	:out std_logic);
    end flip_flop_D;
    
architecture flip_flop_D_behavior of flip_flop_D is
signal qtemp: std_logic:='0';
	
	begin
   
process(clk)
variable qvar:std_logic:='0';

begin
	if enable ='1' then
		if rising_edge(clk) then 
		   qvar:= D;
		end if;
	end if;

	qtemp <=qvar;


end process;

Q <= qtemp when reset = '1' else '0' when reset = '1';
QN <= not(qtemp);

       
	 
end flip_flop_D_behavior;