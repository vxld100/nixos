#!/usr/bin/env nix-shell
#! nix-shell -i bash 
#! nix-shell -p lesspass-cli openssl gawk
#! nix-shell -I https://github.com/NixOS/nixpkgs/archive/23.11.tar.gz

# Define input and output directories
input_dir="secrets"
output_dir="encrypted"

# Ensure input directory exists
if [ ! -d "$input_dir" ]; then
    echo "Error: Input directory '$input_dir' not found."
    exit 1
fi

# Ensure output directory exists
mkdir -p "$output_dir" || { echo "Error: Failed to create output directory '$output_dir'. Exiting."; exit 1; }

# File containing the password
password_file="$input_dir/nixos_password.txt"

# Check if password file exists
if [ -f "$password_file" ]; then
    # Read the password from the file
    nixos_password=$(cat "$password_file" | tr -d '\n')
else
    # Ensure LessPass CLI is installed
    if ! command -v lesspass > /dev/null; then
        echo "Error: LessPass CLI is not installed or not in the PATH."
        exit 1
    fi

    # Retrieve NixOS password securely from LessPass
    nixos_password=$(lesspass nixos admin | tr -d '\n' || { echo "Failed to retrieve NixOS password from LessPass. Exiting."; exit 1; })
fi

# Expected SHA256 hash of the password
expected_hash="3c72bc9ba880b03304eecfd837d5fdbdd68f53660db8bbf42e9c368b4a13b270"

# Calculate the SHA256 hash of the generated password
actual_hash=$(echo -n "$nixos_password" | sha256sum | awk '{print $1}')

# Compare the actual hash with the expected hash
if [ "$actual_hash" != "$expected_hash" ]; then
    echo "Error: Generated password does not match the expected hash."
    exit 1
fi

# Iterate through files in the input directory
for file in "$input_dir"/*; do
    # Skip if it's not a regular file
    [ -f "$file" ] || continue

    # Encrypt the file using OpenSSL with AES-256-CBC encryption
    filename=$(basename "$file")
    openssl enc -aes-256-cbc -salt -pbkdf2 -in "$file" -out "$output_dir/$filename.enc" -pass pass:"$nixos_password" || { echo "Failed to encrypt file '$filename'. Continuing..."; continue; }
done

echo "Encryption completed."

