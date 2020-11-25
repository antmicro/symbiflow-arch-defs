#!/bin/bash

source .github/workflows/scripts/common.sh
set -e

# Git repo fixup
start_section "environment.git" "Fixing ${YELLOW}git checkout${NC}"
set -x
git fetch --unshallow || true
git fetch --tags
git submodule update --recursive --init
git submodule foreach git submodule update --recursive --init
set +x
$SPACER
set -x
git remote -v
git branch -v
git branch -D ${GITHUB_REF}
CURRENT_GITREV="$(git rev-parse HEAD)"
git checkout -b ${GITHUB_REF} ${GITHUB_SHA}
git tag -l
git describe --long --always
set +x
$SPACER
git status -v
$SPACER
end_section "environment.git"
