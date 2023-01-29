library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- pim1 := pi-1
-- gim1 := gi-1
entity CarryYellow is
	port(
		pi, pim1, gi, gim1 : in std_logic;
		ppi, ggi : out std_logic
	);
end CarryYellow;


architecture Behavioral of CarryYellow is

	begin

		ppi <= pi and pim1;
		ggi <= (pi and gim1) or gi;

end Behavioral;
