#!/bin/ksh
# Checks if filesystem 'fsname' exists and it's size on servers from 'servers.txt' file

FSNAME='/fsname'
OUT=fs_size_`date +%Y-%m-%d_%H-%M`.out
ERR=fs_size_`date +%Y-%m-%d_%H-%M`.err
TEMP_FS=fs_size_`date +%Y-%m-%d_%H-%M`.tmp

for svr in $(cat servers.txt)
do
  echo $svr 1>>$OUT 2>>$ERR

  if nc -w 3 -z $svr 22
  then

    ssh -q $svr "df -h | head -n1" 1>$TEMP_FS 2>$TEMP_FS

    cat $TEMP_FS | grep -i "df:" 1>>/dev/null 2>>/dev/null

    if [ "$?" = "0" ]
    then
      ssh -q $svr "df -g | head -n1" 1>$TEMP_FS
      ssh -q $svr "df -g | grep -i $FSNAME" 1>>$TEMP_FS
    else
      ssh -q $svr "df -h | head -n1" 1>$TEMP_FS
      ssh -q $svr "df -h | grep -i $FSNAME" 1>>$TEMP_FS
    fi

    while read fs
    do
      echo $fs 1>>$OUT 2>>$ERR
    done < $TEMP_FS

    echo "" 1>>$OUT 2>>$ERR

  else

    echo "Cannot connect to $svr ..." 1>>$OUT 2>>$ERR
    echo "" 1>>$OUT 2>>$ERR

  fi

done

rm $TEMP_FS 1>>/dev/null 2>>/dev/null
