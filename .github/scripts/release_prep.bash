#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail

# Set by GH actions, see
# https://docs.github.com/en/actions/learn-github-actions/environment-variables#default-environment-variables
TAG=${GITHUB_REF_NAME}
VERSION=${TAG:1}

# The prefix is chosen to match what GitHub generates for source archives
PREFIX="go_tree_sitter-$VERSION"
ARCHIVE="$PREFIX.tar.gz"
git archive --format=tar --prefix=${PREFIX}/ ${TAG} | gzip > $ARCHIVE

cat << EOF
## Setup Instructions

Add the following to your \`MODULE.bazel\` file to install go_tree_sitter:

\`\`\`starlark
bazel_dep(name = "go_tree_sitter", version = "$VERSION")
\`\`\`

Note, go_tree_sitter requires bzlmod, WORKSPACE mode is no longer supported.
EOF