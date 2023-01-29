library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- Kogge Stone Parallel-Prefix Adder  (signed + signed)
entity KSPPAdderSS is
	-- costrutto generic utilizzato solo per una semplicita' a livello implementativo
	-- deve essere impostato a 16 altrimenti non funziona correttamente
	generic( n : integer := 16 );
	port(
		A, B : in std_logic_vector(n-1 downto 0);
		Somma : out std_logic_vector(n downto 0)
	);
end KSPPAdderSS;


architecture Behavioral of KSPPAdderSS is

	component CarryRed is
		port(
			ai, bi : in std_logic;
			pi, gi : out std_logic 
		);
	end component;
	
	component CarryYellow is
		port(
			pi, pim1, gi, gim1 : in std_logic;
			ppi, ggi : out std_logic
		);
	end component;
	
	component CarryGreen is
		port(
			gg4im1, pi : in std_logic;
			si : out std_logic
		);
	end component;
	
	component KSBuffer is
		port(
			pi, gi : in std_logic;
			p, g : out std_logic
		);
	end component;



	-- vettori di propagate e generate per le uscite dei CarryRed
	signal P, G : std_logic_vector(n-1 downto 0);
	-- vettori di propagate e generate per le uscite dei CarryYellow e dei KSBuffer ai livelli corrispondenti
	signal PP1, GG1, PP2, GG2, PP3, GG3, PP4, GG4 : std_logic_vector(n-1 downto 0);
	

	begin
	
		-- LEGENDA
			-- PP1 : vettore di propagate al livello 1 (cioe' utilizzato per le uscite dei CarryYellow e dei KSBuffer)
			-- GG1 : vettore di propagate al livello 1 (cioe' utilizzato per le uscite dei CarryYellow e dei KSBuffer)
			-- CarryRedPES : CarryRed precedenti all'estensione del segno
			-- CarryRedES : CarryRed che effettua l'estensione del segno
			-- KSBuffer_1_0 : KSBuffer al livello 1 in posizione 0
			


		-- ISTANZIAZIONE DEI CARRYRED INIZIALE
			carry_red_generate : for i in 0 to n-1 generate
				KSCarryRed : CarryRed port map( A(i), B(i), P(i), G(i) );
			end generate carry_red_generate;
		
		
		-- LIVELLO 1 DEL KSPPA
			-- istanziazione del KSBuffer in corrispondenza del primo CarryRed
			KSBuffer_1_0 : KSBuffer port map( P(0), G(0), PP1(0), GG1(0) );
			-- istanziazione dei CarryYellow
			carry_yellow_livello1_generate : for i in 1 to n-1 generate
				KSCarryYellowLivello1 : CarryYellow port map( P(i), P(i-1), G(i), G(i-1), PP1(i), GG1(i) );
			end generate carry_yellow_livello1_generate;
			
		
		
		-- LIVELLO 2 DEL KSPPA
			-- istanziazione dei KSBuffer
			KSBuffer_2_0 : KSBuffer port map( PP1(0), GG1(0), PP2(0), GG2(0) );
			KSBuffer_2_1 : KSBuffer port map( PP1(1), GG1(1), PP2(1), GG2(1) );
			-- istanziazione dei CarryYellow
			carry_yellow_livello2_generate : for i in 2 to n-1 generate
				KSCarryYellowLivello2 : CarryYellow port map( PP1(i), PP1(i-2), GG1(i), GG1(i-2), PP2(i), GG2(i) );
			end generate carry_yellow_livello2_generate;
			
		
		
		-- LIVELLO 3 DEL KSPPA
			-- istanziazione dei KSBuffer
			KSBuffer_3_0 : KSBuffer port map( PP2(0), GG2(0), PP3(0), GG3(0) );
			KSBuffer_3_1 : KSBuffer port map( PP2(1), GG2(1), PP3(1), GG3(1) );
			KSBuffer_3_2 : KSBuffer port map( PP2(2), GG2(2), PP3(2), GG3(2) );
			KSBuffer_3_3 : KSBuffer port map( PP2(3), GG2(3), PP3(3), GG3(3) );
			-- istanziazione dei CarryYellow
			carry_yellow_livello3_generate : for i in 4 to n-1 generate
				KSCarryYellowLivello3 : CarryYellow port map( PP2(i), PP2(i-4), GG2(i), GG2(i-4), PP3(i), GG3(i) );
			end generate carry_yellow_livello3_generate;
		
		
		
		-- LIVELLO 4 DEL KSPPA
			-- istanziazione dei KSBuffer
			KSBuffer_4_0 : KSBuffer port map( PP3(0), GG3(0), PP4(0), GG4(0) );
			KSBuffer_4_1 : KSBuffer port map( PP3(1), GG3(1), PP4(1), GG4(1) );
			KSBuffer_4_2 : KSBuffer port map( PP3(2), GG3(2), PP4(2), GG4(2) );
			KSBuffer_4_3 : KSBuffer port map( PP3(3), GG3(3), PP4(3), GG4(3) );
			KSBuffer_4_4 : KSBuffer port map( PP3(4), GG3(4), PP4(4), GG4(4) );
			KSBuffer_4_5 : KSBuffer port map( PP3(5), GG3(5), PP4(5), GG4(5) );
			KSBuffer_4_6 : KSBuffer port map( PP3(6), GG3(6), PP4(6), GG4(6) );
			KSBuffer_4_7 : KSBuffer port map( PP3(7), GG3(7), PP4(7), GG4(7) );
			-- istanziazione dei CarryYellow
			carry_yellow_livello4_generate : for i in 8 to n-1 generate
				KSCarryYellowLivello4 : CarryYellow port map( PP3(i), PP3(i-8), GG3(i), GG3(i-8), PP4(i), GG4(i) );
			end generate carry_yellow_livello4_generate;
		
		
		
		-- ISTANZIAZIONE DEI CARRYGREEN
		Somma(0) <= P(0);
		carry_green_generate : for i in 1 to n-1 generate
			KSCarryGreen : CarryGreen port map( GG4(i-1), P(i), Somma(i) );
		end generate carry_green_generate;
		Somma(n) <= GG4(n-1) when (A(15)='1' and B(15)='1') else
					(GG4(14) xor P(15)) when (A(15)='0' and B(15)='1') else
					(GG4(14) xor P(15)) when (A(15)='1' and B(15)='0') else
					GG4(n-1) and (GG4(14) xor P(15)) when (A(15)='0' and B(15)='0') else
					'X';
		

end Behavioral;
