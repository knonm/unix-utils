#!/bin/bash

#
# Answer to Stackoverflow question: https://stackoverflow.com/questions/49404432/storing-output-results-of-a-command-into-a-an-array
#

export errorLine='other problem'

# Simulating the command output
export result=$(cat <<EOF
12345 "compilation problem" fullScan.java
12346 "other problem" basicTest.java
64321 "other problem" basicTest2.java
EOF
)

# Using Perl regular expression to format the output to CSV format
perl -e '
($str = $ENV{result}) =~ s/"/""/g; # Replacing one doule quote by two double quote (escaping double quotes)

while($str =~ m/^(.+)\s+""$ENV{errorLine}""\s+(.+)$/mg) {
  print "\"$1\";\"$2\"\n";
}
' > output.csv

# Printing "output.csv" file
cat output.csv

# Output:
#
# "12346";"basicTest.java"
# "64321";"basicTest2.java"
#

while read -r line
do
  export linePerl="${line}"
  
  # Removing the double quotes and printing
  perl -e '
    @str = $ENV{linePerl} =~ m/;?"(.+?[^"])";?/g;
    print "@str[0]: @str[1]\n"
  '
done < output.csv

# Output:
#
# 12346: basicTest.java
# 64321: basicTest2.java
#

exit 0

