-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


architecture test of cache_set_tb is

    component cache_set port (
        enable_set: in std_logic;
        w_r       : in std_logic;
        address   : in std_logic_vector( 7 downto 0 );
        data_w    : in std_logic_vector( 7 downto 0 );
        rst       : in std_logic;
        valid_r   : out std_logic;
        tag_r     : out std_logic_vector( 2 downto 0 );
        data_r    : out std_logic_vector( 7 downto 0 ));
    end component;

    constant CLK_PERIOD : time := 10 ns;
    constant WRITE_ENABLE : std_logic := '1';
    constant READ_ENABLE : std_logic := '0';

    for set_0 : cache_set use entity work.cache_set(structural);

    signal clock : std_logic;
    signal rst : std_logic := '1';
    signal enable_set, w_r : std_logic := '0';
    signal address : std_logic_vector( 7 downto 0 ) := ( others => '0' );
    signal data_w : std_logic_vector( 7 downto 0 ) := ( others => '0' );

    signal valid_r : std_logic := '0';
    signal tag_r : std_logic_vector( 2 downto 0 )  := ( others => '0' );
    signal data_r : std_logic_vector( 7 downto 0 ) := ( others => '0' );

begin

    -- map inputs and ouputs
    set_0 : cache_set port map (enable_set, w_r, address(7 downto 0), data_w(7 downto 0), rst, valid_r, tag_r(2 downto 0), data_r(7 downto 0));

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

        for i in 0 to 1 loop
            enable_set <= std_logic(to_unsigned(i, 1)(0));

            w_r <= READ_ENABLE;
            wait for CLK_PERIOD;

            for j in 0 to 255 loop

                -- put address and data in place
                address <= std_logic_vector(to_unsigned(j, 8));
                data_w <= std_logic_vector(to_unsigned(j, 8));

                -- write
                wait for CLK_PERIOD;
                w_r <= WRITE_ENABLE;

                -- read
                wait for CLK_PERIOD;
                w_r <= READ_ENABLE;

            end loop;

        end loop;

        wait; -- done

    end process io;

end test;
