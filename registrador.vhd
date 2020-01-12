LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY registrador IS
PORT(
		d : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		q : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
		clr,clk,ld : IN STD_LOGIC
);
END registrador;

ARCHITECTURE arch OF registrador IS
BEGIN
	PROCESS (clk, clr, ld)
	BEGIN
	IF(clr = '1') THEN q<= x"0000";

	ELSIF(RISING_EDGE(clk) AND ld = '1') THEN q <= d; 
	
	END IF;
	END PROCESS;
END arch;
