library ieee;
use ieee.std_logic_1164.all;

entity TX is
    generic ( Nb : integer);
    port( 	A  		 	:in  std_logic_vector(Nb-1 downto 0);
			B  		 	:in  std_logic_vector(Nb-1 downto 0);
			Clk      	:in std_logic;
			Enable   	:in std_logic; 
			C		 	:out std_logic
    );
    end TX;
    
architecture TXBehavior of TX is
		
		
	signal sr	: 	std_logic_vector(Nb - 1 downto 0) := (others=>'0');
	signal sr2	: 	std_logic_vector(Nb - 1 downto 0) := (others=>'0');
	signal Counter : integer range 0 to 3 * Nb;
	signal Enable2 : std_logic := '0';

	begin
    	
	process (Clk, Enable, A, B)
		begin
		if (Enable = '1') then
			Counter <= 0;
			Enable2 <= '0';
			sr <= A;
			sr2 <= B;
		elsif rising_edge(Clk) then
			if(	Counter < Nb - 1 ) then			
				sr <= '0' & sr(Nb - 1 downto 1);				
			else
				Enable2 <= '1';
				sr2 <= '0' & sr2(Nb - 1 downto 1);
			end if;
			
			Counter <= Counter + 1;
		end if;
		
		if (Counter > 2*Nb) then
			Counter <= 0;
		end if;
	end process;
	    
	 C <= sr(0) when Enable2 = '0' else sr2(0) when Enable2 = '1'; 
	    

    
   
end TXBehavior;




