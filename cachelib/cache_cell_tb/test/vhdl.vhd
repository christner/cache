-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


architecture test of cache_cell_tb is

    component cache_cell port (
        enable_w: in std_logic;
        enable_r: in std_logic;
        data_w  : in std_logic;
        rst     : in std_logic;
        data_r  : out std_logic);
    end component;

    constant CLK_PERIOD : time := 10 ns;

    for cell_1 : cache_cell use entity work.cache_cell(structural);

    signal clock : std_logic;
    signal rst : std_logic := '1';
    signal enable_w : std_logic := '0';
    signal enable_r : std_logic := '0';
    signal data_w : std_logic := '0';
    signal data_r : std_logic := '0';

begin

    cell_1 : cache_cell port map (enable_w, enable_r, data_w, rst, data_r);

    clk : process
    begin  -- process clk

        clock <= '0','1' after CLK_PERIOD / 2;
        wait for CLK_PERIOD;

    end process clk;

    io: process
    begin -- process io

        -- async reset
        wait for CLK_PERIOD;
        rst <= '0';
        wait for CLK_PERIOD;

        -- write 0 and read
        wait for CLK_PERIOD;
        enable_w <= '1';

        wait for CLK_PERIOD;
        enable_w <= '0';

        wait for CLK_PERIOD;
        enable_r <= '1';

        wait for CLK_PERIOD;
        enable_r <= '0';

        -- write 1 and read
        data_w <= '1';
        wait for CLK_PERIOD;
        enable_w <= '1';

        wait for CLK_PERIOD;
        enable_w <= '0';

        wait for CLK_PERIOD;
        enable_r <= '1';

        wait for CLK_PERIOD;
        enable_r <= '0';

        wait; -- done

    end process io;

end test;
