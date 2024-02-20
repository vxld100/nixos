# How to set up encryption

Handling hashes is terribly delicate. 
The best way to get the right hashes and 
saving them in the appropriate file is the
following

`$ LESSPASS_MASTER_PASSWORD='Master_password' lesspass nixos admin | tr -d '\n' | sha256sum | awk '{print $1}'`
`$ LESSPASS_MASTER_PASSWORD='Master_password' lesspass nixos admin | tr -d '\n' > secrets/nixos_password.txt`

Note that those trims seem to be necessary, for otherwise
one risks getting new lines after the password.

