LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
--use ieee.numeric_std.all;

ENTITY alu IS
PORT(
	mux1, mux2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	alu_out    : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	sel_I      : IN STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END alu;

ARCHITECTURE arch OF alu IS
BEGIN
	PROCESS (sel_I)
	BEGIN
		CASE(sel_I)IS
		  WHEN "000" => alu_out <= mux1+mux2;	  --SOMA
		  WHEN "001" => alu_out <= mux1-mux2;	  --SUBTRAÇAO
		  WHEN "010" => alu_out <= mux1 AND mux2; --AND
		  WHEN "011" => alu_out <= mux1 OR mux2;  --OR
		  WHEN "100" => alu_out <= NOT mux2; 	  --NOT
		  WHEN "101" => alu_out <= mux1 XOR mux2; --XOR
		  WHEN OTHERS => alu_out <= "0000000000000000";
	END CASE;
	END PROCESS;
END arch;
		  
		