library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity FSM is 
	generic ( Nb : integer);
	port(
		Clk		: in std_logic; 
		nRst	: in std_logic; 
		X		: in std_logic; 
		Y1		: out std_logic;
		Y2		: out std_logic;
		Y3		: out std_logic;
		Y4		: out std_logic;
		Y5		: out std_logic;
		Y6		: out std_logic;
		Y7		: out std_logic;
		Y8		: out std_logic; 
		Y9		: out std_logic; 
		Y10		: out std_logic 
	);
end entity;

architecture FSM1 of FSM is

	--Enumerazione 
	type t_State is (S, S1, S0, S11, S10, S01, S00, S_RX, S_ERR, S_COM, S_SOT, S_C2, S_SOM, S_TX, S_StB);
	
	signal State : t_State;
	
	--Counter
	signal Counter : integer range 0 to 5 * Nb;
begin	

	process(Clk) is
	begin
		if rising_edge(Clk) then
			--Reset premuto, torno allo stato di partenza
			if nRst = '0' then
				State 	<= S_StB; 
				Counter <= 0;
				Y1		<= '0';
				Y2		<= '0';
				Y3		<= '0';
				Y4		<= '0';
				Y5		<= '0';
				Y6		<= '0';
				Y7		<= '0';
				Y8		<= '1';
				Y9		<= '0';
				Y10		<= '0';
			else
				--Default Value
				Y1		<= '0';
				Y2		<= '0';
				Y3		<= '0';
				Y4		<= '0';
				Y5		<= '0';
				Y6		<= '0';
				Y7		<= '0';
				Y8		<= '0';
				Y9		<= '0';
				Y10		<= '0';
				
				if Counter > 4 * Nb then
					Counter <= 0;
				end if;
				
				Counter <= Counter + 1;
				
				
				case State is
				--	Stato Iniziale, ci entro solo quando resetto
					when S =>
						if X = '0' then
							State <= S0;
						else
							State <= S1;
						end if;	
						
				-- Gestione Secondo bit	
					when S0 =>
						if X = '0' then
							State <= S00;
						else
							State <= S01;
						end if;	
						
					when S1 =>
						if X = '0' then
							State <= S10;
						else
							State <= S11;
						end if;
					
				-- Gestione Terzo Bit 	
					when S00 =>
						Counter <= 0;
						
						if X = '0' then
							State 	<= S_StB; 	--S000
							Y8		<= '1';
						else
							State 	<= S_TX;  --S001
							Y7		<= '1';
						end if;
					
					when S01 =>
						Counter <= 0;
						
						if X = '0' then
							State 	<= S_SOM; 	--S010
							Y6		<= '1';
						else
							State 	<= S_C2;  --S011
							Y5		<= '1';
						end if;
						
					when S10 =>
						Counter <= 0;
						
						if X = '0' then
							State 	<= S_SOT; 	--S100
							Y4		<= '1';
						else
							State 	<= S_COM;  --S101
							Y3		<= '1';
						end if;
					
					when S11 =>
						Counter <= 0;
						
						if X = '0' then
							State 	<= S_ERR; 	--S110
							Y2		<= '1';
						else
							State 	<= S_RX;  --S111
							Y1		<= '1';
						end if;		
						
				-- Gestione Operazione	

					when S_RX =>						
						if Counter > ( 2 * Nb ) - 2 then
								State 	<= S; 	--S0
						else
							if Counter >  Nb - 2 then
								Y9 <= '1';
							else
								Y1 <= '1';
							end if;
						end if;
					
					when S_ERR =>
						Y2 		<= '1';
						State 	<= S_ERR; 					
						Counter <= 0;
						
					when S_COM =>					
						if Counter > 1 then
							if X = '0' then
								State 	<= S0; 	--S0
							else
								State 	<= S1;  --S1
							end if;
						else
							if Counter = 0 then
									Y3 <= '1';
								else
									Y10 <= '1';
								end if;
						end if;
				
					when S_SOT =>
							if Counter > 1 then	
								if X = '0' then
									State 	<= S0; 	--S0
								else
									State 	<= S1;  --S1
								end if;	
							else
								if Counter = 0 then
									Y4 <= '1';
								else
									Y10 <= '1';
								end if;
							
								
							end if;				
					when S_C2 =>						
							if Counter > 1 then
								if X = '0' then
									State 	<= S0; 	--S0
								else
									State 	<= S1;  --S1
								end if;
							else
								if Counter = 0 then
									Y5 <= '1';
								else
									Y10 <= '1';
								end if;
							end if;					
					
					when S_SOM =>
							if Counter > 1 then	
								if X = '0' then
									State 	<= S0; 	--S0
								else
									State 	<= S1;  --S1
								end if;	
							else
								if Counter = 0 then
									Y6 <= '1';
								else
									Y10 <= '1';
								end if;
							end if;	
					when S_TX =>							
							if Counter > ( 2 * Nb ) - 1 then
								if X = '0' then
									State 	<= S0; 	--S0
								else
									State 	<= S1;  --S1
								end if;
							else
								Y10 <= '1';				
							end if;
							
					when S_StB =>							
							if X = '0' then
								State 	<= S0; 	--S0
							else
								State 	<= S1;  --S1
							end if;							
				end case;
			end if;
		end if;
	end process;

end architecture;