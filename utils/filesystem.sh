# Amount of space in the /tmp directory
df -h /tmp

# Amount of free disk space
df -h

# Ver espaco utilizado dos arquivos/diretorios
du -sh $(echo `ls`)

# List files ordered by size
du -skm * | sort -n

# find examples
find . -name "*.aud" -mtime +3
find . -name "*.aud" -mtime +3 | wc -l
find . -name "*.aud" -mtime +3 -exec rm {} \;
find . -name "*.aud" -mtime +3 | xargs rm
find . \( -name "*.xml" \) -mtime +60 -exec rm -f {} \;
find . \( -name "*.trc" -o -name "*.trm" \) -a -mtime +30 -exec cp {} /tmp \;
