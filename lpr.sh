#!/bin/sh

EXPECTED_ARGS=1
E_BADARGS=1
SUCCESS=0

if [ $# -ne $EXPECTED_ARGS ]
then
    echo "Usage: ./lpr <input.img>"
    exit $E_BADARGS
fi

rm -f output.txt
./1_text_isolation/txtiso.out $1 > /dev/null 2>&1
./2_character_segmentation/charsegm.out final.png > /dev/null 2>&1
rm final.png
for i in letter*.png;
do
    ./3_ocr/ocr.out $i | grep '[Α-Ω0-9]' | perl -p -e 's/[^Α-Ω0-9]+//g' >> output.txt 
    rm $i
done

head output.txt
printf "\n"

exit $SUCCESS
