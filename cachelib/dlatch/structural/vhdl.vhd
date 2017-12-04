-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


architecture structural of dlatch is
begin

    output: process (d,clk)
    begin
        if rst = '1'
        then

            q <= '0';
            qbar <= '1';

        elsif clk = '1'
        then

            q <= d;
            qbar <= not d ;

        end if;
    end process output;

end structural;
