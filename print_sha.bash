#!/usr/bin/env bash
#
# Download the tarball for go_tree_sitter and print its SHA-256 hash
# in base64-encoded format suitable for use as a Bazel http_archive integrity
# attribute.

set -e

# Get commit hash from version.bzl file
COMMIT=$(grep 'GO_TREE_SITTER_COMMIT' version.bzl | cut -d'"' -f2)
TARBALL_PATH=/tmp/go_tree_sitter-${COMMIT}.tar.gz

# Download the tarball using the commit hash
curl -sf -L -o ${TARBALL_PATH} \
  https://github.com/tree-sitter/go-tree-sitter/archive/${COMMIT}.tar.gz

sha256sum ${TARBALL_PATH} | cut -d' ' -f1 | xxd -r -p | base64

# Example output:
# X6h4afTxPPue9Y6lVs6tlhizT7mL/USrxdHcJgjZof4=

# Clean up
rm ${TARBALL_PATH}
