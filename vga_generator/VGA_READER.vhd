----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:43:21 12/04/2010 
-- Design Name: 
-- Module Name:    VGA_READER - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;

------ Uncomment the following library declaration if instantiating
------ any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA_READER is
   Port ( 
		R_OUTPUT : out unsigned(9 downto 0);
		G_OUTPUT : out unsigned(9 downto 0);
		B_OUTPUT : out unsigned(9 downto 0);
		H_OUTPUT : out std_logic;
		V_OUTPUT : out std_logic		
	);
end VGA_READER;

architecture Behavioral of VGA_READER is

	-- simulering
	SUBTYPE Dataformat is integer;
   TYPE Stimuli is file of Dataformat;
	SHARED VARIABLE variable_data: unsigned(31 downto 0) := (others => '0');
 
   FILE infil: Stimuli;
	
begin

	process
		VARIABLE bv : Dataformat := 0;
		variable ok : FILE_OPEN_STATUS;
	begin 
		while true loop
			FILE_OPEN(ok, infil, "test_output_sim.txt", READ_MODE);
			
			while not ENDFILE(infil) loop  
				
				READ (infil,bv); 
				variable_data := unsigned(to_signed(bv,32));
			
				R_OUTPUT <= variable_data(9 downto 0);
				G_OUTPUT <= variable_data(19 downto 10);
				B_OUTPUT <= variable_data(29 downto 20);
				H_OUTPUT <= variable_data(30);
				V_OUTPUT <= variable_data(31);
				
				wait for 40 ns;
			end loop;
			
			FILE_CLOSE(infil);
		end loop; -- Forever			
	end process;
end Behavioral;

