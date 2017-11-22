# Building
To build everything, simply run 'make all'. To make the top modules run 'make chip_2_way' for 
the 2-way set associative cache, and 'make chip' for the direct mapped cache.

# generate an alphabetical list of entity pdfs
ls | grep -E "\.vhd" | sed 's/\.vhd//g' | xargs -L1 ./prettify.sh
mv *.ps ps/.
cd ps/
ls | grep -E "\.ps" | sed 's/\.ps//g' | xargs -L1 ./convert2pdf.sh
mv *.pdf ../pdfs/.
cd ../pdfs/ 
ls | grep -E "\.pdf" | xargs ./unite.sh
