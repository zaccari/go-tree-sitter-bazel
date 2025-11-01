#!/usr/bin/env bash
#
# Download the tarball for go-tree-sitter and print its SHA-256 hash
# in base64-encoded format suitable for use as a Bazel http_archive integrity
# attribute.

set -ex

# Get version from version.bzl file
VERSION=$(grep 'GO_TREE_SITTER_VERSION' version.bzl | cut -d'"' -f2)
TARBALL_PATH=/tmp/go-tree-sitter-v${VERSION}.tar.gz

# curl -vf -L -o ${TARBALL_PATH} \
#   https://github.com/tree-sitter/go-tree-sitter/archive/refs/tags/v${VERSION}.tar.gz

# TODO: Use the correct URL when v0.25.0 tag is available
curl -sf -L -o ${TARBALL_PATH} \
  https://github.com/tree-sitter/go-tree-sitter/archive/refs/heads/${VERSION}.tar.gz

sha256sum ${TARBALL_PATH} | cut -d' ' -f1 | xxd -r -p | base64

# Example output:
# X6h4afTxPPue9Y6lVs6tlhizT7mL/USrxdHcJgjZof4=

# Clean up
rm ${TARBALL_PATH}
