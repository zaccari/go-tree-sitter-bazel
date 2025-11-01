# Contributing to go-tree-sitter-bazel

Thank you for your interest in contributing to go-tree-sitter-bazel! This
document provides guidelines and instructions for contributing to the project.

## Code of Conduct

By participating in this project, you agree to maintain a respectful and
inclusive environment for all contributors.

## How to Contribute

### Reporting Issues

If you encounter a bug or have a feature request:

1. Check the [issue tracker][issues] to see if it's already been reported
2. If not, create a new issue with:
   - A clear, descriptive title
   - Detailed description of the problem or suggestion
   - Steps to reproduce (for bugs)
   - Your environment (Bazel version, OS, etc.)
   - Expected vs. actual behavior

### Suggesting Enhancements

We welcome suggestions for improvements! When proposing an enhancement:

1. Check existing issues and discussions first
2. Clearly describe the use case and benefits
3. Consider backward compatibility implications
4. Provide examples of how it would be used

## Development Setup

### Prerequisites

- Bazel 8.4.2 or higher (or use `bazelisk`)
- A C11-compatible compiler (gcc, clang, or MSVC)
- Git
- Basic knowledge of Bazel and Go

### Getting Started

1. **Fork and clone the repository**

   ```bash
   git clone https://github.com/yourusername/go-tree-sitter-bazel.git
   cd go-tree-sitter-bazel
   ```

2. **Build the project**

   ```bash
   make build
   # or
   bazelisk build //:go-tree-sitter
   ```

3. **Query all targets**

   ```bash
   make query
   # or
   bazelisk query //...
   ```

### Testing Your Changes

Before submitting changes:

1. **Build the library**

   ```bash
   bazelisk build //:go-tree-sitter
   ```

2. **Test in a consuming project** (recommended)

   Create a test project with a `MODULE.bazel` that uses a local override:

   ```starlark
   bazel_dep(name = "go_tree_sitter", version = "0.25.0")

   local_path_override(
       module_name = "go_tree_sitter",
       path = "/path/to/your/go-tree-sitter-bazel",
   )
   ```

3. **Verify the build**

   Ensure your changes don't break existing functionality.

## Making Changes

### Branching Strategy

- Create a feature branch from `main`
- Use descriptive branch names:
  - `feature/add-something`
  - `fix/issue-123`
  - `docs/improve-readme`

### Commit Guidelines

Write clear, concise commit messages:

```
Short summary (50 chars or less)

More detailed explanation if needed. Wrap at 72 characters.
Explain what and why, not how.

- Bullet points are okay
- Use present tense ("Add feature" not "Added feature")
- Reference issues: Fixes #123
```

### Code Style

**Starlark (BUILD, .bzl files):**
- Run `buildifier` on all Bazel files before committing
- Follow the [Bazel style guide][bazel-style]
- Use meaningful target and variable names
- Add comments for complex logic

**Bash scripts:**
- Use shellcheck for linting
- Include error handling (`set -e`, etc.)
- Add comments explaining non-obvious code

### Pull Request Process

1. **Update documentation**
   - Update README.md if adding features or changing usage
   - Update CHANGELOG.md under the `[Unreleased]` section
   - Add inline comments for complex code

2. **Test thoroughly**
   - Build the library successfully
   - Test with a consuming project if possible
   - Verify all targets build: `bazelisk build //...`

3. **Create the pull request**
   - Use a clear, descriptive title
   - Reference any related issues
   - Describe what changes you made and why
   - Include test results or screenshots if applicable

4. **Code review**
   - Address reviewer feedback promptly
   - Keep the discussion focused and professional
   - Make requested changes in new commits (don't force push)

5. **Merging**
   - Maintainer will merge once approved
   - Squash commits may be used for cleaner history

## Updating to New Upstream Versions

When go-tree-sitter releases a new version:

1. **Update version.bzl**

   ```bash
   # Edit version.bzl
   GO_TREE_SITTER_VERSION = "0.26.0"  # New version
   ```

2. **Compute the new integrity hash**

   ```bash
   ./print_sha.bash
   ```

3. **Update the integrity in version.bzl**

   ```bash
   GO_TREE_SITTER_INTEGRITY = "sha256-<new-hash>"
   ```

4. **Check if the patch still applies**

   ```bash
   bazelisk build //:go-tree-sitter
   ```

   If the patch fails, you may need to update `tree_sitter.go.patch`:
   - Check if upstream changes affect the patched code
   - Regenerate the patch if necessary
   - Document any changes in the commit message

5. **Update documentation**

   - Update MODULE.bazel version if needed
   - Update README.md version mapping table
   - Add entry to CHANGELOG.md

6. **Test thoroughly**

   Build and test with the new version to ensure compatibility.

## Patch File Management

The `tree_sitter.go.patch` file is critical for Bazel compatibility:

### Why the patch exists

The upstream go-tree-sitter includes `#include "lib.c"` in CGo directives,
which conflicts with Bazel's compilation model. The patch removes this
directive, allowing us to build the C library separately as a `cc_library`.

### Updating the patch

If upstream changes require patch updates:

1. Make changes to a local checkout of go-tree-sitter
2. Generate a new patch:
   ```bash
   diff -u original/tree_sitter.go modified/tree_sitter.go > tree_sitter.go.patch
   ```
3. Test that the patch applies cleanly
4. Document the changes in your PR

### Upstreaming considerations

If possible, consider whether the patch could be upstreamed to go-tree-sitter
to make their code more Bazel-friendly. This could eliminate the need for
patching in the future.

## Release Process

(For maintainers)

1. Update version in `MODULE.bazel`
2. Update `CHANGELOG.md` - move `[Unreleased]` items to new version section
3. Create a git tag: `git tag -a v0.26.0 -m "Release v0.26.0"`
4. Push the tag: `git push origin v0.26.0`
5. Create a GitHub release with notes from CHANGELOG.md
6. (Future) Submit to Bazel Central Registry

## Project Structure

```
.
├── MODULE.bazel           # Module definition and dependencies
├── BUILD.bazel            # Main build file (public alias)
├── BUILD.upstream         # Build rules for upstream source
├── extensions.bzl         # Module extension for fetching source
├── version.bzl            # Version constants
├── tree_sitter.go.patch   # Compatibility patch
├── print_sha.bash         # Helper for computing integrity hashes
├── Makefile               # Developer convenience targets
├── .bazelrc               # Bazel configuration
├── .bazelversion          # Pinned Bazel version
└── .gitignore             # Git ignore patterns
```

## Getting Help

- Open an issue for bugs or questions
- Check existing issues and documentation first
- Be patient and respectful when asking for help

## Recognition

Contributors will be acknowledged in release notes and the project's commit
history. Significant contributions may be highlighted in the README.

## License

By contributing to go-tree-sitter-bazel, you agree that your contributions
will be licensed under the MIT License.

---

Thank you for contributing to go-tree-sitter-bazel! 🎉

[issues]: https://github.com/zaccari/go-tree-sitter-bazel/issues
[bazel-style]: https://bazel.build/rules/bzl-style
