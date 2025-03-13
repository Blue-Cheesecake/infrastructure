# Personal Infrastructure

Codes to provision Cloud infrastructure built with [Terraform](https://www.terraform.io/) and the [Terraspace Framework](https://terraspace.cloud/) using AWS provider.

## Prerequisites

1. AWS Account: Since provider we're using for this proejct is AWS
2. Ruby: version > 3.0.0
3. Terraform CLI
4. Terraspace CLI

## Getting Started

### 1. Create IAM for Managing Infrastructure in AWS

The policy should include mananging IAM, S3.
<!-- TODO: update more resource -->

### 2. Setup Access Keys in Project

Run setup script by

```bash
sh scripts/setup.sh

```

Fill in access key, secret access key, and region from IAM.


### 3. Apply Profile

Copy all commands from `scripts/apply-profile.sh` and execute those in your terminal. Verify it produces valid IAM user to manage resource.

<!-- TODO: Add more step -->
