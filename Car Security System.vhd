
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY fpga_test1 IS
	PORT (
		CLK, make_ready, change_pass, door_sensor, window_sensor, add_member : IN std_logic;
		insertion_command1 : IN std_logic_vector(31 DOWNTO 0);
		alarm : OUT std_logic
	);
END fpga_test1;

ARCHITECTURE Behavioral OF fpga_test1 IS
	SIGNAL out1, out2, OUT3, OUT4, OUT5, out6, out7, out8, out9 : std_logic := '1';
	SIGNAL turn_on, on_flag, ch_flag, nothing, change, change_finish, add_flag, add_finish, door_finished, 
	work_on_door, door_flag, work_on_change, work_on_add, want_ready, window_alarm, door_alarm, 
	work_on_window ,false0: STD_LOGIC := '0';
	SIGNAL alarm_counter : INTEGER := - 1;
	SIGNAL insertion_command : CHARACTER;
	SIGNAL false_counter : INTEGER := 0;

	TYPE state IS (on_RST, on1, on_start, on_finish, onstar, on_user, ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8, 
	ch_finish, ad1, ad2, ad3, ad4, ad_ad, ad_ad2, ad_ad3, ad_ad4, ad_ad5, ad_ad6, ad_finish, rst, 
	start, chstar1, chstar2, username, add_RST, adstar1, add_start, door1, door2, door3, door4, 
	door_RST, door_finish, door_start, ad_us, adstar2);
	SIGNAL CUR4_STATE : state := door_RST;
	SIGNAL cur1_state : state := rst;
	SIGNAL cur3_state : state := on_RST;
	SIGNAL cur2_state : state := add_RST;

	SIGNAL next3_state : state := add_start;
	SIGNAL next2_state : state := start;
	SIGNAL next4_state : state := on_start;
	SIGNAL NEXT5_STATE : STATE := door_start;

	TYPE ARR1 IS ARRAY (3 DOWNTO 0) OF CHARACTER;
	TYPE ARR2 IS ARRAY (3 DOWNTO 0) OF arr1;
	SIGNAL storage : arr2;

	TYPE ARR3 IS ARRAY (3 DOWNTO 0) OF INTEGER;
	TYPE ARR4 IS ARRAY (3 DOWNTO 0) OF arr3;
	SIGNAL int_storage : arr4;

	TYPE ARR5 IS ARRAY (5 DOWNTO 0) OF CHARACTER;
	SIGNAL admin_pass : arr5;

	SIGNAL pass_storage : arr2;
	SIGNAL new_pass, current_pass, new_user_pass : arr1;
	SIGNAL user_n : CHARACTER;
	SIGNAL changing : INTEGER;
