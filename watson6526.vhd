library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.ciaport.all;
use work.reg.all;
use work.count.all;
use work.intreg.all;
use work.toggleoutput.all;

package W6526 is
	component Watson6526
    Port ( 	PA : inout std_logic_vector(7 downto 0);
	 			PB : inout std_logic_vector(7 downto 0);
	 			DB : inout std_logic_vector(7 downto 0);
				RS : in std_logic_vector(3 downto 0);
				CLK : in std_logic;
				CNT : inout std_logic;
				CS : in std_logic;
				RW : in std_logic;
				FLAG : in std_logic;
				IRQ : out std_logic;
				SP : inout std_logic;
				RESET : in std_logic
			);
	end component;
end W6526;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.ciaport.all;
use work.reg.all;
use work.count.all;
use work.intreg.all;
use work.toggleoutput.all;

entity Watson6526 is
    Port ( 	PA : inout std_logic_vector(7 downto 0);
	 			PB : inout std_logic_vector(7 downto 0);
	 			DB : inout std_logic_vector(7 downto 0);
				RS : in std_logic_vector(3 downto 0);
				CLK : in std_logic;
				CNT : inout std_logic;
				CS : in std_logic;
				RW : in std_logic;
				FLAG : in std_logic;
				IRQ : out std_logic;
				SP : inout std_logic;
				RESET : in std_logic
			);

end Watson6526;

architecture behavioral of Watson6526 is
	 signal Read_Enable : std_logic;
	 signal Write_Enable : std_logic;

	 signal Register_2 : std_logic_vector(7 downto 0);
	 signal Register_3 : std_logic_vector(7 downto 0);
	 signal Register_4 : std_logic_vector(7 downto 0);
	 signal Register_5 : std_logic_vector(7 downto 0);
	 signal Register_6 : std_logic_vector(7 downto 0);
	 signal Register_7 : std_logic_vector(7 downto 0);
	 signal Register_C : std_logic_vector(7 downto 0);
	 signal Register_D : std_logic_vector(7 downto 0);
	 signal Register_E : std_logic_vector(7 downto 0);
	 signal Register_F : std_logic_vector(7 downto 0);

	 signal Register_0_Read : std_logic;
	 signal Register_1_Read : std_logic;
	 signal Register_2_Read : std_logic;
	 signal Register_3_Read : std_logic;
	 signal Register_4_Read : std_logic;
	 signal Register_5_Read : std_logic;
	 signal Register_6_Read : std_logic;
	 signal Register_7_Read : std_logic;
	 signal Register_8_Read : std_logic;
	 signal Register_9_Read : std_logic;
	 signal Register_A_Read : std_logic;
	 signal Register_B_Read : std_logic;
	 signal Register_C_Read : std_logic;
	 signal Register_D_Read : std_logic;
	 signal Register_E_Read : std_logic;
	 signal Register_F_Read : std_logic;

	 signal Register_0_Write : std_logic;
	 signal Register_1_Write : std_logic;
	 signal Register_2_Write : std_logic;
	 signal Register_3_Write : std_logic;
	 signal Register_4_Write : std_logic;
	 signal Register_5_Write : std_logic;
	 signal Register_6_Write : std_logic;
	 signal Register_7_Write : std_logic;
	 signal Register_8_Write : std_logic;
	 signal Register_9_Write : std_logic;
	 signal Register_A_Write : std_logic;
	 signal Register_B_Write : std_logic;
	 signal Register_C_Write : std_logic;
	 signal Register_D_Write : std_logic;
	 signal Register_E_Write : std_logic;
	 signal Register_F_Write : std_logic;

	 signal TA_Trigger : std_logic;
	 signal TA_Load : std_logic;
	 signal TA_Underflow : std_logic;
	 signal TA_Startstop : std_logic;
	 signal TA_Output : std_logic;
	 signal TA_Pulse : std_logic;
	 signal TA_Pulse_Counter : std_logic_vector(1 downto 0);
	 signal TA_ToggleSet_Counter : std_logic_vector(1 downto 0);
	 signal TA_ToggleSet : std_logic;
	 signal TA_Toggle : std_logic;

	 signal TB_Trigger : std_logic;
	 signal TB_Load : std_logic;
	 signal TB_Underflow : std_logic;
	 signal TB_Startstop : std_logic;
	 signal TB_Output : std_logic;
	 signal TB_Pulse : std_logic;
	 signal TB_Pulse_Counter : std_logic_vector(1 downto 0);
	 signal TB_ToggleSet_Counter : std_logic_vector(1 downto 0);
	 signal TB_ToggleSet : std_logic;
	 signal TB_Toggle : std_logic;

	 signal SP_Counter : std_logic_vector(2 downto 0);
	 signal SP_Trigger : std_logic;
	 signal SP_Shift_Reg : std_logic_vector(7 downto 0);
	 signal RC_DB : std_logic_vector(7 downto 0);
	 signal RC_W : std_logic;

	 signal TOD_Alarm : std_logic;
	 signal SP_Fullempty : std_logic;

	 signal PB_LINE6, PB_LINE7 : std_logic;
	 signal PC_Waveform : std_logic_vector(1 downto 0);


