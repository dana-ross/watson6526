library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
package Count is
	component Counter16bit
		port(	RESET : in std_logic;
				A : in std_logic_vector(7 downto 0);				
				YLo : out std_logic_vector (7 downto 0);
				YHi : out std_logic_vector (7 downto 0);
				WLo : in std_logic;
				WHi : in std_logic;
				UFlow : out std_logic;
				LOAD : in std_logic;
				CLK : in std_logic
				);
	end component;
	component Counter3bitNoDB
		port ( RESET : in std_logic;
				 CLK : in std_logic;
				 Y : out std_logic_vector(2 downto 0)
			  );
	end component;
end package;

library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
entity Counter16bit is
		port(	RESET : in std_logic;
				A : in std_logic_vector(7 downto 0);				
				YLo : out std_logic_vector (7 downto 0);
				YHi : out std_logic_vector (7 downto 0);
				WLo : in std_logic;
				WHi : in std_logic;
				UFlow : out std_logic;
				LOAD : in std_logic;
				CLK : in std_logic
				);
end Counter16bit;

architecture behavioral of Counter16bit is
	signal Counter : std_logic_vector (15 downto 0);
	signal Latch_Lo : std_logic_vector(7 downto 0);
	signal Latch_Hi : std_logic_vector(7 downto 0);
begin

UFlow <= '1' when Counter = "0000000000000000" else '0';
YHi <= Counter(15 downto 8);
YLo <= Counter(7 downto 0);

process(CLK, LOAD, Latch_Hi, Latch_Lo, RESET)
begin
	if RESET = '0' then
		Counter <= "0000000000000000";
	else
		if LOAD = '1' then
			Counter(15 downto 8) <= Latch_Hi;
		 	Counter(7 downto 0)  <= Latch_Lo;
		else
			if rising_edge(CLK) then
				Counter <= Counter - '1';
			end if;
		end if;
	end if;
end process;

process(RESET, WLo, A)
begin
	if RESET = '0' then
		Latch_Lo <= "00000000";
	else
		if rising_edge(WLo) then
			Latch_Lo <= A;
		end if;
	end if;
end process;

process(RESET, WHi, A)
begin
	if RESET = '0' then
		Latch_Hi <= "00000000";
	else
		if rising_edge(WHi) then
			Latch_Hi <= A;
		end if;
	end if;
end process;

end behavioral;

library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity Counter3bitNoDB is
		port ( RESET : in std_logic;
				 CLK : in std_logic;
				 Y : out std_logic_vector(2 downto 0)
			  );
end Counter3bitNoDB;

architecture behavioral of Counter3bitNoDB is
	signal REG : std_logic_vector(2 downto 0);
begin
	process(RESET, CLK)
	begin
		if RESET = '0' then
			REG <= "000";
		else
			if rising_edge(CLK) then
				REG <= REG - 1;
			end if;
		end if;
	end process;
	Y <= REG;
end behavioral;
