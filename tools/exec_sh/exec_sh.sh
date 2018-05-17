#!/bin/ksh
# Execute 'script.sh' on the servers listed in 'exec_sh.txt'

OUTFILE=exec_sh_`date +%d-%m-%y_%H%M`.out
ERRFILE=exec_sh_`date +%d-%m-%y_%H%M`.err
CMDFILE=script.sh

COUNTLN=1
CNTCMDFILE=`cat $CMDFILE | wc -l`

while read cmds
do

  if [ $CNTCMDFILE -eq $COUNTLN ];
  then
    CMDVAR=$CMDVAR""$cmds
  else
    CMDVAR=$CMDVAR""$cmds";"
  fi

  COUNTLN=`expr $COUNTLN + 1`

done < $CMDFILE

echo "=============================================================" 1>>$OUTFILE
echo "=============================================================" 1>>$ERRFILE

for srv in $(cat servers.txt)
do

  echo "$srv" 1>>$OUTFILE
  echo "$srv" 1>>$ERRFILE
  echo "" 1>>$OUTFILE
  echo "" 1>>$ERRFILE

  ssh -q -p 22 -x user@$srv "$CMDVAR" 1>>$OUTFILE 2>>$ERRFILE

  echo "" 1>>$OUTFILE
  echo "" 1>>$ERRFILE
  echo "=============================================================" 1>>$OUTFILE
  echo "=============================================================" 1>>$ERRFILE

done
