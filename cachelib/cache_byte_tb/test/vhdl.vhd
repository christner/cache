-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


architecture test of cache_byte_tb is

component cache_byte port (
    enable_w: in std_logic;
    enable_r: in std_logic;
    data_w  : in std_logic_vector( 7 downto 0);
    rst     : in std_logic;
    data_r  : out std_logic_vector( 7 downto 0));
end component;

constant CLK_PERIOD : time := 10 ns;

for byte_1 : cache_byte use entity work.cache_byte(structural);

signal clock : std_logic;
signal rst : std_logic := '1';

signal enable_w : std_logic := '0';
signal enable_r : std_logic := '0';

signal data_w : std_logic_vector( 7 downto 0 ) := (others => '0');
signal data_r : std_logic_vector( 7 downto 0 ) := (others => '0');

begin

    -- map inputs to port
    byte_1 : cache_byte port map (enable_w, enable_r, data_w(7 downto 0), rst, data_r(7 downto 0));

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

        -- loop for values 0 to 255 (8 bits), write, then read back
        for i in 0 to 255 loop
            data_w <= STD_LOGIC_VECTOR(to_unsigned(i, 8));
            wait for CLK_PERIOD;
            enable_w <= '1'; -- write value to tag
            wait for CLK_PERIOD;
            enable_w <= '0';
            wait for CLK_PERIOD;
            enable_r <= '1'; -- read value from tag
            wait for CLK_PERIOD;
            enable_r <= '0';

        end loop;

        wait; -- done

    end process io;

end test;