begin

	Reg2:			for i in 7 downto 0 generate
						R2 : register1bit PORT MAP(RESET, DB(i), Register_2(i), Register_2_Write);
					end generate;

	Reg3:			for i in 7 downto 0 generate
						R3 : register1bit PORT MAP(RESET, DB(i), Register_3(i), Register_3_Write);
					end generate;

	GenPortA: 	for i in 7 downto 0 generate
						PORTA : port1bit PORT MAP(RESET, DB(i), Register_2(i), Register_0_Write, PA(i));			
					end generate;

	GenPortB:	for i in 5 downto 0 generate
						PORTB : port1bit PORT MAP(RESET, DB(i), Register_3(i), Register_1_Write, PB(i));
					end generate;
					PB7 : port1bit PORT MAP(RESET, DB(7), Register_3(7), Register_1_Write, PB_LINE7);
					PB6 : port1bit PORT MAP(RESET, DB(6), Register_3(6), Register_1_Write, PB_LINE6);
	PB(7) <= TA_Output when Register_F(1) = '1' else PB_LINE7;
	PB(6) <= TB_Output when Register_F(1) = '1' else PB_LINE6;

	TIMERA : counter16bit PORT MAP(RESET, DB, Register_4, Register_5, Register_4_Write, Register_5_Write, TA_Underflow, TA_LOAD, TA_Trigger);
	TIMERB : counter16bit PORT MAP(RESET, DB, Register_6, Register_7, Register_6_Write, Register_7_Write, TB_Underflow, TB_LOAD, TB_Trigger);

	TA_Trigger <= '1' when ((Register_E(5) = '0' and CLK = '1') or (Register_E(5) = '1' and CLK = '0')) and Register_E(0) = '1' else '0';
	TA_LOAD <= '1' when ((DB(4) and Register_E_Write) = '1') or (TA_Pulse = '1') or ((Register_5_Write = '1') and (Register_E(0) = '0')) else '0';
	TA_Startstop <= not(RESET and TA_Pulse);
	TAToggle : togglebit PORT MAP(RESET, TA_ToggleSet, TA_Toggle, TA_Pulse);
	process(RESET, CLK, TA_Underflow, TA_Pulse_Counter(0), Register_E(0))
	begin
		if RESET = '0' then
			TA_Pulse_Counter <= "00";
		else
			if rising_edge(CLK) then
				TA_Pulse_Counter <= TA_Pulse_Counter(0) & (TA_Underflow and Register_E(0));
			end if;
		end if;
	end process;
	TA_Pulse <= '1' when TA_Pulse_Counter = "10" else '0';
	process(RESET, CLK, Register_E(0), TA_ToggleSet_Counter(0))
	begin
		if RESET = '0' then
			TA_ToggleSet_Counter <= "00";
		else
			if rising_edge(CLK) then
				TA_ToggleSet_Counter <= TA_ToggleSet_Counter(0) & Register_E(0);
			end if;
		end if;
	end process;
	TA_ToggleSet <= '1' when TA_ToggleSet_Counter = "10" else '0';
	TA_Output <= TA_Pulse when Register_E(2) = '0' else TA_Toggle;

