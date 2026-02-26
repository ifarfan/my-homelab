# Oracle Cloud

Running a VM on the [Oracle Cloud](https://www.oracle.com/cloud/) for tasks and workloads that require an external endpoint

### Oracle CLI
1. Install the Oracle CLI
    ```shell
    brew update && brew install oci-cli
    ```
1. Configure Oracle CLI
    ```shell
    # Vars
    MY_PROJECT=oracle
    MY_ENV=dev

    # Check that we are logged in to Doppler, else run "doppler login"
    doppler me

    mkdir ~/.oci

    # Configure cli RC
    touch ~/.oci/oci_cli_rc
    doppler secrets get "OCI_CLI_RC" --plain --project "${MY_PROJECT}" --config "${MY_ENV}" > ~/.oci/oci_cli_rc

    # Fetch cli config
    touch ~/.oci/config
    doppler secrets get "LOCAL_CONFIG" --plain --project "${MY_PROJECT}" --config "${MY_ENV}" > ~/.oci/config
    chmod 0600 ~/.oci/config

    # Fetch cli PEM
    touch ~/.oci/my.pem
    doppler secrets get "LOCAL_MY_PEM" --plain --project "${MY_PROJECT}" --config "${MY_ENV}" > ~/.oci/my.pem
    chmod 0600 ~/.oci/my.pem
    ```

### Docs:
- Installing the [CLI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm)
- Configure [IAM permissions](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm#two) for CLI user
- Use a [docker image](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/clicontainer.htm), instead, for CLI access
