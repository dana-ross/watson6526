library ieee;
use ieee.std_logic_1164.all;
library work;
use work.reg.all;

package IntReg is
	component interruptreg
		port(	RESET : in std_logic;
				A : in std_logic_vector(7 downto 0);
				Y : out std_logic_vector(7 downto 0);
				OE : in std_logic;
				TA_U : in std_logic;
				TB_U : in std_logic;
				TOD_A : in std_logic;
				SP_E : in std_logic;
				FLAG : in std_logic;
				CLK : in std_logic
				);
	end component;
end package;

library ieee;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.reg.all;

entity interruptreg is
		port(	RESET : in std_logic;
				A : in std_logic_vector(7 downto 0);
				Y : out std_logic_vector(7 downto 0);
				OE : in std_logic;
				TA_U : in std_logic;
				TB_U : in std_logic;
				TOD_A : in std_logic;
				SP_E : in std_logic;
				FLAG : in std_logic;
				CLK : in std_logic
				);
end interruptreg;

architecture behavioral of interruptreg is
	signal Latch : std_logic_vector(6 downto 0);
	signal Reg : std_logic_vector(6 downto 0);
	signal NotFlag : std_logic;
	signal NotSPE : std_logic;
begin

NotFlag <= not FLAG;
NotSPE <= not SP_E;

process(RESET, A, CLK, Latch)
begin
	if RESET = '0' then
		Latch <= "0000000";
	else
		if rising_edge(CLK) then
			for i in 6 downto 0 loop
				Latch(i) <= (Latch(i) and not A(i)) or (A(i) and A(7));
			end loop;
		end if;
	end if;
end process;

IReg0 : register1bit PORT MAP(RESET, TA_U, Reg(0), TA_U);
IReg1 : register1bit PORT MAP(RESET, TB_U, Reg(1), TB_U);
IReg2 : register1bit PORT MAP(RESET, TOD_A, Reg(2), TOD_A);
IReg3 : register1bit PORT MAP(RESET, NotSPE, Reg(3), SP_E);
IReg4 : register1bit PORT MAP(RESET, NotFlag, Reg(4), NotFlag);
Y(4 downto 0) <= Reg(4 downto 0);
Y(6 downto 5) <= "00";
Y(7) <= (Reg(0) and Latch(0)) or (Reg(1) and Latch(1)) or (Reg(2) and Latch(2)) or (Reg(3) and Latch(3)) or (Reg(4) and Latch(4));

end behavioral;
