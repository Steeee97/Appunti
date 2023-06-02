library ieee;
use ieee.std_logic_1164.all;
	 
entity pipo is
    generic ( Nb : integer) ;
    port( DATA_IN     :in std_logic_vector(Nb-1 downto 0);
          clk, enable, reset :in std_logic; 
          DATA_OUT    :out std_logic_vector(Nb-1 downto 0)
    );
    end pipo;
    
architecture pipo_behavior of pipo is
		
	component flip_flop_D is
    port(D           :in  std_logic; 
         clk, enable, reset :in  std_logic;
         Q           :out std_logic);
	end component;
	
   signal clock, Din: std_logic;
   signal support_signal1, support_signal2 : std_logic_vector(Nb-1 downto 0);
	
	begin
    
    DATA_OUT <= support_signal1;
    support_signal2 <= DATA_IN;
    
    g1 : for k in Nb-1 downto 0 generate
      ni : flip_flop_D port map(support_signal2(k), clk, enable, reset, support_signal1(k));
        end generate;
	   
end pipo_behavior;