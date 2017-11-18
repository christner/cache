----------------------------------------------------------------------------------------------
--
-- Entity: cache_cell
-- Architecture : structural
-- Author: danielc3
-- Created On: 11/10/2017
-- Description:
--
----------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity cache_cell is port (
    enable_w: in std_logic;
    enable_r: in std_logic;
    data_w  : in std_logic;
    rst     : in std_logic;
    data_r  : out std_logic);
end cache_cell;

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

    signal enable_r_not, q, qbar : std_logic;

begin

    latch_0: dlatch port map (data_w, enable_w, rst, q, qbar);
    inverter_0: inverter port map (enable_r, enable_r_not);
    tx_0: tx port map (enable_r, enable_r_not, q, data_r);

end structural;

----------------------------------------------------------------------------------------------
