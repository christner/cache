-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


architecture structural of cache_cell is

    component inverter port (
        input : in  std_logic;
        output: out std_logic);
    end component;

    component dlatch port (
        d   : in std_logic;
        clk : in std_logic;
        rst : in std_logic;
        q   : out std_logic;
        qbar: out std_logic);
    end component;

    component tx port (
        sel   : in std_logic;
        selnot: in std_logic;
        input : in std_logic;
        output:out std_logic);
    end component;

    for latch_0: dlatch use entity work.dlatch(structural);
    for inverter_0: inverter use entity work.inverter(structural);
    for tx_0: tx use entity work.tx(structural);

    signal enable_r_not, q : std_logic;

begin

    latch_0: dlatch port map (data_w, enable_w, rst, q, open);
    inverter_0: inverter port map (enable_r, enable_r_not);
    tx_0: tx port map (enable_r, enable_r_not, q, data_r);

end structural;
