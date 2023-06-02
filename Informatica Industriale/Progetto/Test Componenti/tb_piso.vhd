library ieee;
use ieee.std_logic_1164.all;

entity tb_piso is
  end tb_piso;
    
architecture tb_piso_behavior of tb_piso is
		
	component piso is
    generic ( Nb : integer) ;
    port( DATA_IN  :in  std_logic_vector(Nb-1 downto 0);
          Clk      :in std_logic;
          Enable   :in std_logic;   
          DATA_OUT :out std_logic
    );
    end component;
	
	component signal_generator is
    port(data, clock, enable: out std_logic);
    end  component;
   
	constant numb: integer := 3;     	
	signal clock, Din, internal_enable: std_logic;
	signal Din1		: std_logic_vector(numb-1 downto 0) := "101";
	signal Enable1	: std_logic;
	signal outs		: std_logic;
	
	begin
 
   cmpt1: signal_generator
      port map(Din, clock, internal_enable);
   
   cmpt2: piso
      generic map (Nb => numb)
      port map(Din1, clock, Enable1, outs);   
	 
end tb_piso_behavior;