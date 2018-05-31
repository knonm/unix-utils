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

# Replacing one doule quote by two double quote (escaping double quotes)
result=$(perl -e '($str = $ENV{result}) =~ s/"/""/g; print "$str";')

# Declaring an associative array
declare -A errorsArray

export paramID
export paramName

while read -r line
do
  export linePerl="${line}"
  
  # Prints the columns enclosed by double quotes, which is why I escaped double quotes before
  export regexEval=$(perl -e '
    if($ENV{linePerl} =~ m/^(.+?)\s+""$ENV{errorLine}""\s+?(.+)$/s) {
      print "\"$1\";\"$2\"";
    }
  ')
  
  # Checks if the line matches the pattern
  if [[ ! -z "${regexEval}" ]]
  then
    paramID=$(perl -e '$str = ($ENV{regexEval} =~ m/;?"(.+?[^"])";?/g)[0]; print "$str";')
    paramName=$(perl -e '$str = ($ENV{regexEval} =~ m/;?"(.+?[^"])";?/g)[1]; print "$str";')

    errorsArray["${paramID}"]="${paramName}"
  fi
done <<< "$result"

# Prints the associative array
for i in "${!errorsArray[@]}"
do
  echo "${i}: ${errorsArray[$i]}"
done

unset result
unset errorLine
unset errorsArray
unset regexEval
unset paramID
unset paramName
unset linePerl

exit 0

