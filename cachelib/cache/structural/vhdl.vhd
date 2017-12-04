-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


architecture structural of cache is

    component inverter port (
        input : in std_logic;
        output: out std_logic);
    end component;

    component and_2 port (
        input1 : in std_logic;
        input2 : in std_logic;
        output: out std_logic);
    end component;

    component or_2 port (
        input1: in std_logic;
        input2: in std_logic;
        output: out std_logic);
    end component;

    component comparator_3 port (
        input1: in std_logic_vector( 2 downto 0 );
        input2: in std_logic_vector( 2 downto 0 );
        output: out std_logic);
    end component;

    component dlatch port (
        d   : in std_logic;
        clk : in std_logic;
        rst : in std_logic;
        q   : out std_logic;
        qbar: out std_logic);
    end component;

    component dlatch_3 port (
        data      : in std_logic_vector( 2 downto 0 );
        clk       : in std_logic;
        rst       : in std_logic;
        output    : out std_logic_vector( 2 downto 0 );
        output_bar: out std_logic_vector( 2 downto 0 ));
    end component;

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

    for inverter_0 : inverter use entity work.inverter(structural);

    for or_2_tmp_w_r : or_2 use entity work.or_2(structural);

    for and_2_tmp_w, and_2_tag_eq, and_2_write_valid : and_2 use entity work.and_2(structural);

    for dlatch_1, dlatch_2 : dlatch use entity work.dlatch(structural);

    for dlatch_3_tag : dlatch_3 use entity work.dlatch_3(structural);

    for comparator_3_tag : comparator_3 use entity work.comparator_3(structural);

    for cache_set_0 : cache_set use entity work.cache_set(structural);

    signal tmp_w, tmp_w_r : std_logic;

    signal w_r_not, latch_output : std_logic;
    signal tmp_valid_out, valid_out, valid_write : std_logic;
    signal tmp_tag_out, tag_out : std_logic_vector( 2 downto 0 );

    signal tmp_tag_eq, tmp_hit_miss : std_logic;

    signal vdd : std_logic := '1';
    signal gnd : std_logic := '0';

begin

    -- lets start with a non-set-associative cache
    -- invert for easy use
    inverter_0 : inverter port map (w_r, w_r_not);

    -- before we write to the cache, we want to make sure that the data is actually there -- ie, we are writing, AND its valid
    and_2_tmp_w : and_2 port map (w_r, valid_write, tmp_w);

    -- however, if we are overwriting, we will force the write to occur
    or_2_tmp_w_r : or_2 port map (tmp_w, overwrite, tmp_w_r);

    -- map onto each set
    cache_set_0 : cache_set port map (enable, tmp_w_r, address(7 downto 0), data_w(7 downto 0), rst, tmp_valid_out, tmp_tag_out(2 downto 0), data_r(7 downto 0));

    -- we need to latch the valid bit to allow our sequential logic to work continuously
    dlatch_1 : dlatch port map(tmp_valid_out, w_r_not, rst, valid_out, open);

    -- we need to latch for our sequential logic to work continuously - we can latch this when we latch the valid bits
    dlatch_3_tag : dlatch_3 port map(tmp_tag_out(2 downto 0), w_r_not, rst, tag_out(2 downto 0), open);

    -- check if we have a tag match
    comparator_3_tag : comparator_3 port map (address(7 downto 5), tag_out(2 downto 0), tmp_tag_eq);

    -- check if tags are valid
    and_2_tag_eq : and_2 port map (tmp_tag_eq, valid_out, tmp_hit_miss);

    -- every time the enable signal goes low, we want this to also be low
    and_2_write_valid : and_2 port map(tmp_hit_miss, enable, valid_write);

    dlatch_2 : dlatch port map(tmp_hit_miss, vdd, rst, hit_miss);


end structural;
