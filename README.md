# wlgen
Wordlist Generator made in shell script
## Usage
***This script take many arguments***

***Basic syntax***
```
$ ./wl.sh -w <words/chars> -m <mode> -s <minlength> -e <maxlength> -o <output file>
```
## Mode of Permutation ( -m ) ***(Remember to append the output with -m 3, see Ouput File below)***
```
-m 1 is the slowest method but it use a little amount of ram (Not recommended)
-m 2 is much stronger than -m 1 but it use "some" ram (Recommended if you have from 2gb to 4gb of it)
-m 3 is the most powerful but all output are in STDOUT, maybe even more ram are required (Recommended in general)
```

## Words ( -w )
#### Words or chars must be written with a "," between each one
```
Taken 3 words (test 01 out) --> -w test,01,out
If you put some escape char like ! or | ... --> Put it after a \ --> -w hi,we,are,\!,here
```

## Min Length ( -s )
#### This will set the min words to concatenate !!! NOT THE MIN CHARACTER/S
```
-s 2 -w test,01,out --> Output will start from 2 words --> test01 testout out01 ...
Obviusly with -s 2 --> These strings are omitted ---> test 01 out --> Not in output 
```

## Max Length ( -e )
#### This will set the max words to concatenate !!! NOT THE MAX CHARACTER/S
```
-s 1 -e 1 -w test,01,out --> Output will start from 1 and stop to 1 --> test out 01 
-s 1 -e 2 -w test,01,out --> Output will start from 1 and stop to 2 --> test out 01 test01 01out 01test outtest ...
-s 1 -e 3 -w test,01,out --> Output will start from 1 and stop to 3 --> test out 01 test01 01out 01test outtest test01out outtest01 ...
-s 1 -e 4 -w test,01,out --> Output will start from 1 and stop to 3 --> ... test01outtest testout01test ...
```

## Output File ( -o )
### NOTE THAT IF YOU USE -m 3 YOU MUST APPEND THE OUTPUT AND NOT PUT -o ***file***
```
$ ./wl.sh -w a,b,c -s 1 -e 3 -m 3 >> out.txt
```
### FOR -m 1 and -m 2
```
$ ./wl.sh -s 1 -e 3 -w a,b,c -m 1 -o wl.txt (Will create wl.txt on the current path of the script)
$ ./wl.sh -s 1 -e 3 -w a,b,c -m 2 -o ~/Desktop/wl.txt (As written... of course)
```

## Full sample syntax
#### 5 Words: ( 2021 hi we are here )
#### Savage Mode ( -m 3 )
#### All length perms ( -s 1 -e 5)
```
$ ./wl.sh -w 2021,hi,we,are,here -m 3 -s 1 -e 5 >> outwl.txt
Timed Output
real	0m0.041s
user	0m0.040s
sys	0m0.023s
Perms Count
cat outwl.txt | wc -l -> 3905
```
#### 5 Words: ( 2021 hi we are here )
#### Slow Mode ( -m 1 )
#### All length perms ( -s 1 -e 5)
```
$ ./wl.sh -w 2021,hi,we,are,here -m 1 -s 1 -e 5 -o outwl.txt
Timed Output
real	0m0.076s
user	0m0.053s
sys	0m0.041s
Perms Count
cat outwl.txt | wc -l -> 3905 Of course are the same as before