BEGIN
	changing <= conv_integer(unsigned(insertion_command1(9 DOWNTO 1)));
	insertion_command <= CHARACTER'val(changing);
	alarm <= door_alarm OR window_alarm;
	window_process : PROCESS (clk)
	BEGIN
		IF (rising_edge(clk) AND window_sensor = '1') THEN
			work_on_window <= '1';
		END IF;
	END PROCESS;

	PROCESS (clk)
		BEGIN
			IF (rising_edge(clk) AND work_on_window = '1') THEN
				window_alarm <= '1';
			END IF;
		END PROCESS;

		door_proc1 : PROCESS (clk)
		BEGIN
			IF (rising_edge(CLK) AND turn_on = '1' AND window_sensor /= '1') THEN
				IF (work_on_door = '1') THEN
					IF ((door_flag = insertion_command1(0) AND door_finished <= '1')OR alarm_counter > 30 or false_counter>=3) THEN
						CUR4_STATE <= door_RST;

					ELSIF (door_flag = insertion_command1(0)) THEN
						cur4_state <= cur4_state;
					ELSE
						door_flag <= insertion_command1(0);
						cur4_state <= next5_state;

					END IF;
					alarm_counter <= alarm_counter + 1;
				ELSIF (work_on_door = '0') THEN
					alarm_counter <= - 1;
				END IF;
			END IF;
		END PROCESS;

		door_proc2 : PROCESS (clk, change)
		BEGIN
			IF rising_edge(clk) THEN
				IF (door_sensor = '1' ) THEN
					work_on_door <= '1';
				ELSE
					nothing <= '1';
				END IF;

			END IF;
			CASE cur4_state IS
				WHEN door_RST => 

					IF (alarm_counter > 30 or false_counter>=3) THEN
						door_alarm <= '1';
					ELSIF (alarm_counter = 5 OR alarm_counter = 10 OR alarm_counter = 15 OR
						alarm_counter = 20 OR alarm_counter = 25 OR alarm_counter = 30) THEN

						door_alarm <= '1';
					ELSE
						door_alarm <= '0';

					END IF;
					next5_state <= door_start;

				WHEN door_start => 

					IF (CHARACTER'pos(insertion_command) = 35) THEN

						next5_state <= door1;
					ELSE
						
						door_finished <= '1';
						next5_state <= door_rst;
					END IF;
					IF (alarm_counter = 5 OR alarm_counter = 10 OR alarm_counter = 15 OR
				 alarm_counter = 20 OR alarm_counter = 25 OR alarm_counter = 30) THEN

					door_alarm <= '1';
				ELSE
					door_alarm <= '0';

				END IF;

				WHEN door1 => 
							IF (CHARACTER'pos(insertion_command) > 47 AND CHARACTER'pos(insertion_command) < 58) THEN

								next5_state <= door2;
							ELSE
							
								door_finished <= '1';
								next5_state <= door_rst;
							END IF;

							IF (alarm_counter = 5 OR alarm_counter = 10 OR alarm_counter = 15 OR
						 alarm_counter = 20 OR alarm_counter = 25 OR alarm_counter = 30) THEN

							door_alarm <= '1';
						ELSE
							door_alarm <= '0';

						END IF;
				WHEN door2 => 
									IF (CHARACTER'pos(insertion_command) > 47 AND CHARACTER'pos(insertion_command) < 58) THEN

										next5_state <= door3;
									ELSE
										
										door_finished <= '1';
										next5_state <= door_rst;
									END IF;
									IF (alarm_counter = 5 OR alarm_counter = 10 OR alarm_counter = 15 OR
								 alarm_counter = 20 OR alarm_counter = 25 OR alarm_counter = 30) THEN

									door_alarm <= '1';
								ELSE
									door_alarm <= '0';

								END IF;

				WHEN door3 => 
											IF (CHARACTER'pos(insertion_command) > 47 AND CHARACTER'pos(insertion_command) < 58) THEN

												next5_state <= door4;
											ELSE
										
												door_finished <= '1';
												next5_state <= door_rst;
											END IF;

											IF (alarm_counter = 5 OR alarm_counter = 10 OR alarm_counter = 15 OR
										 alarm_counter = 20 OR alarm_counter = 25 OR alarm_counter = 30) THEN

											door_alarm <= '1';
										ELSE
											door_alarm <= '0';

										END IF;

				WHEN door4 => 
													IF (CHARACTER'pos(insertion_command) > 47 AND CHARACTER'pos(insertion_command) < 58) THEN

														next5_state <= door_finish;
													ELSE
													    
														door_finished <= '1';
														next5_state <= door_rst;
													END IF;
													IF (alarm_counter = 5 OR alarm_counter = 10 OR alarm_counter = 15 OR
												 alarm_counter = 20 OR alarm_counter = 25 OR alarm_counter = 30) THEN

													door_alarm <= '1';
												ELSE
													door_alarm <= '0';

												END IF;

				WHEN door_finish => 
															IF (CHARACTER'pos(insertion_command) = 35) THEN
																work_on_door <= '0';
																false0 <= '1';
																door_alarm <= '0';
															ELSE
																
																door_finished <= '1';
																next5_state <= door_rst;
																IF (alarm_counter = 5 OR alarm_counter = 10 OR alarm_counter = 15 OR
																 alarm_counter = 20 OR alarm_counter = 25 OR alarm_counter = 30) THEN

																	door_alarm <= '1';
																ELSE
																	door_alarm <= '0';

																END IF;

																END IF;

				WHEN OTHERS => 
																	next5_state <= door_rst;
														END CASE;
													END PROCESS;
													
				process(clk,door_finished)
				begin
				if(rising_edge(clk)  ) then
				if(cur4_state/= door_finish and next5_state=door_RST) then
				false_counter<=false_counter + 1;
				else
				nothing<='1';
				end if;
				end if;
				end process;

													PROCESS (clk)
												BEGIN
													change <= NOT change;

												END PROCESS;

												PROCESS (clk)
													BEGIN
														IF (rising_edge(CLK) AND make_ready = '1') THEN
															want_ready <= '1';

														END IF;
													END PROCESS;

													turn_on_proc1 : PROCESS (clk)
													BEGIN
														IF (rising_edge(CLK) AND want_ready = '1') THEN
															IF (turn_on = '1') THEN
																CUR3_STATE <= on_RST;

															ELSIF (on_flag = insertion_command1(0)) THEN
																cur3_state <= cur3_state;
															ELSE
																out1 <= '0';
																on_flag <= insertion_command1(0);
																cur3_state <= next4_state;

															END IF;
														END IF;
													END PROCESS;

													turn_on_proc2 : PROCESS (clk, change)
													BEGIN
														CASE cur3_state IS
															WHEN on_RST => 
																next4_state <= on_start;

															WHEN on_start => 

																IF (CHARACTER'pos(insertion_command) = 35) THEN

																	next4_state <= on1;
																ELSE

																	next4_state <= on_rst;
																END IF;

															WHEN on1 => 
																IF (CHARACTER'pos(insertion_command) = 49) THEN

																	next4_state <= onstar;
																ELSE

																	next4_state <= on_RST;
																END IF;
															WHEN onstar => 
																IF (CHARACTER'pos(insertion_command) = 42) THEN

																	next4_state <= on_user;
																ELSE

																	next4_state <= on_RST;
																END IF;

															WHEN on_user => 
																IF (CHARACTER'pos(insertion_command) > 48 AND CHARACTER'pos(insertion_command) < 53) THEN

																	next4_state <= on_finish;
																ELSE
																	next4_state <= on_RST;
																END IF;

															WHEN on_finish => 
																IF (CHARACTER'pos(insertion_command) = 35) THEN
																	turn_on <= '1';
																	--want_ready<='0';
																ELSE
																	nothing <= '1';

																END IF;
																next4_state <= on_rst;
															WHEN OTHERS => 
																next4_state <= on_RST;
														END CASE;
													END PROCESS;

													PROCESS (clk)
														BEGIN
															IF rising_edge(clk)  then
															if(change_pass = '1') THEN
																work_on_change <= '1';
															ELSIF ( add_member = '1') THEN
																work_on_add <= '1';
																end if;
															END IF;
														END PROCESS;

														change_pass_process1 : PROCESS (CLK)
														BEGIN
															IF (rising_edge(CLK) AND turn_on = '1' AND work_on_change = '1') THEN
																IF (ch_flag = insertion_command1(0) AND change_finish = '1') THEN
																	cur1_state <= RST;

																ELSIF (ch_flag = insertion_command1(0)) THEN
																	cur1_state <= cur1_state;
																ELSE
																	ch_flag <= insertion_command1(0);
																	cur1_state <= next2_state;

																END IF;
															END IF;
															IF (rising_edge(CLK) AND turn_on = '1' AND work_on_add = '1') THEN
																IF (add_flag = insertion_command1(0) AND add_finish = '1') THEN
																	cur2_state <= add_RST;
																	out4 <= NOT out4;

																ELSIF (add_flag = insertion_command1(0)) THEN
																	cur2_state <= cur2_state;
																	out3 <= NOT out3;

																ELSE
																	out2 <= NOT out2;
																	add_flag <= insertion_command1(0);
																	cur2_state <= next3_state;

																END IF;
															END IF;
														END PROCESS;

														change_pass_process2 : PROCESS (cur1_state, cur2_state, change)
															VARIABLE user_int : INTEGER;
														BEGIN
															CASE cur1_state IS
																WHEN RST => 
																	next2_state <= start;

																WHEN start => 

																	IF (CHARACTER'pos(insertion_command) = 35) THEN
																		change_finish <= '0';
																		next2_state <= ch1;
																	ELSE
																		change_finish <= '1';
																		next2_state <= RST;
																	END IF;

																WHEN ch1 => 
																	IF (CHARACTER'pos(insertion_command) > 47 AND CHARACTER'pos(insertion_command) < 58) THEN
																		new_pass(0) <= insertion_command;
																		next2_state <= ch2;
																	ELSE
																		next2_state <= rst;
																		change_finish <= '1';
																	END IF;
																WHEN ch2 => 
																	IF (CHARACTER'pos(insertion_command) > 47 AND CHARACTER'pos(insertion_command) < 58) THEN
																		new_pass(1) <= insertion_command;
																		next2_state <= ch3;
																	ELSE

																		next2_state <= rst;
																		change_finish <= '1';
																	END IF;

																WHEN ch3 => 
																	IF (CHARACTER'pos(insertion_command) > 47 AND CHARACTER'pos(insertion_command) < 58) THEN
																		new_pass(2) <= insertion_command;
																		next2_state <= ch4;
																	ELSE
																		next2_state <= rst;
																		change_finish <= '1';
																	END IF;

																WHEN ch4 => 
																	IF (CHARACTER'pos(insertion_command) > 47 AND CHARACTER'pos(insertion_command) < 58) THEN
																		new_pass(3) <= insertion_command;
																		next2_state <= chstar1;
																	ELSE
																		next2_state <= rst;
																		change_finish <= '1';
																	END IF;

																WHEN chstar1 => 
																	IF (CHARACTER'pos(insertion_command) = 42) THEN

																		next2_state <= ch5;
																	ELSE
																		next2_state <= rst;
																		change_finish <= '1';
																	END IF;

																WHEN ch5 => 
																	IF (CHARACTER'pos(insertion_command) > 47 AND CHARACTER'pos(insertion_command) < 58) THEN
																		current_pass(0) <= insertion_command;
																		next2_state <= ch6;
																	ELSE
																		next2_state <= RST;
																		change_finish <= '1';
																	END IF;

																WHEN ch6 => 
																	IF (CHARACTER'pos(insertion_command) > 47 AND CHARACTER'pos(insertion_command) < 58) THEN
																		current_pass(1) <= insertion_command;
																		next2_state <= ch7;
																	ELSE
																		next2_state <= RST;
																		change_finish <= '1';
																	END IF;

																WHEN ch7 => 
																	IF (CHARACTER'pos(insertion_command) > 47 AND CHARACTER'pos(insertion_command) < 58) THEN
																		current_pass(2) <= insertion_command;
																		next2_state <= ch8;
																	ELSE
																		next2_state <= RST;
																		change_finish <= '1';
																	END IF;
																WHEN ch8 => 
																	IF (CHARACTER'pos(insertion_command) > 47 AND CHARACTER'pos(insertion_command) < 58) THEN
																		current_pass(3) <= insertion_command;
																		next2_state <= chstar2;
																	ELSE
																		next2_state <= RST;
																		change_finish <= '1';
																	END IF;

																WHEN chstar2 => 
																	IF (CHARACTER'pos(insertion_command) = 42) THEN

																		next2_state <= username;
																	ELSE
																		next2_state <= RST;
																		change_finish <= '1';
																	END IF;
																WHEN username => 
																	IF (CHARACTER'pos(insertion_command) > 47 AND CHARACTER'pos(insertion_command) < 58) THEN
																		user_n <= insertion_command;
																		next2_state <= ch_finish;
																	ELSE
																		next2_state <= RST;
																		change_finish <= '1';
																	END IF;

																WHEN ch_finish => 
																	IF (CHARACTER'pos(insertion_command) = 35) THEN
																		IF (user_n = '1') THEN
																			user_int := 1;
																		ELSIF (user_n = '2') THEN
																			user_int := 2;
																		ELSIF (user_n = '3') THEN
																			user_int := 3;
																		ELSIF (user_n = '4') THEN
																			user_int := 4;
																		ELSE
																			nothing <= '1';

																		END IF;
																		IF (storage((user_int)) = current_pass) THEN
																			storage((user_int)) <= new_pass;
																		ELSE
																			nothing <= '1';
																		END IF;

																	ELSE
																		nothing <= '1';
																	END IF;
																	change_finish <= '1';
																	next2_state <= RST;

																WHEN OTHERS => 
																	next2_state <= RST;
															END CASE;
															CASE cur2_state IS
																WHEN add_RST => 
																	next3_state <= add_start;

																WHEN add_start => 

																	IF (CHARACTER'pos(insertion_command) = 35) THEN

																		add_finish <= '0';
																		next3_state <= ad1;
																	ELSE
																		out6 <= NOT out6;
																		add_finish <= '1';
																		next3_state <= add_RST;
																	END IF;

																WHEN ad1 => 
																	IF (CHARACTER'pos(insertion_command) > 47 AND CHARACTER'pos(insertion_command) < 58) THEN
																		new_user_pass(0) <= insertion_command;
																		next3_state <= ad2;
																	ELSE
																		out5 <= NOT out5;
																		next3_state <= add_RST;
																		add_finish <= '1';
																	END IF;
																WHEN ad2 => 
																	IF (CHARACTER'pos(insertion_command) > 47 AND CHARACTER'pos(insertion_command) < 58) THEN
																		new_user_pass(1) <= insertion_command;
																		next3_state <= ad3;
																	ELSE
																		next3_state <= add_rst;
																		add_finish <= '1';
																	END IF;

																WHEN ad3 => 
																	IF (CHARACTER'pos(insertion_command) > 47 AND CHARACTER'pos(insertion_command) < 58) THEN
																		new_user_pass(2) <= insertion_command;
																		next3_state <= ad4;
																	ELSE
																		next3_state <= add_rst;
																		add_finish <= '1';
																	END IF;

																WHEN ad4 => 
																	IF (CHARACTER'pos(insertion_command) > 47 AND CHARACTER'pos(insertion_command) < 58) THEN
																		new_user_pass(3) <= insertion_command;
																		next3_state <= adstar1;
																	ELSE
																		next3_state <= add_rst;
																		add_finish <= '1';
																	END IF;

																WHEN adstar1 => 
																	IF (CHARACTER'pos(insertion_command) = 42) THEN

																		next3_state <= ad_ad;
																	ELSE
																		add_finish <= '1';
																		next3_state <= add_rst;
																	END IF;

																WHEN ad_ad => 
																	IF (CHARACTER'pos(insertion_command) = 54) THEN
																		admin_pass(5) <= insertion_command;
																		next3_state <= ad_ad2;
																	ELSE
																		add_finish <= '1';
																		next3_state <= add_rst;
																	END IF;
																WHEN ad_ad2 => 
																	IF (CHARACTER'pos(insertion_command) = 53) THEN
																		admin_pass(4) <= insertion_command;
																		next3_state <= ad_ad3;
																	ELSE
																		add_finish <= '1';
																		next3_state <= add_rst;
																	END IF;

																WHEN ad_ad3 => 
																	IF (CHARACTER'pos(insertion_command) = 52) THEN
																		admin_pass(3) <= insertion_command;
																		next3_state <= ad_ad4;
																	ELSE
																		add_finish <= '1';
																		next3_state <= add_rst;
																	END IF;

																WHEN ad_ad4 => 
																	IF (CHARACTER'pos(insertion_command) = 51) THEN
																		admin_pass(2) <= insertion_command;
																		next3_state <= ad_ad5;
																	ELSE
																		add_finish <= '1';
																		next3_state <= add_rst;
																	END IF;

																WHEN ad_ad5 => 
																	IF (CHARACTER'pos(insertion_command) = 50) THEN
																		admin_pass(1) <= insertion_command;
																		next3_state <= ad_ad6;
																	ELSE
																		add_finish <= '1';
																		next3_state <= add_rst;
																	END IF;

																WHEN ad_ad6 => 
																	IF (CHARACTER'pos(insertion_command) = 49) THEN
																		admin_pass(0) <= insertion_command;
																		next3_state <= adstar2;
																	ELSE
																		add_finish <= '1';
																		next3_state <= add_rst;
																	END IF;
																WHEN adstar2 => 
																	IF (CHARACTER'pos(insertion_command) = 42) THEN

																		next3_state <= ad_us;
																	ELSE
																		add_finish <= '1';
																		next3_state <= add_rst;
																	END IF;
																WHEN ad_us => 
																	IF (CHARACTER'pos(insertion_command) > 48 AND CHARACTER'pos(insertion_command) < 53) THEN
																		user_n <= insertion_command;
																		next3_state <= ad_finish;
																	ELSE
																		add_finish <= '1';
																		next3_state <= add_rst;
																	END IF;

																WHEN ad_finish => 
																	IF (CHARACTER'pos(insertion_command) = 35) THEN
																		IF (admin_pass = "654321") THEN
																			IF (user_n = '1') THEN
																				user_int := 1;
																			ELSIF (user_n = '2') THEN
																				user_int := 2;
																			ELSIF (user_n = '3') THEN
																				user_int := 3;
																			ELSIF (user_n = '4') THEN
																				user_int := 4;
																			ELSE
																				nothing <= '1';

																			END IF;
																			storage(user_int) <= new_user_pass;
																		ELSE
																			nothing <= '1';
																		END IF;
																	ELSE
																		nothing <= '1';
																	END IF;
																	add_finish <= '1';
																	next3_state <= add_rst;
																WHEN OTHERS => 
																	next3_state <= add_rst;
															END CASE;
														END PROCESS;

END Behavioral;