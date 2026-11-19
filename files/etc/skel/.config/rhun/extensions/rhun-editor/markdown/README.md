# Markdown Preview

The active Markdown document rendered beside the editor in [rhun](https://rhun.app). A small Rust
program built on
[rhun-ext](https://github.com/rhun-editor/extension-protocol/tree/main/rust/rhun-ext), and an
example of rhun's retained views: the extension hands rhun the document's text, and rhun lays it
out, draws it in theme colors and scrolls it.

**Markdown: Open Preview** (Ctrl+Shift+V) opens the preview in the side area. Then:

- **It follows the editor**: the preview keeps the editor's top line at its top while you scroll,
  and shows whichever Markdown document (`.md`, `.markdown`, `.mdown`) is the active one.
- **It changes as you type**, unsaved text included.
- **Links** to files next to the document open them in rhun, `#headings` scroll the preview, and
  web links open in your browser.
- **Images** that sit next to the document are shown in place.

Install it from rhun's Extensions page (the extensions button in the title bar): **Install from
GitHub…**, then `rhun-editor/markdown`. Or take `markdown-TARGET.tar.gz` for your system from the
[latest release](https://github.com/rhun-editor/markdown/releases/latest) and use **Install** >
**From an Archive**. It needs rhun 0.18 (extension protocol 1.1: retained views, features
`view-tree`, `view-doc` and `view-images`).

## Permissions

It reads the Markdown documents you have open. It changes nothing, has no internet and runs no
programs.

## Build and test

```sh
cargo test
cargo build --release
tests/run.sh [RHUN]     # headless, against the rhun on your PATH
tests/check.sh          # the protocol's conformance checker (needs Go)
```

`tests/run.sh` builds the extension, lays it out as rhun installs it and runs `tests/basic.txt`
headlessly: the preview of a document with headings, emphasis, a link, a list and a code block,
the preview after typing, and the preview following another document. A tag `vX.Y.Z` equal to
`version` in `extension.ini` builds Linux, macOS and Windows on their own runners and publishes
what Install from GitHub takes.
