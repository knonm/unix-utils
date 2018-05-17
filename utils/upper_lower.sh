# Convert uppercase characters (from standard input) to lowercase characters (to standard output)
tr '[:upper:]' '[:lower:]' < input.txt > output.txt

# Convert lowercase characters (from standard input) to uppercase characters (to standard output)
tr '[:lower:]' '[:upper:]' < input.txt > output.txt

# Convert uppercase characters to lowercase characters (using pipe)
echo $VAR_NAME | tr '[:upper:]' '[:lower:]'

# Convert lowercase characters to uppercase characters (using pipe)
echo $VAR_NAME | tr '[:lower:]' '[:upper:]'
