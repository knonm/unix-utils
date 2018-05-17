#!/bin/ksh
# Format some info from ifconfig output, semicolon delimited

OUTFILE=check_ifconfig.csv

for srv in $(cat servers.txt)
do
ssh -q $srv "
hname=\$(hostname)
if [ \$(uname) == 'AIX' ]; then
for ifc in \$(ifconfig -a | grep -E \"^.*: .*\" | awk '{print \$1}' | sed 's/\\://')
do
  if [ \"\$ifc\" != \"lo0\" -a \"\$ifc\" != \"lo\" ]; then
    macaddr=\$(netstat -in | grep -E \"^(\$ifc) .*(link#)\" | awk '{print \$4}' | sed 's/\./:/g' | tr \"[a-z]\" \"[A-Z]\")
    macaddrnew=
    for i in 1 2 3 4 5 6
    do
      macsplit=\$(echo \$macaddr | cut -d : -f \$i)
      if [ \${#macsplit} = 1 ]; then
        macaddrnew=\$(echo \"\$macaddrnew\"\"0\"\"\$macsplit\")
      else
        macaddrnew=\$(echo \"\$macaddrnew\"\"\$macsplit\")
      fi
      if [ \$i != 6 ]; then
        macaddrnew=\$(echo \"\$macaddrnew\"\":\")
      fi
    done
    macaddr=\$(echo \$macaddrnew)
    for inet in \$(ifconfig \$ifc | grep -i \"inet \" | awk '{print \$2}')
    do
      echo \"\$hname;\$ifc;\$inet;\$macaddr\"
    done
  fi
done
else
for ifc in \$(/sbin/ifconfig -a | grep -E \"^.*Link encap:.*\" | awk '{print \$1}')
do
  macaddr=\$(/sbin/ifconfig | grep -E \"^(\$ifc) .*(HWaddr)\" | awk '{print \$5}')
  for inet in \$(/sbin/ifconfig \$ifc | grep -i \"inet addr:\" | awk '{print \$2}' | sed 's/addr\\://')
  do
    echo \"\$hname;\$ifc;\$inet;\$macaddr\"
  done
done
fi
"
done >> $OUTFILE
