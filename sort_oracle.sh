#/////////////////// Process input file ///////////////////
file_to_parse=$1
arg1=$2

if [ $# -eq 0 ]; then
    echo "No input file specified!"
    exit 1
fi

#/////////////////// Break Everything apart ///////////////////
a="$(cat $file_to_parse | awk 'NR > 1 {print $1}' RS='(' FS=')' | grep PROTOCOL | sed 's\PROTOCOL =\\g' | sed 's/ /, /g' | tr -d '[:blank:]')"

b="$(cat $file_to_parse | awk 'NR > 1 {print $1}' RS='(' FS=')' | grep HOST | sed 's\HOST =\\g' | sed 's/ /,/g' | tr -d '[:blank:]')"

c="$(cat $file_to_parse | awk 'NR > 1 {print $1}' RS='(' FS=')' | grep PORT | sed 's\PORT =\\g' | sed 's/ /,/g')"

d="$(cat $file_to_parse | awk 'NR > 1 {print $1}' RS='(' FS=')' | grep QUEUESIZE | sed 's\QUEUESIZE =\\g' | sed 's/ /,/g')"

e="$(cat $file_to_parse | awk 'NR > 1 {print $1}' RS='(' FS=')' | grep SERVER | sed 's\SERVER =\\g' | sed 's/ /,/g')"

f="$(cat $file_to_parse | awk 'NR > 1 {print $1}' RS='(' FS=')' | grep SID | sed 's\SID =\\g' | sed 's/ /,/g')"

g="$(cat $file_to_parse | awk 'NR > 1 {print $1}' RS='(' FS=')' | grep SERVICE_NAME | sed 's\SERVICE_NAME =\\g' | sed 's/ /,/g')"

h="$(cat $file_to_parse | sed 's/(.*)//' | sed 's/(.* //' | sed 's\=\\g' | sed 's\)\\g'| grep -i [a-z] | sed 's/ /|/g' | sed 's/\r/|/' | sed 's/|//g' | sed 's/$/,/'| tr -d '\n' | sed 's\,\ ,\g')"

#/////////////////// Create arrays for individual fields ///////////////////

###### Protocol ######
a1="$(echo $a | sed 's/ //g')"
IFS=' ,' read -r -a array <<< "$a1"
unset array[0]
array=( "${array[@]}" )

###### Host ######
b1="$(echo $b | sed 's/ //g')"
IFS=' ,' read -r -a array1 <<< "$b1"
unset array1[0]
array1=( "${array1[@]}" )

###### Port ######
c1="$(echo $c | sed 's/ //g')"
IFS=' ,' read -r -a array2 <<< "$c1"
unset array2[0]
array2=( "${array2[@]}" )

###### Queuesize ######
d1="$(echo $d | sed 's/ //g')"
IFS=' ,' read -r -a array3 <<< "$d1"
unset array3[0]
array3=( "${array3[@]}" )

###### server ######
e1="$(echo $e | sed 's/ //g')"
IFS=' ,' read -r -a array4 <<< "$e1"
unset array4[0]
array4=( "${array4[@]}" )

###### SID ######
f1="$(echo $f | sed 's/ //g')"
IFS=' ,' read -r -a array5 <<< "$f1"
unset array5[0]
array5=( "${array5[@]}" )

###### service name ######
g1="$(echo $g | sed 's/ //g')"
IFS=' ,' read -r -a array6 <<< "$g1"
unset array6[0]
array6=( "${array6[@]}" )

###### primaryname ######
echo " "
h1="$(echo $h | sed 's/ //g')"
IFS=' ,' read -r -a array7 <<< "$h1"

#///////////////////////// Combine Arrays into CSV //////////////////////////


if [[ "$arg1" == "-d" ]]; then


for ((i=0; i<=${#array[@]}; i++)); do

printf '%s %s %s %s %s %s %s \n' "${array7[i]}," "${array[i]}," "${array1[i]}," "${array2[i]}," "${array4[i]}," "${array5[i]}," "${array6[i]}" | sed '/^$/d;s/[[:blank:]]//g'
done

elif [[ "$arg1" == "-e" ]];
then
for ((i=0; i<=${#array[@]}; i++)); do

printf '%s %s %s %s %s %s %s \n' "${array7[i]}," "${array[i]}," "${array1[i]}," "${array2[i]}," "${array3[i]}," "${array5[i]}," "${array6[i]}" | sed '/^$/d;s/[[:blank:]]//g'
done

elif [[ "$arg1" == "-f" ]];
then
for ((i=0; i<=${#array[@]}; i++)); do

printf '%s %s %s %s %s %s %s \n' "${array7[i]}," "${array[i]}," "${array1[i]}," "${array2[i]}," "${array3[i]}," "${array4[i]}," "${array6[i]}" | sed '/^$/d;s/[[:blank:]]//g'
done

elif [[ "$arg1" == "-g" ]];
then
for ((i=0; i<=${#array[@]}; i++)); do

printf '%s %s %s %s %s %s %s \n' "${array7[i]}," "${array[i]}," "${array1[i]}," "${array2[i]}," "${array3[i]}," "${array4[i]}," "${array5[i]}" | sed '/^$/d;s/[[:blank:]]//g'

done

elif [[ "$arg1" == "-h" ]];

then
for ((i=0; i<=${#array[@]}; i++)); do

printf '%s %s %s %s \n' "${array7[i]}," "${array[i]}," "${array1[i]}," "${array2[i]}" | sed '/^$/d;s/[[:blank:]]//g'
done

elif [[ "$arg1" == "" ]];

then
for ((i=0; i<=${#array[@]}; i++)); do

printf '%s %s %s %s %s %s %s %s \n' "${array7[i]}," "${array[i]}," "${array1[i]}," "${array2[i]}," "${array3[i]}," "${array4[i]}," "${array5[i]}," "${array6[i]}" | sed '/^$/d;s/[[:blank:]]//g'
done
fi