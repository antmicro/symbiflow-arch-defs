#!/bin/bash

source .github/workflows/scripts/common.sh
set -e

# Git repo fixup
.github/workflows/scripts/git-fixup.sh
