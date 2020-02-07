#!/bin/sh

set -eu

SRC=${1-""}
TARGET=${2-""}

if [ "$SRC" = "" ]; then
  echo "Source directory is empty"
  exit 1
fi

if [ "$TARGET" = "" ]; then
  echo "Target directory is empty"
  exit 1
fi

echo "Source Directory: $SRC"
echo "Target Directory: $TARGET"

/kube-psp-advisor compare --sourceDir "$SRC" --targetDir "$TARGET"

report="$(/kube-psp-advisor compare --sourceDir "$SRC" --targetDir "$TARGET")"

echo "::set-output name=escalation_report::${report}"
