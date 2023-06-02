library ieee;
use ieee.std_logic_1164.all;

entity signal_generator is
    port(data, clock, enable: out std_logic);
    end signal_generator;
    
architecture signal_generator_behavior of signal_generator is
component flip_flop_D is
    port(D           :in  std_logic; 
         clk, enable :in  std_logic;
         Q           :out std_logic);
	end component;

signal data_temp, enable_temp, clock_temp: std_logic:='0';

	begin
	    
---  number1 
   process
       begin
       data_temp <= '1'; wait for 123 ns;
       data_temp <= '0'; wait for 56 ns;   
   end process;
   
---  number1 
   process
       begin
       clock_temp <= '1'; wait for 10 ns;
       clock_temp <= '0'; wait for 10 ns;   
   end process;
 
---  enable_test_sipo
---   process
---          begin
---          enable_temp <= '1'; wait for 200 ns;
---          enable_temp <= '0'; wait for 60 ns;   
---      end process;

--- enable_test_sipo_pipo
   process
       begin
       enable_temp <= '1'; wait for 3000 ns;
       enable_temp <= '0'; wait for 150 ns;   
   end process;

DFF_data: flip_flop_D port map(data_temp, clock_temp, '1', data);
DFF_enable: flip_flop_D port map(enable_temp, clock_temp, '1', enable);

clock <= clock_temp;

end signal_generator_behavior;