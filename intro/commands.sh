cd bla
cd ..
ls bla/
ls -lh bla/
mkdir blabla 
cp fileA.txt fileB.txt 
mv fileB.txt fileC.txt 
rm fileC.txt
pwd
ls bla/file*.txt 
echo "this is some random text" 
random_name="this is some random text" 
echo $random_name
$random_name 
more fileA.txt
less fileA.tx
cat fileA.txt
wc fileA.txt
wc -l fileA.txt
head fileA.txt
head -n 7 fileA.txt
tail fileA.txt 
tail -n 7 fileA.txt 
grep "apple" fileA.txt
grep -v "apple" fileA.txt 
grep -c "apple" fileA.txt 
cut -f2-3 fileA.txt 
cut -f2-3 -d " " fileA.txt 
grep -v "apple" fileA.txt > fileD.txt 
grep -v "apple" fileB.txt >> fileD.txt 
grep -v "apple" fileA.txt | cut -f2-3 > fileE.txt 
sort fileA.txt 
sort -n fileA.txt 
uniq fileA.txt
sort fileA.txt | uniq 
sort fileA.txt | uniq | wc -l
cat fileA.txt | grep -v "apple" - - 2> error.txt | cut -f2-3 > fileE.txt
for num in 1 2 3; do echo $num; done

if [ -f fileN.txt ]
then echo "file exists"
else echo "no such file"
fi 

grep -E "apple|pear" fileA.txt 
grep -E "[aoi]pple" fileA.txt 
grep -E ".pple" fileA.txt 
grep -E "^3" fileA.txt
awk '{ print $3 }' fileA.txt
awk '$2=="apple" { print $3 }' fileA.txt
awk 'length($2)==4 { print $2,$3 }' fileA.txt
sed 's/apple/orange/g' fileA.txt
sed 's/[aeiou]//g' fileA.txt
sed '4,10 s/apple/app/' fileA.txt
sed '5,20 s/[aeiou]//g' fileA.txt
sed '9d' fileA.txt
awk '$2=="apple"' fileA.txt | sed 's/apple/pear/g' | sort -n > fileG.txt





