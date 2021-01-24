--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:15:22 01/14/2021
-- Design Name:   
-- Module Name:   E:/ITI_references/Digital_IC_course/FPGA_prototype/Project/Final_3/sine_gen_ise/sine_gen_ise/Sine_tb.vhd
-- Project Name:  sine_gen_ise
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sine_top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Sine_tb IS
END Sine_tb;
 
ARCHITECTURE behavior OF Sine_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sine_top
    PORT(
         freq_1 : IN  std_logic_vector(7 downto 0);
         freq_2 : IN  std_logic_vector(7 downto 0);
         freq_sys : IN  std_logic_vector(7 downto 0);
         n_waves : IN  std_logic_vector(4 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic;
         en : IN  std_logic;
         final_out : OUT  std_logic_vector(8 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal freq_1 : std_logic_vector(7 downto 0) := (others => '0');
   signal freq_2 : std_logic_vector(7 downto 0) := (others => '0');
   signal freq_sys : std_logic_vector(7 downto 0) := (others => '0');
   signal n_waves : std_logic_vector(4 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal en : std_logic := '0';

 	--Outputs
   signal final_out : std_logic_vector(8 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sine_top PORT MAP (
          freq_1 => freq_1,
          freq_2 => freq_2,
          freq_sys => freq_sys,
          n_waves => n_waves,
          clk => clk,
          rst => rst,
          en => en,
          final_out => final_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '1';
		wait for clk_period/2;
		clk <= '0';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 20 ns.
      wait for 20 ns;	


      -- insert stimulus here 
		--UPPER CASE #1 : normal operation
			--case 1 : 
				rst           <= '1'                                 ; --rst      = device working
				freq_1        <= std_logic_vector(to_unsigned(10,8))  ; --f1       = 10   Mhz
				freq_2        <= std_logic_vector(to_unsigned(20,8))  ; --f2       = 20   Mhz
				freq_sys      <= std_logic_vector(to_unsigned(100,8)); --f_s      = 100 Mhz
				n_waves       <= std_logic_vector(to_unsigned(1,5))  ; --n_waves  = 2
				en            <= '1'                                 ; --enable   = ON
				--@20 ns
				wait for 4*clk_period;
				
				assert (final_out = std_logic_vector(to_signed(102,9)))
				report "First output should be 4*255/(100/f1)=51" severity error;
				
			--case 2 : 
				rst           <= '0'                                 ; --rst      = device held on reset state
				freq_1        <= std_logic_vector(to_unsigned(5,8))  ; --f1       = 5   Mhz
				en            <= '1'                                 ; --enable   = ON
				--@100 ns
				wait for 2*clk_period;
				
				assert (final_out = std_logic_vector(to_signed(0,9)))
				report "Rst active but there is o/p" severity error;
				
			--case 3 : 
				rst           <= '1'                                 ; --rst      = device working
				en            <= '0'                                 ; --enable   = OFF
				--@140 ns
				wait for 4*clk_period;
				
				assert (final_out = std_logic_vector(to_signed(0,9)))
				report "En is down but there is o/p" severity error;
				
			--case 4 : 
				rst           <= '1'                                 ; --rst      = device working
				en            <= '1'                                 ; --enable   = ON
				--@220ns
				wait for 3*clk_period;
				
				assert (final_out = std_logic_vector(to_signed(51,9)))
				report "Incorrect o/p" severity error;
			--case 5 : 
				rst           <= '1'                                 ; --rst      = device working
				en            <= '0'                                 ; --enable   = OFF
				--@280ns
				wait for 3*clk_period;
				
				assert (final_out = std_logic_vector(to_signed(102,9)))
				report "Incorrect o/p when en is down" severity error;
				
			--case 6 : 
				rst           <= '1'                                 ; --rst      = device working
				en            <= '1'                                 ; --enable   = ON
				--@340ns
				wait for 1*clk_period;
				
				assert (final_out = std_logic_vector(to_signed(153,9)))
				report "Incorrect o/p when en is up mid operation (didn't continue)" severity error;
				
			--case 7 : 
				rst           <= '1'                                 ; --rst      = device working
				en            <= '1'                                 ; --enable   = ON
				--@360ns
				wait for 2*clk_period;
				
				assert (final_out = std_logic_vector(to_signed(204,9)))
				report "Incorrect o/p after resuming" severity error;
			--case 8 : 
				rst           <= '1'                                 ; --rst      = device working
				en            <= '1'                                 ; --enable   = ON
				--@380ns
				wait for 17*clk_period;
				
				assert (final_out = std_logic_vector(to_signed(0,9)))
				report "first sine should've ended here" severity error;
			--case 9 : 
				rst           <= '1'                                 ; --rst      = device working
				en            <= '1'                                 ; --enable   = ON
				--@740ns
				wait for 6*clk_period;
				
				assert (final_out /= std_logic_vector(to_signed(0,9)))
				report "incorrect 2nd sine value mapping" severity error;
			--case 10 : 
				rst           <= '1'                                 ; --rst      = device working
				en            <= '1'                                 ; --enable   = ON
				--@840ns
				wait for 1*clk_period;
				
				assert (final_out = std_logic_vector(to_signed(0,9)))
				report "2nd sine should've ended here" severity error;
				
				
		--UPPER CASE #2 : 2 Nyquist violating frequencies
			--case 1 : 
				rst           <= '0'                                 ; --rst      = device working
				freq_1        <= std_logic_vector(to_unsigned(100,8))  ; --f1       = 10   Mhz
				freq_2        <= std_logic_vector(to_unsigned(200,8))  ; --f2       = 20   Mhz
				freq_sys      <= std_logic_vector(to_unsigned(100,8)); --f_s      = 100 Mhz
				n_waves       <= std_logic_vector(to_unsigned(1,5))  ; --n_waves  = 2
				en            <= '1'                                 ; --enable   = ON
				--@860ns
				wait for 1*clk_period;
				
				assert (final_out = std_logic_vector(to_signed(0,9)))
				report "o/p on rst" severity error;
			--case 2 : 
				rst           <= '1'                                 ; --rst      = device working
				en            <= '1'                                 ; --enable   = ON
				--@880ns
				wait for 1*clk_period;
				
				assert (final_out = std_logic_vector(to_signed(0,9)))
				report "Nyquist violation" severity error;
			--case 3 : 
				rst           <= '1'                                 ; --rst      = device working
				en            <= '1'                                 ; --enable   = ON
				--@900ns
				wait for 1*clk_period;
				
				assert (final_out = std_logic_vector(to_signed(0,9)))
				report "Nyquist violation" severity error;
		
		--UPPER CASE #3 : 1 violating and 1 normal operation
			--case 1 : 
				rst           <= '0'                                 ; --rst      = device working
				freq_1        <= std_logic_vector(to_unsigned(200,8))  ; --f1       = 10   Mhz
				freq_2        <= std_logic_vector(to_unsigned(20,8))  ; --f2       = 20   Mhz
				freq_sys      <= std_logic_vector(to_unsigned(100,8)); --f_s      = 100 Mhz
				n_waves       <= std_logic_vector(to_unsigned(2,5))  ; --n_waves  = 2
				en            <= '1'                                 ; --enable   = ON
				--@920ns
				wait for 1*clk_period;
				
				assert (final_out = std_logic_vector(to_signed(0,9)))
				report "o/p on rst" severity error;
			--case 2 : 
				rst           <= '1'                                 ; --rst      = device working
				en            <= '1'                                 ; --enable   = ON
				--@940ns
				wait for 1*clk_period;
				
				assert (final_out = std_logic_vector(to_signed(0,9)))
				report "Illegal Nyquisst violation handling" severity error;	
			--case 3 : 
				rst           <= '1'                                 ; --rst      = device working
				en            <= '1'                                 ; --enable   = ON
				--@960ns
				wait for 5*clk_period;
				
				assert (final_out = std_logic_vector(to_signed(204,9)))
				report "Illegal o/p" severity error;	
			--case 4 : 
				rst           <= '1'                                 ; --rst      = device working
				en            <= '1'                                 ; --enable   = ON
				--@1060ns
				wait for 4*clk_period;
				
				assert (final_out /= std_logic_vector(to_signed(0,9)))
				report "Illegal o/p" severity error;	
			--case 5 : 
				rst           <= '1'                                 ; --rst      = device working
				en            <= '1'                                 ; --enable   = ON
				--@1140ns
				wait for 8*clk_period;
				
				assert (final_out /= std_logic_vector(to_signed(0,9)))
				report "Illegal value in 1st sirine" severity error;		
			--case 6 : 
				rst           <= '1'                                 ; --rst      = device working
				en            <= '1'                                 ; --enable   = ON
				--@1300ns
				wait for 2*clk_period;
				
				assert (final_out = std_logic_vector(to_signed(0,9)))
				report "Illegal end to 2nd sirine" severity error;					
				

      wait;
   end process;

END;
