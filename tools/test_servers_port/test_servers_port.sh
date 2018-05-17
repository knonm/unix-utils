LOG=/tmp/pinghost.log
REMOTEPORT=22
TIMEOUT=1

for REMOTEHOST in $(cat servers.txt)
do
  if nc -w $TIMEOUT -z $REMOTEHOST $REMOTEPORT; then
    echo "[OK]: ${REMOTEHOST}:${REMOTEPORT}" >> $LOG
  else
    echo "[NOK]: ${REMOTEHOST}:${REMOTEPORT} - Exit code from Netcat was ($?)." >> $LOG
  fi
done
