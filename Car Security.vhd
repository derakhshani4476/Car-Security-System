
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity project_tb is
--  Port ( );
end project_tb;

architecture Behavioral of project_tb is


component fpga_test1 IS
	PORT (
		CLK, make_ready, change_pass, door_sensor, window_sensor,add_member : IN std_logic;
		insertion_command1 : IN std_logic_vector(31 DOWNTO 0);
		alarm : OUT std_logic
	);

END component;

signal clk_b,make_ready_b,change_pass_b,door_sensor_b,window_sensor_b,add_member_b : std_logic;

signal insertion_command_b:std_logic_vector(31 downto 0);
constant period : time := 1 ms;
signal alarm_b:std_logic;

BEGIN
uut: fpga_test1 PORT MAP ( clk=>clk_b,make_ready=>make_ready_b,change_pass=>change_pass_b,
						  door_sensor=>door_sensor_b,window_sensor=>window_sensor_b,add_member=>add_member_b,
						  insertion_command1=>insertion_command_b,alarm=>alarm_b);

   clk_process :process
   begin
      clk_b <= '1';
      wait for period/2;
      clk_b <= '0';
      wait for period/2;
   end process;

   stim_proc:process
   begin    

    wait for period/2;
	--#
	 make_ready_b<='1';
	 wait for period;
	 make_ready_b<='0';
     insertion_command_b<="00000000000000000000000001000111";
	 
       wait for period;
	   --1
	   
	 insertion_command_b<="00000000000000000000000001100010";
	  
	  wait for period;
	  --*
	 insertion_command_b<="00000000000000000000000001010101";
	 
	  wait for period;
	  --1
	 insertion_command_b<="00000000000000000000000001100010";
	 
	 	  wait for period;
	  --#
	 insertion_command_b<="00000000000000000000000001000111";
	  
	  wait for period;
	
	  
	 wait for period;
	 --#
		 add_member_b<='1';
		 wait for period;
		 add_member_b<='0';
	  	 insertion_command_b<="00000000000000000000000001000111";
	  
	   wait for period;
	  --1
		
	  	 insertion_command_b<="00000000000000000000000001100010";
	  
	   wait for period;
	 --9
	 	 insertion_command_b<="00000000000000000000000001110011";
	   wait for period;
	 --0
	 	 insertion_command_b<="00000000000000000000000001100000";
	  wait for period;
	  --0
	  	 insertion_command_b<="00000000000000000000000001100001";
	  wait for period;
	  --*
	  	 insertion_command_b<="00000000000000000000000001010100";
	  
	   wait for period;
	   --6
	   	 insertion_command_b<="00000000000000000000000001101101";
	   
	   wait for period;

	-- 5
		 insertion_command_b<="00000000000000000000000001101010";
	  
	  wait for period;
	-- 4
	  	 insertion_command_b<="00000000000000000000000001101001";
	  wait for period;
	 -- 3
	  	 insertion_command_b<="00000000000000000000000001100110";
	  wait for period;
	 --2
	  	 insertion_command_b<="00000000000000000000000001100101";
	 wait for period;
	 -- 1
	  	 insertion_command_b<="00000000000000000000000001100010";
	   wait for period;
	 -- *
	  	 insertion_command_b<="00000000000000000000000001010101";
	   wait for period;
	 --1
	 	 insertion_command_b<="00000000000000000000000001100010";
	   wait for period;
	--  #
		 insertion_command_b<="00000000000000000000000001000111";
	  wait for period;
	  wait for period;
	  -- #
	  add_member_b<='1';
	    wait for period;
 		 insertion_command_b<="00000000000000000000000001000110";  
	   add_member_b<='0';
	   wait for period;
	   --6
	   
	   	 insertion_command_b<="00000000000000000000000001101101";
	   wait for period;
	   --7
	   	 insertion_command_b<="00000000000000000000000001101110";
	   wait for period;
	   --3
	   	 insertion_command_b<="00000000000000000000000001100111";
	   wait for period;
	   --1
	   	 insertion_command_b<="00000000000000000000000001100010";
	   wait for period;
	   --*
	   	 insertion_command_b<="00000000000000000000000001010101";
	 wait for period;
		   --6
		 insertion_command_b<="00000000000000000000000001101100";  
   wait for period;
   --5
   	   	 insertion_command_b<="00000000000000000000000001101011";
   wait for period;
   --4
   	   	 insertion_command_b<="00000000000000000000000001101000";
   wait for period;
   --3
   	   	 insertion_command_b<="00000000000000000000000001100111";
   wait for period;
   --2
   	   	 insertion_command_b<="00000000000000000000000001100100";
   wait for period;
   --1
   	   	 insertion_command_b<="00000000000000000000000001100011";
   wait for period;
   --*
   	   	 insertion_command_b<="00000000000000000000000001010100";
   wait for period;
   --3
   	   	 insertion_command_b<="00000000000000000000000001100111";
   wait for period;
   --#
   	   	 insertion_command_b<="00000000000000000000000001000110";
   wait for period;
   wait for period;
   --#
         change_pass_b<='1';
          wait for period;
   	   	 insertion_command_b<="00000000000000000000000001000111";
   	   	 change_pass_b<='0';
   wait for period;
   --1
		 
   	   	 insertion_command_b<="00000000000000000000000001100010";
   wait for period;
   --4
   	   	 insertion_command_b<="00000000000000000000000001101001";
   wait for period;
   --3
   	   	 insertion_command_b<="00000000000000000000000001100110";
   wait for period;
   --1
   	   	 insertion_command_b<="00000000000000000000000001100011";
   wait for period;
   --*
   	   	 insertion_command_b<="00000000000000000000000001010100";
   wait for period;
   --6
   	   	 insertion_command_b<="00000000000000000000000001101101";
   wait for period;
   --7
   	   	 insertion_command_b<="00000000000000000000000001101110";
   wait for period;
   --3
   	   	 insertion_command_b<="00000000000000000000000001100111";
   wait for period;
   --1
   	   	 insertion_command_b<="00000000000000000000000001100010";
   wait for period;
   --*
   	   	 insertion_command_b<="00000000000000000000000001010101";
   wait for period;
   --3
   	   	 insertion_command_b<="00000000000000000000000001100110";
   wait for period;
   --#
   	   	 insertion_command_b<="00000000000000000000000001000111";
   wait for period;
   wait for period;
   door_sensor_b<='1';

   wait for period;
   door_sensor_b<='0';
   wait for 7*period;
   --# 
    insertion_command_b<="00000000000000000000000001000110";
   wait for period;
   --# false
    insertion_command_b<="00000000000000000000000001000111";
    wait for period;
    wait for period;
   --#
   insertion_command_b<="00000000000000000000000001000110";
    wait for period;
   --1
    insertion_command_b<="00000000000000000000000001100011";
    wait for period;
   --* false
   insertion_command_b<="00000000000000000000000001010100";
   wait for period;
   wait for period; 
   --#
   insertion_command_b<="00000000000000000000000001000111";
    wait for period;
   --* false
   insertion_command_b<="00000000000000000000000001010100";
    wait for period;
    wait for period;
       
   
   --#
      insertion_command_b<="00000000000000000000000001000111";
   wait for period; 
   --1
    insertion_command_b<="00000000000000000000000001100011";
   wait for period;
   --9
    insertion_command_b<="00000000000000000000000001110010";
   wait for period;
   --0
    insertion_command_b<="00000000000000000000000001100001";
   wait for period;
   --0
    insertion_command_b<="00000000000000000000000001100000";
   wait for period;
   --#
    insertion_command_b<="00000000000000000000000001000111";

   wait for period;
   wait for period;
   window_sensor_b<='1';
   wait for period;
   wait for period;
   wait for period;
   wait for period;
   wait for period;
   
   
		  



   wait;
   end process; -- stimulus


end Behavioral;
