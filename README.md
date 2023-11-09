# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project is going to utilize semantic versioning for its tagging
[semver.org](https://semver.org/)

Given a version number **MAJOR.MINOR.PATCH** e.g 1.0.1, increment the:

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make the backward compatible bug fixes

## Install the Terraform CLI

### Considerations with Terraform CLI changes

Introduction of GPG keyring changes has affected Terraform CLI installation. There is need to refer to the latest CLI installation instructions via the Terraform documentation.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Consideration for Linux Distribution

This project is built against Ubuntu.
Please consider checking your linux distribution and change accordingly.

[How To Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS version:
```
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg depracation issue we notice that bash scripts steps were a considerable amount of code. So we create a bash script to perform the installation.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This allows easier debugging and manual Terraform CLI installation. 
- This allows better portablity for other projects needing Terraform installation.

#### Shebang

A Shebang informs the bash script what program will interpret it e.g `#!/bin/bash`

This is the recommended format for bash: `#!/usr/bin/env bash`

- for portability across different distributions 
- It will search the user's path for the bash executable

[Learn more about Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))

## Execution Considerations

When executing the bash script we can use the `./` shorthand notation.

e.g `./bin/install_terraform_cli`

If using a script in .gitpod.yml, we'll need to point the script to a program that will interpret it.

e.g `source ./bin/install/terraform_cli`

#### Linux Permissions Consideration

In order to make the bash scripts executable, we need to change the linux permission for the fix to be executable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively

```sh
chmod 744 ./bin/install_terraform_cli
```

[Learn more about permissions](https://en.wikipedia.org/wiki/Chmod)

### Github Lifecycle (Before, Init, Command)

Apply caution when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

### Working Env Vars

#### env command

We can list out all Environment Variables (Env Vars) using the `env` command.

We can filter specific environment variables using grep command e.g `env | grep AWS_`

#### Setting and unsetting environment variables

In the terminal we can set env vars like `export MYVAR='myvariable'`

In the terminal we can unset env vars like `unset MYVAR`

Env vars can be set temporarily when running a command

```sh
MYVAR='myvariable' ./bin/print_message
```

Set env within bash script without writing export

```sh
#!/usr/bin/env bash

MYVAR='myvariable'

echo $MYVAR
```

#### Printing Vars

Print Env Vars using the `echo` command, e.g `echo $MYVAR`

#### Scoping Env Vars

New terminal windoow in VSCode will not be aware of Env Vars set in another window.
Set env vars in bash profile to ensure persistence in all open bash terminals.

#### Persisting Env Vars in Gitpod

Persist Env Vars into Gitpod by storing them in Gitpod Secrets Storage.

```
gp env MYVAR='myvariable'
```

The above configuration ensures all future workspaces launched will set the env vars for all open bash terminals.

Non-sensitive Env Vars can be set in the `.gitpod.yml` file.

### AWS CLI Installation 

Install aws cli via the bash script [./bin/install_aws_cli](./bin/install_aws_cli) 

[Getting Started Installation (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

Check for correct AWS credentials configuration by running the command below:

```sh
aws sts get-caller-identity
```

The result below is displayed if command request was successful:

```sh
{
    "UserId": "AKYA12ING4MAN",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::1234566789012:user/terraform-beginner-bootcamp"
}
```

New AWS users might need to create IAM roles for CLI access.