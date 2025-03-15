#!/bin/bash

# This file is not intended to run separately since export work only sub shell.
# Instead, copy these command to terminal that's going to run terraform

export AWS_PROFILE=personal-infra-admin
export AWS_REGION=$(aws configure get region)

aws sts get-caller-identity