-- Timer B
	process(CLK, CNT, Register_F(0), Register_F(5), Register_F(6), TA_Underflow)
	begin
		if Register_F(0) = '1' then
			case Register_F(6 downto 5) is
				when "00" =>
					TB_Trigger <= CLK;
				when "01" =>
					TB_Trigger <= CNT;
				when "10" =>
					TB_Trigger <= TA_Underflow;
				when "11" =>
					TB_Trigger <= TA_Underflow and CNT;
				when others =>
					TB_Trigger <= 'X';
			 end case;
		else
			TB_Trigger <= '0';
		end if;
	end process;
	TB_LOAD <= '1' when ((DB(4) and Register_F_Write) = '1') or (TB_Underflow and Register_F(3)) = '1' else '0';

	TB_Startstop <= RESET and (TB_Underflow and not Register_F(3));
	TBToggle : togglebit PORT MAP(RESET, TB_ToggleSet, TB_Toggle, TB_Pulse);
	process(RESET, CLK, TB_Underflow, TB_Pulse_Counter(0))
	begin
		if RESET = '0' then
			TB_Pulse_Counter <= "00";
		else
			if rising_edge(CLK) then
				TB_Pulse_Counter <= TB_Pulse_Counter(0) & TB_Underflow;
			end if;
		end if;
	end process;
	TB_Pulse <= '1' when TB_Pulse_Counter = "10" else '0';
	process(RESET, CLK, Register_F(0), TB_ToggleSet_Counter(0))
	begin
		if RESET = '0' then
			TB_ToggleSet_Counter <= "00";
		else
			if rising_edge(CLK) then
				TB_ToggleSet_Counter <= TB_ToggleSet_Counter(0) & Register_F(0);
			end if;
		end if;
	end process;
	TB_ToggleSet <= '1' when TB_ToggleSet_Counter = "10" else '0';
	TB_Output <= TB_Pulse when Register_F(2) = '0' else TB_Toggle;

-- Control Regs
	GenCRAHI:		for i in 7 downto 5 generate
							CRA : register1bit PORT MAP(RESET, DB(i), Register_E(i), Register_E_Write);
						end generate;
	GenCRALO:		for i in 3 downto 1 generate
							CRA : register1bit PORT MAP(RESET, DB(i), Register_E(i), Register_E_Write);
						end generate;
						CRA_Bit0 : register1bit PORT MAP(TA_Startstop, DB(0), Register_E(0), Register_E_Write);						
						Register_E(4) <= '0';

	GenCRBHI:		for i in 7 downto 5 generate
							CRB : register1bit PORT MAP(RESET, DB(i), Register_F(i), Register_F_Write);
						end generate;
	GenCRBLO:		for i in 3 downto 1 generate
							CRB : register1bit PORT MAP(RESET, DB(i), Register_F(i), Register_F_Write);
						end generate;
						CRB_Bit0 : register1bit PORT MAP(TB_Startstop, DB(0), Register_F(0), Register_F_Write);
						Register_F(4) <= '0';

	IReg : interruptreg PORT MAP(RESET, DB, Register_D, Register_D_Read, TA_Underflow, TB_Underflow, TOD_Alarm, SP_Fullempty, FLAG, Register_D_Write);
	IRQ <= not(Register_D(7));

	Read_Enable <= '0' when (CS = '0') and (CLK = '1') and (RW = '1') else '1';
	Write_Enable <= '0' when (CS = '0') and (CLK = '1') and (RW = '0') else '1';

	Register_0_Read <= '0' when Read_Enable = '0' and RS = "0000" else '1';
	Register_1_Read <= '0' when Read_Enable = '0' and RS = "0001" else '1';
	Register_2_Read <= '0' when Read_Enable = '0' and RS = "0010" else '1';
	Register_3_Read <= '0' when Read_Enable = '0' and RS = "0011" else '1';
	Register_4_Read <= '0' when Read_Enable = '0' and RS = "0100" else '1';
	Register_5_Read <= '0' when Read_Enable = '0' and RS = "0101" else '1';
	Register_6_Read <= '0' when Read_Enable = '0' and RS = "0110" else '1';
	Register_7_Read <= '0' when Read_Enable = '0' and RS = "0111" else '1';
	Register_8_Read <= '0' when Read_Enable = '0' and RS = "1000" else '1';
	Register_9_Read <= '0' when Read_Enable = '0' and RS = "1001" else '1';
	Register_A_Read <= '0' when Read_Enable = '0' and RS = "1010" else '1';
	Register_B_Read <= '0' when Read_Enable = '0' and RS = "1011" else '1';
	Register_C_Read <= '0' when Read_Enable = '0' and RS = "1100" else '1';
	Register_D_Read <= '0' when Read_Enable = '0' and RS = "1101" else '1';
	Register_E_Read <= '0' when Read_Enable = '0' and RS = "1110" else '1';
	Register_F_Read <= '0' when Read_Enable = '0' and RS = "1111" else '1';

	DB <= PA when Register_0_Read = '0' else
			PB when Register_1_Read = '0' else
			Register_2 when Register_2_Read = '0' else
			Register_3 when Register_3_Read = '0' else
			Register_4 when Register_4_Read = '0' else
			Register_5 when Register_5_Read = '0' else
			Register_6 when Register_6_Read = '0' else
			Register_7 when Register_7_Read = '0' else
			Register_D when Register_D_Read = '0' else
			Register_E when Register_E_Read = '0' else
			Register_F when Register_F_Read = '0' else
			"ZZZZZZZZ";

	Register_0_Write <= '1' when Write_Enable = '0' and RS = "0000" else '0';
	Register_1_Write <= '1' when Write_Enable = '0' and RS = "0001" else '0';
	Register_2_Write <= '1' when Write_Enable = '0' and RS = "0010" else '0';
	Register_3_Write <= '1' when Write_Enable = '0' and RS = "0011" else '0';
	Register_4_Write <= '1' when Write_Enable = '0' and RS = "0100" else '0';
	Register_5_Write <= '1' when Write_Enable = '0' and RS = "0101" else '0';
	Register_6_Write <= '1' when Write_Enable = '0' and RS = "0110" else '0';
	Register_7_Write <= '1' when Write_Enable = '0' and RS = "0111" else '0';
	Register_8_Write <= '1' when Write_Enable = '0' and RS = "1000" else '0';
	Register_9_Write <= '1' when Write_Enable = '0' and RS = "1001" else '0';
	Register_A_Write <= '1' when Write_Enable = '0' and RS = "1010" else '0';
	Register_B_Write <= '1' when Write_Enable = '0' and RS = "1011" else '0';
	Register_C_Write <= '1' when Write_Enable = '0' and RS = "1100" else '0';
	Register_D_Write <= '1' when Write_Enable = '0' and RS = "1101" else '0';
	Register_E_Write <= '1' when Write_Enable = '0' and RS = "1110" else '0';
	Register_F_Write <= '1' when Write_Enable = '0' and RS = "1111" else '0';

	process(CLK, RESET, Register_1_Write, Register_1_Read, PC_Waveform)
	begin
		if RESET = '0' then
			PC_Waveform <= "11";
		else
			if rising_edge(CLK) then
 		   	PC_Waveform(1) <= PC_Waveform(0);
			end if;
			PC_Waveform(0) <= Register_1_Write or (not Register_1_Read);
		end if;
	end process;

