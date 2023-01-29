library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;


entity KSPPAdderSS_tb is
end KSPPAdderSS_tb;


architecture Behavioral of KSPPAdderSS_tb is

	component KSPPAdderSS is
		generic( n : integer );
		port(
			A, B : in std_logic_vector(n-1 downto 0);
			Somma : out std_logic_vector(n downto 0)
		);
	end component;
	
	
	signal Iclk : std_logic := '0';
	
	signal IA, IB : std_logic_vector(16-1 downto 0) := ( others => '0' );
	signal OS : std_logic_vector(16 downto 0);
	signal cout : std_logic;
	
	signal TrueResult, Error : integer;
	
	constant T_CLK : Time := 20 ns;

	
	begin

		UUT : KSPPAdderSS generic map(16) port map(IA, IB, OS);
		
		process
            begin
                wait for T_CLK/2;
                Iclk <= not Iclk;
        end process;
		
		
		-- simulazione esaustiva
		process
			begin
				wait for 2*T_CLK + 100 ns;
				for va in -(2**(16-1)) to (2**(16-1)-1) loop
					Ia <= conv_std_logic_vector( va, 16 );
					for vb in -(2**(16-1)) to (2**(16-1)-1) loop   
						Ib <= conv_std_logic_vector( vb, 16 );
						cout <= OS(16);
						TrueResult <= va + vb;
						Error <= TrueResult - conv_integer( signed( OS ) );
						wait for T_CLK;
					end loop;
					wait for T_CLK;
				end loop;
		end process;
		
	

end Behavioral;
