#!/bin/bash
# Copy files to servers from 'servers.txt' file, using a gateway server

SERVERS=$(pwd)/servers.txt
USERNAME=username
GATEWAY=gateway_hostname
SSHPORT=22
FOLDER="/tmp/dir"
FNAME=fname
LOG=~/cp_scripts_$(date +%Y-%m-%d_%H-%M).log

cd ~ 1>>/dev/null 2>&1

echo ""
echo "Preparing files ..."
echo ""

rm $FNAME.tar 1>>/dev/null 2>&1

tar -cvf mcanon.tar -C $FOLDER $FNAME/ 1>>/dev/null 2>&1

scp -q -P $SSHPORT $FNAME.tar $USERNAME@$GATEWAY:~ 1>>$LOG 2>&1

ssh -q -p $SSHPORT $USERNAME@$GATEWAY "cd ~; rm -rf $FNAME/; tar -xvf $FNAME.tar" 1>>$LOG 2>&1

for svr in $(cat $SERVERS)
do

  echo ""
  echo "Copying to server $svr ..."
  echo ""

  cmd="ssh -q $svr -p $SSHPORT 'cd ~; rm -rf $FNAME/; tar -xvf $FNAME.tar; rm $FNAME.tar'"

  ssh -q -p $SSHPORT $USERNAME@$GATEWAY "scp -q -P $SSHPORT ~/$FNAME.tar $USERNAME@$svr:~" 1>>$LOG 2>&1

  ssh -q -p $SSHPORT $USERNAME@$GATEWAY "$cmd" 1>>$LOG 2>&1

done

ssh -q -p $SSHPORT $USERNAME@$GATEWAY "cd ~; rm $FNAME.tar" 1>>$LOG 2>&1

rm $FNAME.tar 1>>/dev/null 2>&1

exit 0
