# Generate RSA 1024 bits key
ssh-keygen -t rsa -b 1024

# Directory: $HOME/.ssh

# Authorize ssh client with public key from "id_rsa.pub" to connect into hostname1
cat id_rsa.pub | ssh -p 22 hostname1 ' >> $HOME/.ssh/authorized_keys'
