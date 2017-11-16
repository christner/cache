VCC		= run_ncvhdl.bash
VCC_FLAGS	= -messages -linedebug -smartorder 
VELAB		= run_ncelab.bash
VELAB_FLAGS	= -message -access rwc

.PHONY : all
all : cache_cell_tb tag_3_tb cache_byte_tb cache_block_tb cache_set_tb

cache_set_tb~ : cache_set
	$(VCC) $(VCC_FLAGS) cache_set_tb.vhd
	$(VELAB) $(VELAB_FLAGS) cache_set_tb
	@touch cache_set_tb~

.PHONY : cache_set_tb
cache_set_tb : cache_set_tb~

cache_set~ : inverter and_2 or_2 and_3 cache_block
	$(VCC) $(VCC_FLAGS) cache_set.vhd
	@touch cache_set~

.PHONY : cache_set
cache_set : cache_set~

cache_block_tb~ : cache_block
	$(VCC) $(VCC_FLAGS) cache_block_tb.vhd
	$(VELAB) $(VELAB_FLAGS) cache_block_tb
	@touch cache_block_tb~

.PHONY : cache_block_tb
cache_block_tb : cache_block_tb~

cache_block~ : and_2 and_4~ or_4 tag_3 cache_byte
	$(VCC) $(VCC_FLAGS) cache_block.vhd
	@touch cache_block~

.PHONY : cache_block
cache_block : cache_block~

cache_byte_tb~ : cache_byte
	$(VCC) $(VCC_FLAGS) cache_byte_tb.vhd
	$(VELAB) $(VELAB_FLAGS) cache_byte_tb
	@touch cache_byte_tb~

.PHONY : cache_byte_tb
cache_byte_tb : cache_byte_tb~

cache_byte~ : cache_cell 
	$(VCC) $(VCC_FLAGS) cache_byte.vhd
	@touch cache_byte~

.PHONY : cache_byte
cache_byte : cache_byte~

tag_3_tb~ : tag_3
	$(VCC) $(VCC_FLAGS) tag_3_tb.vhd
	$(VELAB) $(VELAB_FLAGS) tag_3_tb
	@touch tag_3_tb~

.PHONY : tag_3_tb
tag_3_tb : tag_3_tb~

tag_3~ : cache_cell
	$(VCC) $(VCC_FLAGS) tag_3.vhd
	@touch tag_3~

.PHONY : tag_3
tag_3 : tag_3~

cache_cell_tb~ : cache_cell
	$(VCC) $(VCC_FLAGS) cache_cell_tb.vhd
	$(VELAB) $(VELAB_FLAGS) cache_cell_tb
	@touch cache_cell_tb~

.PHONY : cache_cell_tb
cache_cell_tb : cache_cell_tb~

cache_cell~ : tx inverter dlatch
	$(VCC) $(VCC_FLAGS) cache_cell.vhd
	@touch cache_cell~

.PHONY : cache_cell
cache_cell : cache_cell~

inverter~ :
	$(VCC) $(VCC_FLAGS) inverter.vhd
	@touch inverter~

.PHONY : inveter
inverter : inverter~

dlatch~ :
	$(VCC) $(VCC_FLAGS) dlatch.vhd
	@touch dlatch~

.PHONY : dlatch
dlatch : dlatch~

comparator_3~ : and_4 xnor_2
	$(VCC) $(VCC_FLAGS) comparator_3.vhd
	@touch comparator_3~

.PHONY : comparator_3
comparator_3 : comparator_3~

tx~ :
	$(VCC) $(VCC_FLAGS) tx.vhd
	@touch inverter~

.PHONY : tx
tx : tx~

.PRECIOUS : and_%~
and_%~  :
	$(VCC) $(subst ~,,$@).vhd
	@touch $@

.PHONY : and_%
and_% : and_%~
	@echo -n

.PRECIOUS : or_%~
or_%~ :
	$(VCC) $(subst ~,,$@).vhd
	@touch $@

.PHONY : or_%
or_% : or_%~
	@echo -n

.PRECIOUS : xnor_%~
xnor_%~ : xor_%
	$(VCC) $(subst ~,,$@).vhd
	@touch $@

.PHONY : xnor_%
xnor_% : xnor_%~
	@echo -n

.PRECIOUS : xor_%~
xor_%~ :
	$(VCC) $(subst ~,,$@).vhd
	@touch $@

.PHONY : xor_%
xor_% : xor_%~
	@echo -n

.PHONY : clean
clean :
	@rm -rf `find . -name "*~*"`
	@rm -rf *.log
