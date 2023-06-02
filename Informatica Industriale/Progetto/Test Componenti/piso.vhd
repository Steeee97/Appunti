library ieee;
use ieee.std_logic_1164.all;

entity piso is
    generic ( Nb : integer);
    port( DATA_IN  :in  std_logic_vector(Nb-1 downto 0);
          Clk      :in std_logic;
          Enable   :in std_logic;   
          DATA_OUT :out std_logic
    );
    end piso;
    
architecture pisoBehavior of piso is
		
	 signal sr: std_logic_vector(Nb - 1 downto 0) := (others=>'0');

	begin
    	
	process (Clk, Enable, DATA_IN)
		begin
		if (Enable = '1') then
			sr <= DATA_IN;
		elsif rising_edge(Clk) then
			sr <= '0' & sr(Nb - 1 downto 1);
		end if;
	end process;
	    
	  DATA_OUT <= sr(0); 
    
   
end pisoBehavior;




