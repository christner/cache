#!/bin/bash

input=${1}
#shift
#header=${@}
echo "enscript --columns=2 --line-numbers --fancy-header --borders --landscape --pretty-print=vhdl --output ${input}.ps --header="${input}" ${input}.vhd"
$(enscript --columns=2 --line-numbers --fancy-header --borders --landscape --pretty-print=vhdl --output ${input}.ps --header="${input}" ${input}.vhd)

