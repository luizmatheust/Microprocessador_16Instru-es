LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY registrador8 IS
PORT(
		d : IN std_logic_vector (7 DOWNTO 0);
		q : OUT std_logic_vector (7 DOWNTO 0);
		clr,clk,ld : IN std_logic
);
END registrador8;

ARCHITECTURE arch OF registrador8 IS
BEGIN
	PROCESS (clk, clr, ld)
	BEGIN
	IF(clr = '1') THEN q<= x"00";

	ELSIF(RISING_EDGE(clk) AND ld = '1') THEN q <= d; 
	
	END IF;
	END PROCESS;
END arch;