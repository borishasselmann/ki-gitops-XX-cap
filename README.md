# ki-gitops-template-helm

## Table of contents

- [Description](#description)
- [Initial Setup](#initial-setup)
  - [Set up Environment Variables for GitHub Runner](#set-up-environment-variables-for-github-runner)
  - [Update SUPPORT.md](#update-supportmd)
  - [Bootstrap script](#bootstrap-script)
- [Roles and Responsibilities](#roles-and-responsibilities)
- [Process model](#process-model)

## Description

kodeInnovate ArgoCD and helm template repository for new tenants.

## Initial Setup

### Set up Environment Variables for GitHub Runner

To be able to push the helmcharts to the Harbor repository, you need to set up the following environment variables in your GitHub Actions runner:

| Variable Name          | Description                                             |
| ---------------------- | ------------------------------------------------------- |
| `TEST_HARBOR_USERNAME` | Username for pushing to the Harbor test instance        |
| `TEST_HARBOR_PASSWORD` | Password for pushing to the Harbor test instance        |
| `INT_HARBOR_USERNAME`  | Username for pushing to the Harbor integration instance |
| `INT_HARBOR_PASSWORD`  | Password for pushing to the Harbor integration instance |
| `PROD_HARBOR_USERNAME` | Username for pushing to the Harbor production instance  |
| `PROD_HARBOR_PASSWORD` | Password for pushing to the Harbor production instance  |

See our [Docs](TBD) for more information on how to set up the credentials in Harbor.

### Update SUPPORT.md

You need to update the [SUPPORT.md](SUPPORT.md) file with the correct information for your application.

At least the Product Owner and the Project Security Experts must be defined for all repos. If the repo classification is anything other than Standard, personal, Requester and Management are also required. Remember that roles must be split between at least two people!

### Bootstrap script

After cloning this template repository in the format `ki-gitops-<COSTCENTER>-<myapp>`, you can run the bootstrap script to initialize the repository with the correct values.

> [!IMPORTANT]
> Don't forget to remove the `init.sh` script after executing!

```bash
./init.sh
```

This will automatically replace all occurrences of `<COSTCENTER>`, `<costcenter>` and `<myapp>` with the correct values and also substitute this README with the correct one for you.

## Roles and Responsibilities

[Roles and responsibilities for this project](SUPPORT.md)

## Process model

Agile
