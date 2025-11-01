"""Extension to fetch go-tree-sitter source code."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load(":version.bzl", "GO_TREE_SITTER_INTEGRITY", "GO_TREE_SITTER_VERSION")

# buildifier: disable=unused-variable
def _go_tree_sitter_sources_extension_impl(mctx):
    http_archive(
        name = "go-tree-sitter-raw",
        # url = "https://github.com/tree-sitter/go-tree-sitter/archive/refs/tags/v{}.tar.gz".format(GO_TREE_SITTER_VERSION),
        url = "https://github.com/tree-sitter/go-tree-sitter/archive/refs/heads/{}.tar.gz".format(GO_TREE_SITTER_VERSION),
        strip_prefix = "go-tree-sitter-{}".format(GO_TREE_SITTER_VERSION),
        integrity = GO_TREE_SITTER_INTEGRITY,
        build_file = "@go-tree-sitter//:BUILD.upstream",
        patches = ["@go-tree-sitter//:tree_sitter.go.patch"],
        patch_strip = 0,
    )

go_tree_sitter_source_code = module_extension(
    implementation = _go_tree_sitter_sources_extension_impl,
    doc = "Go tree-sitter source code extension",
)
