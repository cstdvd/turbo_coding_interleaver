-- Librerie utilizzate

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

-- Dichiarazione dell'entità

entity interleaver is
	generic (
		N : INTEGER := 1024		   	-- lunghezza interleaver
		);	
	port (
		Xin		: in std_logic_vector(N-1 downto 0);	-- ingresso
		Xout 	: out std_logic_vector(N-1 downto 0);	-- uscita
		clk		: in std_logic;							-- segnale di clock
		reset	: in std_logic							-- segnale di reset
		);
end interleaver;

-- Comportamento  
-- Ad ogni ciclo di clock viene assegnato un valore all'uscita
-- in base alla relazione implementata dall'interleaver.
-- Se reset è settato (a livello alto) l'uscita è forzata a 0

architecture BEHAVIOURAL of interleaver is
begin	 
	proc : process( clk, reset )
	begin
		if ( reset = '1' ) then			   -- uscita a 0 con reset a 1
			for I in 0 to N-1 loop
		  		Xout(I) <= '0';
			end loop;
		else if ( clk = '1' ) then		   
				for I in 0 to N-1 loop
		  			Xout(I) <= Xin((45 + I*3) mod N);	  -- relazione implementata
				end loop;		
			end if;
		end if;
	end process;
end BEHAVIOURAL;