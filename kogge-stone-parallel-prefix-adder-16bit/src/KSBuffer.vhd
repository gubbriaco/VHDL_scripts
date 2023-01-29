library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity KSBuffer is
	port(
		pi, gi : in std_logic;
		p, g : out std_logic
	);
end KSBuffer;


architecture Behavioral of KSBuffer is

	begin
	
		p <= pi;
		g <= gi;


end Behavioral;
