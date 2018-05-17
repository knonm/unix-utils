# Confirm the size of memory on a Linux server
grep MemTotal /proc/meminfo

# CPU fisica  
cat /proc/cpuinfo | grep "physical id" | sort -u | echo `wc -l`

# CPU cores
cat /proc/cpuinfo | grep "processor" | sort -u | echo `wc -l`

# Amount of memory and swap space
# In GB
free -g -t
# In MB
free -m -t

# OS version
cat /proc/version
uname -a
lsb_release -a
cat /etc/lsb-release

# Kernel information
uname -r
