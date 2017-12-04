-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


architecture test of state_machine_tb is

  component state_machine
    port (
    START : in std_logic;
    RESET : in std_logic;
    HitMiss : in std_logic;
    RdWr : in std_logic;
    CLOCK : in std_logic;
    BUSY : out std_logic;
    CacheEnable : out std_logic;
    OverwriteBlk : out std_logic;
    MemEnable : out std_logic);
  end component;



  for sm1 : state_machine use entity work.state_machine(structural);

  signal start, reset, hitmiss, rdwr, clk, clock, busy, cacheenable, overwriteblk, memenable: std_logic;

  signal clk_count: integer:=0;

procedure print_output is
   variable out_line: line;

   begin
   write (out_line, string' (" Clock: "));
   write (out_line, clk_count);
   write (out_line, string'(" Start: "));
   write (out_line, start);
   write (out_line, string'(" Cpu Read/Write: "));
   write (out_line, rdwr);
   write (out_line, string'(" hit miss: "));
   write (out_line, hitmiss);
   write (out_line, string'(" Reset: "));
   write (out_line, reset);
   writeline(output, out_line);

   write (out_line, string' (" cache enable: "));
   write (out_line, cacheenable);
   write (out_line, string'(" write entire block: "));
   write (out_line, overwriteblk);
   writeline(output, out_line);


   write (out_line, string'(" Busy: "));
   write (out_line, busy);
   write (out_line, string'(" Memory  Enable: "));
   write (out_line, memenable);
   writeline(output, out_line);

   write (out_line, string'(" ----------------------------------------------"));
   writeline(output, out_line);

end print_output;



begin

  clk <= clock;

  sm1 : state_machine port map (start, reset, hitmiss, rdwr, clk, busy, cacheenable, overwriteblk, memenable);

  clking : process
  begin
    clock<= '1', '0' after 5 ns;
    wait for 10 ns;
  end process clking;

  io_process: process

    file infile  : text is in "./sm_in.txt";
    variable out_line: line;
    variable buf: line;
    variable value: std_logic;
    variable value3 : std_logic_vector(2 downto 0);

  begin

    while not (endfile(infile)) loop

      wait until rising_edge(clock);
      print_output;

      readline(infile, buf);
      read(buf, value);
      reset <= value;

      readline(infile, buf);
      read(buf, value);
      start <= value;

      readline(infile, buf);
      read(buf, value);
      hitmiss <= value;

      readline(infile, buf);
      read(buf, value);
      rdwr <= value;

      wait until falling_edge(clock);

      clk_count <= clk_count+1;

      print_output;

    end loop;
    wait;

  end process io_process;


end test;
