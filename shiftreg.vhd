library ieee;
use ieee.std_logic_1164.all;

package ShiftReg is
	component ShiftRegister is
		port(	RESET : in std_logic;
				A : in std_logic;
				Y : out std_logic;
				CLK : in std_logic
				);
	end component;
end package;

library ieee;
use IEEE.STD_LOGIC_1164.ALL;

entity Register1bit is
    Port ( RESET : in std_logic;
	 		  A : in std_logic; 
           Y : out std_logic;
           CLK : in std_logic
			  );
end Register1bit;

architecture behavioral of Register1bit is
begin

process(CLK, RESET)
begin
	if RESET = '0' then
		Y <= '0';
	else
		if rising_edge(CLK) then
			Y <= A;
		end if;
	end if;
end process;

end behavioral;
