#!/usr/bin/env bash

#
# ? Fetch DevBox SSH keys from Doppler
#

# Set global variables
D_PROJECT="devbox"
D_CONFIG="dev"

# Output files
PRIVATE_KEY_FILE="/root/.ssh/id_ed25519"
PUBLIC_KEY_FILE="/root/.ssh/id_ed25519.pub"

#
# ? Private key file
#
echo -e "\nCreating Private key file at '${PRIVATE_KEY_FILE}'"
[ -f "${PRIVATE_KEY_FILE}" ] && cat /dev/null > "${PRIVATE_KEY_FILE}" || touch "${PRIVATE_KEY_FILE}"

doppler secrets get "SSH_KEY_PRIVATE" --plain --project "$D_PROJECT" --config "$D_CONFIG" >> "${PRIVATE_KEY_FILE}"
chmod 0600 "${PRIVATE_KEY_FILE}"
echo "- Writing Private key..."

#
# ? Public key file
#
echo -e "\nCreating Public key file at '${PUBLIC_KEY_FILE}'"
[ -f "${PUBLIC_KEY_FILE}" ] && cat /dev/null > "${PUBLIC_KEY_FILE}" || touch "${PUBLIC_KEY_FILE}"

doppler secrets get "SSH_KEY_PUBLIC" --plain --project "$D_PROJECT" --config "$D_CONFIG" >> "${PUBLIC_KEY_FILE}"
chmod 0644 "${PUBLIC_KEY_FILE}"
echo "- Writing Public key..."

echo -e "\nDone. SSH keys written to files."
