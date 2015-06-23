-- Librerie utilizzate

library IEEE;
use IEEE.std_logic_1164.all;	   

entity interleaver_tb is
	
end interleaver_tb;	   

-- Dichiarazione dell'entità

architecture interleaver_test of interleaver_tb is
component interleaver
	generic (
		N : INTEGER := 1024			-- lunghezza interleaver
		);	
	port (
		Xin		: in std_logic_vector(N-1 downto 0);	-- ingresso
		Xout 	: out std_logic_vector(N-1 downto 0);	-- uscita
		clk		: in std_logic;							-- segnale di clock
		reset	: in std_logic							-- segnale di reset
		);
end component;	

-----------------------------------------------------

constant N 			: INTEGER := 1024;		-- Bus Width
constant MckPer 	: TIME 	  := 200 ns;	-- Master Clock Period
constant TestLen 	: INTEGER := 100;		-- No. of Count (MckPer/2) for test	
	
-- INPUT SIGNALS

signal clk 		: std_logic := '0'; 
signal reset	: std_logic	:= '0';
signal Xin		: std_logic_vector(N-1 downto 0);

-- OUTPUT SIGNALS

signal Xout		: std_logic_vector(N-1 downto 0);

signal clk_cycle : INTEGER;
signal Testing 	 : BOOLEAN := True;		 

-----------------------------------------------------

begin
	
	I : interleaver generic map (N => 1024)	 
	port map (Xin, Xout, clk, reset); 			

-- Generates clk

	clk <= not clk after MckPer/2 when Testing else '0'; 

-- Runs simulation for TestLen cycles; 
	
-- Ogni 5 cicli di clock viene variato il dato in ingresso
-- I valori immessi hanno tutti i bit settati a 0 escluso uno settato a 1 (per semplicità)
-- Il bit settato varia di volta in volta

	Test_Proc : process(clk)
		variable count : INTEGER := 0;
	begin
		clk_cycle <= (count + 1) / 2;
		case count is
			when 0  =>	for I in 0 to N-1 loop
							Xin(I) <= '0';
						end loop;
						reset <= '1';				  -- reset=1 ==> Xout=0
			when 1  =>	reset <= '0';
			when 10 => 	for I in 0 to N-1 loop
							Xin(I) <= '0';
						end loop;
						Xin(45) <= '1';				  -- Xin(45)=1 ==> Xout(0)=1
			when 20 =>	for I in 0 to N-1 loop
							Xin(I) <= '0';
						end loop;
						Xin(48) <= '1';				  -- Xin(48)=1 ==> Xout(1)=1
			when 30 =>	for I in 0 to N-1 loop
							Xin(I) <= '0';
						end loop;
						Xin(51) <= '1';				  -- Xin(51)=1 ==> Xout(2)=1
			when 40 =>	for I in 0 to N-1 loop
							Xin(I) <= '0';
						end loop;
						Xin(54) <= '1';				  -- Xin(54)=1 ==> Xout(3)=1
			when 50 =>	for I in 0 to N-1 loop
							Xin(I) <= '0';
						end loop;
						Xin(57) <= '1';				  -- Xin(57)=1 ==> Xout(4)=1
			when 60 =>	for I in 0 to N-1 loop
							Xin(I) <= '0';
						end loop;
						Xin(60) <= '1';				  -- Xin(60)=1 ==> Xout(5)=1
			when 70 =>	for I in 0 to N-1 loop
							Xin(I) <= '0';
						end loop;
						Xin(63) <= '1';				  -- Xin(63)=1 ==> Xout(6)=1
			when 80 =>	for I in 0 to N-1 loop
							Xin(I) <= '0';
						end loop;
						Xin(66) <= '1';				  -- Xin(66)=1 ==> Xout(7)=1
			when 90 =>	for I in 0 to N-1 loop
							Xin(I) <= '0';
						end loop;
						Xin(69) <= '1';				  -- Xin(69)=1 ==> Xout(8)=1
			when (TestLen-1) =>	Testing <= False;	  -- fine test
			when OTHERS => NULL;		
		end case;			
		
		count := count + 1;
	
	end process Test_Proc;
	
end interleaver_test;