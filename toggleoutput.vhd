library ieee;
use ieee.std_logic_1164.all;

package toggleoutput is
	component togglebit
		port(	RESET : in std_logic;
				S : in std_logic;
				Y : buffer std_logic;
				CLK : in std_logic
				);
	end component;
end package;

library ieee;
use IEEE.STD_LOGIC_1164.ALL;

entity togglebit is
    Port ( RESET : in std_logic;
			  S : in std_logic;
           Y : buffer std_logic;
           CLK : in std_logic
			  );
end togglebit;

architecture behavioral of togglebit is
begin

process(CLK, RESET, S)
begin
	if RESET = '0' then
		Y <= '0';
	else
		if S = '1' then
			Y <= '1';
		else
			if rising_edge(CLK) then
				Y <= not Y;
			end if;
		end if;
	end if;
end process;

end behavioral;