-- Serial Port
	SPCNT : Counter3BitNoDB PORT MAP(RESET, SP_Trigger, SP_Counter);
	RegC :			for i in 7 downto 0 generate
							RC : register1bit PORT MAP(RESET, RC_DB(i), Register_C(i), RC_W);
						end generate;
	RC_DB <= SP_Shift_Reg when (SP_FullEmpty = '0' and Register_E(6) = '0') else DB;
	RC_W <= '1' when (SP_FullEmpty = '1' and Register_E(6) = '0') or Register_C_Write = '1' else '0';
	SP_Trigger <= '1' when (Register_E(6) = '1' and TA_Toggle = '1') or (Register_E(6) = '0' and CNT = '1') else '0';
	SP_FullEmpty <= SP_Counter(2) or SP_Counter(1) or SP_Counter(0);
	
	process(Register_E(6), TA_Toggle)
	begin
		if Register_E(6) = '1' then
			CNT <= TA_Toggle;
		else
			CNT <= 'Z';
		end if;
	end process;

	process(RESET, SP_Trigger, SP_FullEmpty, Register_E(6), SP, Register_C, SP_Shift_Reg)
	begin
		if RESET = '0' then
			SP_Shift_Reg <= "00000000";
		else
			if SP_FullEmpty = '0' and Register_E(6) = '0' then
				SP_Shift_Reg <= Register_C;
			else
				if rising_edge(SP_Trigger) then
					if Register_E(6) = '0' then
						SP_Shift_Reg <= SP_Shift_Reg(6 downto 0) & SP;
					else
						SP_Shift_Reg <= SP_Shift_Reg(6 downto 0) & '0';
					end if;
			   end if;
			end if;
		end if;
	end process;
		SP <= SP_Shift_Reg(7) when (Register_E(6) = '1') else 'Z';
end behavioral;
