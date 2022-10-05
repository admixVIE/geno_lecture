#!/bin/bash
echo "job starting"
echo "apple
pear
orange" > fruits.txt
for fruit in apple pear orange; do grep -v $fruit fileA.txt >> fileF.txt; done

ls *.txt

echo "job done"
exit

