## Description

<!-- Provide a brief description of the changes in this PR -->

## Type of Change

<!-- Mark the relevant option with an "x" -->

- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality
      to not work as expected)
- [ ] Documentation update
- [ ] Dependency update (upstream go-tree-sitter version)
- [ ] Other (please describe):

## Related Issues

<!-- Link to related issues, e.g., "Fixes #123" or "Relates to #456" -->

Fixes #

## Changes Made

<!-- Describe the changes in detail -->

-
-
-

## Testing

<!-- Describe how you tested these changes -->

- [ ] Builds successfully (`bazelisk build //:go-tree-sitter`)
- [ ] Tested with a consuming project using `local_path_override`
- [ ] All Bazel targets build (`bazelisk query //...`)
- [ ] Verified compatibility with Bazel version(s):

## Documentation

<!-- Check all that apply -->

- [ ] Updated README.md (if needed)
- [ ] Updated CHANGELOG.md under [Unreleased]
- [ ] Updated inline code comments
- [ ] No documentation changes needed

## Checklist

<!-- Ensure all items are checked before requesting review -->

- [ ] My code follows the project's style guidelines
- [ ] I have run `buildifier` on all .bzl and BUILD files
- [ ] I have tested my changes thoroughly
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] My changes generate no new warnings
- [ ] I have updated the documentation accordingly
- [ ] My changes maintain backward compatibility (or breaking changes are documented)

## For Dependency Updates

<!-- If updating go-tree-sitter version, complete this section -->

- [ ] Updated `GO_TREE_SITTER_VERSION` in version.bzl
- [ ] Updated `GO_TREE_SITTER_INTEGRITY` using ./print_sha.bash
- [ ] Verified that tree_sitter.go.patch still applies
- [ ] Tested build with new version
- [ ] Updated version mapping table in README.md
- [ ] Added changelog entry

## Additional Context

<!-- Add any other context, screenshots, or information about the PR here -->

## Screenshots (if applicable)

<!-- Add screenshots to help explain your changes -->
