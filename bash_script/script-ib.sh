#!/bin/bash
# remove the file of result
echo "name" "time" > /tmp/file-result
awk -F'|' '{print $3}' file-ib | uniq > file  #in this file i have names
while IFS= read -r var		#looping for each name
do
        grep -w $var file-ib | cut -d "|" -f 1,5 > /tmp/$var-file	#split time and state in file
        awk -F" " '{ print $5,$6,$7,$8,$9 }' /tmp/$var-file  | awk -F"|" '{print $1,$2}' | awk -F " " '{print $1,$3,$4,$5,$6}' > /tmp/$var-file2 # split specific time and state in file 

#for the same time and have login , change password and log off
z=`awk -F " " '{print $1}' /tmp/$var-file2 | uniq | awk -F" " '{print $1}'`  #save each time for each user
echo $z > /tmp/file
c=`awk -F" " '{print NF}' /tmp/file` 	#count if each user enter more than one
for (( i=1; i<=$c; i++ )) 
do
y=`awk -F" " '{print $'$i'}' /tmp/file` 
grep $y /tmp/$var-file2 > /tmp/$var-file3
 awk -F " " '{ print $2,$3,$4 }' /tmp/$var-file3 | uniq > /tmp/$var-file32
#cat /tmp/$var-file3 | uniq > /tmp/$var-file32
diff -B <(sort file-t) <(sort /tmp/$var-file32) > /dev/null
if [ $? -eq 0 ]
then
echo $var $y 
fi
done
done < file
# remove the files
while IFS= read -r var2
do
rm /tmp/$var2-file*
done < file
rm file /tmp/file 
