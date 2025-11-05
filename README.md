# go_tree_sitter Bazel Module

A Bazel module providing [go_tree_sitter][1] bindings for use in Bazel
projects. This module handles the complexities of building the tree-sitter C
library and Go bindings together using Bazel's modern module system (bzlmod).

## Features

- 🚀 Easy integration with Bazel projects using `bazel_dep`
- 🔧 Automatic management of tree-sitter C library compilation
- 📦 Includes all upstream go_tree_sitter dependencies
- 🎯 Support for all tree-sitter language parsers (C, C++, Go, Java,
     JavaScript, JSON, PHP, Python, Ruby, Rust, HTML, and more)
- ⚡  Uses Bazel's modern module system (bzlmod)

## Requirements

- Bazel 8.4.2 or higher
- A C11-compatible compiler
- Go 1.25.3 or higher (automatically managed by rules_go)

## Installation

Add this module to your `MODULE.bazel` file:

```starlark
bazel_dep(name = "go_tree_sitter", version = "0.25.0")
git_override(
    module_name = "go_tree_sitter",
    remote = "https://github.com/zaccari/go-tree-sitter-bazel.git",
    commit = "<commit-sha>",
)
```

Note: BCR does not currently recommend hosting go modules.

## Usage

Once added to your `MODULE.bazel`, you can use go_tree_sitter in your Go code:

### In your BUILD.bazel file

```starlark
load("@rules_go//go:def.bzl", "go_binary", "go_library")

go_library(
    name = "mylib",
    srcs = ["mycode.go"],
    importpath = "github.com/yourorg/yourproject/mylib",
    deps = [
        "@go_tree_sitter//:go_tree_sitter",
        # Add language-specific parsers as needed
        "@com_github_tree_sitter_tree_sitter_go//:go",
        "@com_github_tree_sitter_tree_sitter_python//:python",
    ],
)
```

### In your Go code

```go
package main

import (
    "fmt"
    tree_sitter "github.com/tree-sitter/go-tree-sitter"
    tree_sitter_go "github.com/tree-sitter/tree-sitter-go/bindings/go"
)

func main() {
    // Create a parser
    parser := tree_sitter.NewParser()
    defer parser.Close()

    // Set the language
    parser.SetLanguage(tree_sitter.NewLanguage(tree_sitter_go.Language()))

    // Parse some code
    sourceCode := []byte("package main\n\nfunc main() {}")
    tree := parser.Parse(sourceCode, nil)
    defer tree.Close()

    // Work with the syntax tree
    root := tree.RootNode()
    fmt.Printf("Syntax tree: %s\n", root.String())
}
```

## Available Language Parsers

This module includes dependencies for the following tree-sitter language parsers:

- C
- C++
- Go
- Java
- JavaScript
- JSON
- PHP
- Python
- Ruby
- Rust
- HTML
- Embedded Template

All parsers are available as dependencies through the module's go_deps extension.

## Building from Source

```bash
# Build the module
bazelisk build //:go_tree_sitter

# Query all targets
bazelisk query //...
```

Or use the Makefile:

```bash
make build  # Build the library
make query  # Query all targets
make help   # Show all available targets
```

## How It Works

This module uses a Bazel module extension to:

1. Fetch the upstream go_tree_sitter source code from GitHub
2. Apply a small patch to make the code Bazel-compatible (removes the `lib.c`
   inclusion from CGo directives)
3. Build the tree-sitter C library separately
4. Link the Go bindings against the C library using CGo

The separation of the C library build from the Go build is necessary because
the upstream code includes `lib.c` in the CGo directives, which conflicts with
Bazel's compilation model.

## Version Mapping

This module's version tracks the upstream go_tree_sitter version:

| Module Version | go_tree_sitter Version | Notes |
|----------------|------------------------|-------|
| 0.25.0         | 0.25 (branch)          | Tracking branch until v0.25.0 tag is released |

## Technical Details

### Patch File

The module applies a minimal patch (`tree_sitter.go.patch`) to the upstream
source to remove the `#include "lib.c"` directive, which would cause build
conflicts in Bazel. Instead, the C library is built separately as a
`cc_library` target and linked via the `cdeps` attribute.

### Module Structure

- `MODULE.bazel` - Module definition and dependencies
- `extensions.bzl` - Module extension for fetching upstream source
- `version.bzl` - Version constants and integrity hashes
- `BUILD.bazel` - Main build file with public alias
- `BUILD.upstream` - Build rules for upstream go_tree_sitter source
- `tree_sitter.go.patch` - Compatibility patch for Bazel builds

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

### Updating to a New Upstream Version

1. Update `GO_TREE_SITTER_VERSION` in `version.bzl`
2. Run `./print_sha.bash` to compute the new integrity hash
3. Update `GO_TREE_SITTER_INTEGRITY` in `version.bzl`
4. Test the build: `bazelisk build //:go_tree_sitter`
5. Update `CHANGELOG.md` with the new version

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE)
file for details.

The upstream [go_tree_sitter](https://github.com/tree-sitter/go-tree-sitter)
project is also licensed under the MIT License.

## Acknowledgments

- [tree-sitter][2] - The underlying parsing library
- [go_tree_sitter][1] - Go bindings for tree-sitter
- [rules_go][3] - Bazel rules for Go

## Resources

- [go_tree_sitter Documentation](https://github.com/tree-sitter/go-tree-sitter)
- [tree-sitter Documentation](https://tree-sitter.github.io/tree-sitter/)
- [Bazel Documentation](https://bazel.build/)
- [rules_go Documentation](https://github.com/bazelbuild/rules_go/blob/master/docs/go/core/bzlmod.md)

[1]: https://github.com/tree-sitter/go-tree-sitter
[2]: https://tree-sitter.github.io/tree-sitter/
[3]: https://github.com/bazelbuild/rules_go
