# System variables / Environment variables
echo $VAR1
echo $VAR2
echo $VAR3
echo $VAR4

printenv VAR1
printenv VAR2
printenv VAR3
printenv VAR4

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
