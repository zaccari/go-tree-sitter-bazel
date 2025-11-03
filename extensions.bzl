"""Extension to fetch go_tree_sitter source code."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load(":version.bzl", "GO_TREE_SITTER_COMMIT", "GO_TREE_SITTER_INTEGRITY")

# buildifier: disable=unused-variable
def _go_tree_sitter_sources_extension_impl(mctx):
    http_archive(
        name = "go_tree_sitter_raw",
        url = "https://github.com/tree-sitter/go-tree-sitter/archive/{}.tar.gz".format(GO_TREE_SITTER_COMMIT),
        strip_prefix = "go-tree-sitter-{}".format(GO_TREE_SITTER_COMMIT),
        integrity = GO_TREE_SITTER_INTEGRITY,
        build_file = "@go_tree_sitter//:BUILD.upstream",
        patches = ["@go_tree_sitter//:tree_sitter.go.patch"],
        patch_strip = 0,
    )

go_tree_sitter_source_code = module_extension(
    implementation = _go_tree_sitter_sources_extension_impl,
    doc = "Go tree-sitter source code extension",
)
