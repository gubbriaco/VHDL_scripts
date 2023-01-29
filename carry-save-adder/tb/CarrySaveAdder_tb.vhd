library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;


entity CarrySaveAdder_tb is

end CarrySaveAdder_tb;


architecture Behavioral of CarrySaveAdder_tb is

	component CarrySaveAdder is
		generic(n : integer);
		port(
			A, B, C : in std_logic_vector(n-1 downto 0);
			Somma : out std_logic_vector(n+1 downto 0)
		);
	end component;


	signal Iclk : std_logic := '0';
	signal Ia, Ib, Ic : std_logic_vector(7 downto 0) := (others=>'0');
    signal Oresult : std_logic_vector(9 downto 0);
	constant T_CLK : Time := 20 ns;
	signal TrueResult, Error : integer;


	begin
		
		process
            begin
                wait for T_CLK/2;
                Iclk <= not Iclk;
        end process;
		
		
		UUT : CarrySaveAdder generic map(8) port map(Ia, Ib, Ic, Oresult);
		
		process
            begin
				wait for 2*T_CLK + 100 ns;
                for va in -(2**(8-1)) to (2**(8-1)-1) loop
                    Ia <= conv_std_logic_vector( va, 8 );
                    for vb in -(2**(8-1)) to (2**(8-1)-1) loop   
                        Ib <= conv_std_logic_vector( vb, 8 );
						for vc in -(2**(8-1)) to (2**(8-1)-1) loop   
							Ic <= conv_std_logic_vector( vc, 8 );
							
							TrueResult <= va+vb+vc;
							Error <= TrueResult - conv_integer(signed(OResult));
							
							wait for T_CLK;
						end loop;
                    end loop;
                end loop;
        end process;
	

end Behavioral;
