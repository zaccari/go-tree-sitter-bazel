# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.25.0] - 2025-10-31

### Added

- Initial Bazel module implementation for go-tree-sitter

### Notes

- Currently tracking go-tree-sitter branch 0.25 (waiting for v0.25.0 tag)
- Includes patch for tree_sitter.go to ensure compatibility with Bazel build
- Supports all go-tree-sitter language parsers (C, C++, Go, Java, JavaScript,
  JSON, PHP, Python, Ruby, Rust, HTML, Embedded Template)

[unreleased]: https://github.com/zaccari/go-tree-sitter-bazel/compare/v0.25.0...HEAD
[0.25.0]: https://github.com/zaccari/go-tree-sitter-bazel/releases/tag/v0.25.0
