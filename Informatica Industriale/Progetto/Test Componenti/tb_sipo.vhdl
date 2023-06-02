library ieee;
use ieee.std_logic_1164.all;

entity tb_sipo is
  end tb_sipo;
    
architecture tb_sipo_behavior of tb_sipo is
		
	component sipo is
    generic ( Nb : integer) ;
    port( DATA_IN  :in std_logic;
          clk      :in std_logic;
          enable   :in std_logic;   
          DATA_OUT :out std_logic_vector(Nb-1 downto 0)
    );
    end component;
	
	component signal_generator is
    port(data, clock, enable: out std_logic);
    end  component;
   
  constant numb: integer := 3;     	
	signal clock, Din, internal_enable: std_logic;
	signal SIPO_OUT: std_logic_vector(numb-1 downto 0);
	signal Enable1: std_logic;
	
	begin
 
   cmpt1: signal_generator
      port map(Din, clock, internal_enable);
   
   cmpt2: sipo
      generic map (Nb => numb)
      port map(Din, clock, Enable1, SIPO_OUT);   
	 
end tb_sipo_behavior;