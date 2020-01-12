LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux8 IS
PORT(
		s_0, s_1, s_2, s_3, s_4, s_5, s_6, s_7 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		m : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		sel_I: IN STD_LOGIC_VECTOR(2 DOWNTO 0)
);
END mux8;

ARCHITECTURE arch OF mux8 IS
BEGIN
	WITH sel_I(2 DOWNTO 0) SELECT
		m <= s_0 WHEN "000",
			  s_1 WHEN "001",
			  s_2 WHEN "010",
			  s_3 WHEN "011",
			  s_4 WHEN "100",
			  s_5 WHEN "101",
			  s_6 WHEN "110",
			  s_7 WHEN OTHERS;
END arch;