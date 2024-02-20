#!/usr/bin/env nix-shell
#! nix-shell -i bash 
#! nix-shell -p lesspass-cli openssl gawk

# Define input and output directories
input_dir="encrypted"
output_dir="secrets"

# Ensure input directory exists
if [ ! -d "$input_dir" ]; then
    echo "Error: Input directory '$input_dir' not found."
    exit 1
fi

# Ensure output directory exists
mkdir -p "$output_dir" || { echo "Error: Failed to create output directory '$output_dir'. Exiting."; exit 1; }

# File containing the password
password_file="$output_dir/nixos_password.txt"

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
expected_hash="b57d28f4b02558146ffa1b27d84a84e30c9aa29cac9ea1ad0eb9b999f0ca9eb9"

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

    # Decrypt the file using OpenSSL
	 filename=$(basename "$file" .enc)
    openssl enc -d -aes-256-cbc -salt -pbkdf2 -in "$file" -out "$output_dir/$filename" -pass pass:"$nixos_password" || { echo "Failed to decrypt file '$filename'. Continuing..."; continue; }
done

echo "Decryption completed."

