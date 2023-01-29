library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CarryRed is
	port(
		ai, bi : in std_logic;
		pi, gi : out std_logic 
	);
end CarryRed;


architecture Behavioral of CarryRed is

	begin

		pi <= ai xor bi;
		gi <= ai and bi;

end Behavioral;
