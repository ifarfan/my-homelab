#!/usr/bin/env bash

#
# ? Fetch secrets from Doppler and write to INI files for Task + Ansible + Terraform
#

# Set global variables
D_PROJECT="my-homelab"
D_CONFIG="dev"

# Output files
TASK_ENV_FILE=".env"
ANSIBLE_INI_FILE="ansible/credentials.ini"
TERRAFORM_VARS_FILE="terraform/secrets.auto.tfvars"


#
# ? Task .ENV file
#
echo -e "\nCreating Task ENV file at '${TASK_ENV_FILE}'"
[ -f "${TASK_ENV_FILE}" ] && cat /dev/null > "${TASK_ENV_FILE}" || touch "${TASK_ENV_FILE}"

echo "# Generated on $(date)" >> "${TASK_ENV_FILE}"
doppler secrets get "TASK_FILE" --plain --project "$D_PROJECT" --config "$D_CONFIG" >> "${TASK_ENV_FILE}"
echo "- Writing Task secrets..."


#
# ? Ansible INI file
#
echo -e "\nCreating Ansible INI file at '${ANSIBLE_INI_FILE}'"
[ -f "${ANSIBLE_INI_FILE}" ] && cat /dev/null > "${ANSIBLE_INI_FILE}" || touch "${ANSIBLE_INI_FILE}"
echo "# Generated on $(date)" >> "${ANSIBLE_INI_FILE}"

# loop thru secrets and write to INI file
SEC_ARRAY=( $(doppler secrets --only-names --json --project "$D_PROJECT" --config "$D_CONFIG" | jq -r 'keys[]') )
for SEC in "${SEC_ARRAY[@]}"; do
    # ignore doppler internal variables
    if [[ ${SEC} != *"DOPPLER_"* ]]; then
        JSON_STRING=$(doppler secrets get "${SEC}" --plain --project "$D_PROJECT" --config "$D_CONFIG")
        if jq -e . >/dev/null 2>&1 <<<"$JSON_STRING"; then
            echo "- Writing [${SEC,,}] secrets..."

            echo -e "\n[${SEC,,}]" >> "${ANSIBLE_INI_FILE}"
            echo "${JSON_STRING}" | jq -r 'to_entries[] | "\(.key)=\(.value)"' >> "${ANSIBLE_INI_FILE}"
        fi
    fi
done


#
# ? Terraform .vars file
#
echo -e "\nCreating Terraform Vars file at '${TERRAFORM_VARS_FILE}'"
[ -f "${TERRAFORM_VARS_FILE}" ] && cat /dev/null > "${TERRAFORM_VARS_FILE}" || touch "${TERRAFORM_VARS_FILE}"

echo "# Generated on $(date)" >> "${TERRAFORM_VARS_FILE}"
for SEC in "proxmox" "cloudflare" "github"; do
    JSON_STRING=$(doppler secrets get "${SEC^^}" --plain --project "$D_PROJECT" --config "$D_CONFIG")
    if jq -e . >/dev/null 2>&1 <<<"$JSON_STRING"; then
        SEC=${SEC,,}
        echo "- Writing [${SEC^}] secrets..."

        echo -e "\n# ${SEC^}" >> "${TERRAFORM_VARS_FILE}"
        echo "${JSON_STRING}" | jq -r "to_entries[] | \"${SEC}_\(.key)=\\\"\(.value)\\\"\"" >> "${TERRAFORM_VARS_FILE}"
    fi
done

echo -e "\nDone. Secrets written to files."
