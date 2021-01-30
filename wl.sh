#!/bin/bash

help()
{
   echo ""
   echo "Usage:  -w words (with , separator between each one)"
   echo -e "\t-m mode"
   echo -e "\t-o output file"
   echo -e "\t-s Minium Lenght (based on strings not on chars)"
   echo -e "\t-e Maximum Lenght (based on strings not on chars)"
   echo -e "\tExample ./wl.sh -w lol,asd,lulw -s 1 -e 3 -m 3 -o a.txt"
   exit 1 
}

while getopts "w:m:o:s:e:" opt
do
   case "$opt" in
      w ) words="$OPTARG" ;;
      m ) mode="$OPTARG" ;;
      o ) out="$OPTARG" ;;
      s ) s="$OPTARG" ;;
      e ) e="$OPTARG" ;;
      ? ) help 
   esac
done

if [ -z "$words" ] || [ -z "$mode" ] || [ -z "$s" ] || [ -z "$e" ]
then
   echo "Some or all of the parameters are empty";
   help
fi
if [[ "$mode" != "3" && -z "$out" ]]
then
   echo "Some or all of the parameters are empty";
   help
fi

rm -rf "/tmp/wl";
(mkdir "/tmp/wl") || { echo "Something went wrong when creating directories"; exit 1; };

if [[ "$mode" == "1" ]]
then
   len=$(($e-1));
eval echo "{$words}" > "/tmp/wl/1.txt";
for (( i=1; i <= len; ++i ))
do
   after="$( cat "/tmp/wl/$i.txt" | tr " " ","  )";
   eval echo "{$after}{$words}" > "/tmp/wl/$((i+1)).txt";
done
for (( x=$s; x <= $e; x++ ))
do
   if [[ "$x" == "$s" ]]
   then
   cat "/tmp/wl/$x.txt" | tr " " "\n" > "$out";
   else
   cat "/tmp/wl/$x.txt" | tr " " "\n" >> "$out";
   fi
done
rm -rf "tmp/wl";
fi

if [[ "$mode" == "2" ]]
then
line="";
incr=$s;
for (( i=1; i <= $s; ++i ))
do
   line+="{$words}";
done
for (( x=$s; x <= $e; ++x ))
do
eval echo "$line"  | tr " " "\n" > "/tmp/wl/$incr.txt" &
incr=$((incr+1));
line+="{$words}";
done
wait
cat "/tmp/wl/"* > "$out";
rm -rf "/tmp/wl";
fi

if [[ "$mode" == "3" ]]
then 
line="";
incr=$s;
for (( i=1; i <= $s; ++i ))
do
   line+="{$words}";
done
for (( x=$s; x <= $e; ++x ))
do
eval echo "$line"  | tr " " "\n" &
incr=$((incr+1));
line+="{$words}";
done
wait
rm -rf "/tmp/wl";
fi
