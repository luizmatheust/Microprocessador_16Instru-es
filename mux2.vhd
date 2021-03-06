LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux2 IS
PORT(
		a0, a1, a2, a3 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		m : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		sel_I: IN STD_LOGIC_VECTOR(1 downto 0)
);
END mux2;

ARCHITECTURE arch OF mux2 IS
BEGIN
		WITH sel_I SELECT
		m <= 	a0 WHEN "00",
				a1 WHEN "01",
				a2 WHEN "10",
				a3 WHEN "11";
END arch;