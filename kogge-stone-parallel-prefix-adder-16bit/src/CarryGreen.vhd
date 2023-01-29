library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- gg4im1 := gg4(i-1)
entity CarryGreen is
	port(
		gg4im1, pi : in std_logic;
		si : out std_logic
	);
end CarryGreen;


architecture Behavioral of CarryGreen is

	begin

		si <= gg4im1 xor pi;
		

end Behavioral;
