VCC		= run_ncvhdl.bash
VCC_FLAGS	= -messages -linedebug -smartorder 
VELAB		= run_ncelab.bash
VELAB_FLAGS	= -message -access rwc

all: cache_cell_tb tag_3_tb cache_byte_tb


cache_byte_tb~ : cache_byte~
	$(VCC) $(VCC_FLAGS) cache_byte_tb.vhd
	$(VELAB) $(VELAB_FLAGS) cache_byte_tb
	@touch cache_byte_tb~

.PHONY : cache_byte_tb
cache_byte_tb : cache_byte_tb~

cache_byte~ : cache_cell~ 
	$(VCC) $(VCC_FLAGS) cache_byte.vhd
	@touch cache_byte~

.PHONY : cache_byte
cache_byte : cache_byte~

tag_3_tb~ : tag_3~
	$(VCC) $(VCC_FLAGS) tag_3_tb.vhd
	$(VELAB) $(VELAB_FLAGS) tag_3_tb
	@touch tag_3_tb~

.PHONY : tag_3_tb
tag_3_tb : tag_3_tb~

tag_3~ : cache_cell~
	$(VCC) $(VCC_FLAGS) tag_3.vhd
	@touch tag_3~

.PHONY : tag_3
tag_3 : tag_3~

cache_cell_tb~ : cache_cell~ 
	$(VCC) $(VCC_FLAGS) cache_cell_tb.vhd
	$(VELAB) $(VELAB_FLAGS) cache_cell_tb
	@touch cache_cell_tb~

.PHONY : cache_cell_tb
cache_cell_tb : cache_cell_tb~

cache_cell~ : tx~ inverter~ dlatch~
	$(VCC) $(VCC_FLAGS) cache_cell.vhd
	@touch cache_cell~

.PHONY : cache_cell
cache_cell : cache_cell~

inverter~ : 
	$(VCC) $(VCC_FLAGS) inv_1.vhd
	@touch inverter~

.PHONY : inveter
inverter : inverter~

dlatch~ : 
	$(VCC) $(VCC_FLAGS) dlatch.vhd
	@touch inverter~

.PHONY : dlatch
dlatch : dlatch~

tx~ : 
	$(VCC) $(VCC_FLAGS) tx.vhd
	@touch inverter~

.PHONY : tx
tx : tx~

.PHONY : clean
clean :
	@rm -rf `find . -name "*~*"`
	@rm -rf *.log
