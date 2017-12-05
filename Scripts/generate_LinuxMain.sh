#!/usr/bin/env bash
TESTIMPORTS=""
SOURCERY_VERSION="$(sourcery --version)"
if [ "$SOURCERY_VERSION" != "0.9.0" ]
then
  echo "You need sourcery 0.9.0 – please `brew install sourcery`"
  exit 1
fi

set -e
SCRIPTS="`dirname \"$0\"`"
TESTS="$SCRIPTS/../Tests"

TESTCONTENTS=$TESTS/*/
for directory in $TESTCONTENTS; do
	STATEMENT=$(printf '\n@testable import %s' $(basename $directory))
	TESTIMPORTS="$STATEMENT$TESTIMPORTS"
done
sourcery --sources $TESTS --templates $SCRIPTS/LinuxMain.stencil --output $TESTS --args testimports="$TESTIMPORTS"
mv $TESTS/LinuxMain.generated.swift $TESTS/LinuxMain.swift
