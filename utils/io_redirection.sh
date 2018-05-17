COMMAND_OUTPUT >
   # Redirect stdout to a file.
   # Creates the file if not present, otherwise overwrites it.

   ls -lR > dir-tree.list
   # Creates a file containing a listing of the directory tree.

: > filename
   # The > truncates file "filename" to zero length.
   # If file not present, creates zero-length file (same effect as 'touch').
   # The : serves as a dummy placeholder, producing no output.

> filename    
   # The > truncates file "filename" to zero length.
   # If file not present, creates zero-length file (same effect as 'touch').
   # (Same result as ": >", above, but this does not work with some shells.)

COMMAND_OUTPUT >>
   # Redirect stdout to a file.
   # Creates the file if not present, otherwise appends to it.


   # Single-line redirection commands (affect only the line they are on):
   # --------------------------------------------------------------------

1>filename
   # Redirect stdout to file "filename."
1>>filename
   # Redirect and append stdout to file "filename."
2>filename
   # Redirect stderr to file "filename."
2>>filename
   # Redirect and append stderr to file "filename."
&>filename
   # Redirect both stdout and stderr to file "filename."
   # This operator is now functional, as of Bash 4, final release.

M>N
  # "M" is a file descriptor, which defaults to 1, if not explicitly set.
  # "N" is a filename.
  # File descriptor "M" is redirect to file "N."
M>&N
  # "M" is a file descriptor, which defaults to 1, if not set.
  # "N" is another file descriptor.

   #==============================================================================

   # Redirecting stdout, one line at a time.
   LOGFILE=script.log

   echo "This statement is sent to the log file, \"$LOGFILE\"." 1>$LOGFILE
   echo "This statement is appended to \"$LOGFILE\"." 1>>$LOGFILE
   echo "This statement is also appended to \"$LOGFILE\"." 1>>$LOGFILE
   echo "This statement is echoed to stdout, and will not appear in \"$LOGFILE\"."
   # These redirection commands automatically "reset" after each line.



   # Redirecting stderr, one line at a time.
   ERRORFILE=script.errors

   bad_command1 2>$ERRORFILE       #  Error message sent to $ERRORFILE.
   bad_command2 2>>$ERRORFILE      #  Error message appended to $ERRORFILE.
   bad_command3                    #  Error message echoed to stderr,
                                   #+ and does not appear in $ERRORFILE.
   # These redirection commands also automatically "reset" after each line.
   #=======================================================================

2>&1
   # Redirects stderr to stdout.
   # Error messages get sent to same place as standard output.
     >>filename 2>&1
         bad_command >>filename 2>&1
         # Appends both stdout and stderr to the file "filename" ...
     2>&1 | [command(s)]
         bad_command 2>&1 | awk '{print $5}'   # found
         # Sends stderr through a pipe.
         # |& was added to Bash 4 as an abbreviation for 2>&1 |.

i>&j
   # Redirects file descriptor i to j.
   # All output of file pointed to by i gets sent to file pointed to by j.

>&j
   # Redirects, by default, file descriptor 1 (stdout) to j.
   # All stdout gets sent to file pointed to by j.

0< FILENAME
 < FILENAME
   # Accept input from a file.
   # Companion command to ">", and often used in combination with it.
   #
   # grep search-word <filename


[j]<>filename
   #  Open file "filename" for reading and writing,
   #+ and assign file descriptor "j" to it.
   #  If "filename" does not exist, create it.
   #  If file descriptor "j" is not specified, default to fd 0, stdin.
   #
   #  An application of this is writing at a specified place in a file. 
   echo 1234567890 > File    # Write string to "File".
   exec 3<> File             # Open "File" and assign fd 3 to it.
   read -n 4 <&3             # Read only 4 characters.
   echo -n . >&3             # Write a decimal point there.
   exec 3>&-                 # Close fd 3.
   cat File                  # ==> 1234.67890
   #  Random access, by golly.



|
   # Pipe.
   # General purpose process and command chaining tool.
   # Similar to ">", but more general in effect.
   # Useful for chaining commands, scripts, files, and programs together.
   cat *.txt | sort | uniq > result-file
   # Sorts the output of all the .txt files and deletes duplicate lines,
   # finally saves results to "result-file".