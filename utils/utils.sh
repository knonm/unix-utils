# System variables / Environment variables
echo $ORACLE_HOME
echo $ORACLE_BASE
echo $ORACLE_SID
echo $LD_LIBRARY_PATH

printenv ORACLE_HOME
printenv ORACLE_BASE
printenv ORACLE_SID
printenv LD_LIBRARY_PATH

# Show all aliases
alias

# Date and format example
date +%Y-%m-%d_%H-%M-%S

# & - "script.sh" executes on background, releasing the terminal
# nohup - "script.sh" keeps running even with SIGHUP (e.g. exiting a remote session)
nohup ./script.sh &

# Another example of nohup with &
# The output will be written on the "nohup.out" file
nohup sqlplus "/ as sysdba" <<EOF &

SELECT 'aaa' FROM dual;
SELECT 'bbb' FROM dual;
EXIT

EOF

# The output will be written on the "file.txt" file
# The flag "s" in sqlplus means Silent Mode
nohup sqlplus -s  "/ as sysdba" <<EOF > file.txt &

SELECT 'aaa' FROM dual;
EXIT

EOF
