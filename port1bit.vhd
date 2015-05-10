library ieee;
use ieee.std_logic_1164.all;

package Ciaport is
	component Port1bit
		port(	RESET : in std_logic;
				A : in std_logic;
				OE : in std_logic;
				CLK : in std_logic;
				IO : inout std_logic
				);
	end component;
end package;

library ieee;
use IEEE.STD_LOGIC_1164.ALL;

entity Port1bit is
    Port ( RESET : in std_logic;
	 		  A : in std_logic;
           OE : in std_logic;
           CLK : in std_logic;
			  IO : inout std_logic
			  );
end Port1bit;

architecture behavioral of Port1bit is
	signal R : std_logic;
begin

IO <= R when OE = '1' else 'Z';

process(CLK, RESET)
begin
	if RESET = '0' then
		R <= '0';
	else
		if rising_edge(CLK) then
			R <= A;
		end if;
	end if;
end process;

end behavioral;
