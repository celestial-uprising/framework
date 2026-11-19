# Essentials

A [rhun](https://rhun.app) extension pack: installing it installs

- `rhun-editor/lsp`: completion, definitions, references, rename and more from the language
  servers you have;
- `rhun-editor/format`: Format Document with the formatter you already use;
- `rhun-editor/editorconfig`: your `.editorconfig` files;
- `rhun-editor/snippets`: your snippets in the completion list.

rhun asks once, listing each extension with what it can do. Removing the pack keeps them; each
one's page has its own Remove. Install it from the Extensions page's **Browse** list, or with
**Install from GitHub…** and `rhun-editor/essentials`. It needs rhun 0.18. An update of the pack
that names a new member asks before adding it.

## Settings

None: each member has its own, on its page under Settings > Extensions.

## Development

A pack is an extension without a program: `pack = OWNER/NAME …` in `extension.ini` (at most 16).
`tests/check.sh` runs the protocol's conformance checker on the pack as rhun installs it. A tag
`vX.Y.Z` equal to `version` in `extension.ini` publishes `essentials-TARGET.tar.gz` (its
`extension.ini`, `README.md` and `LICENSE`) for each target and `sha256sums.txt`, which Install
from GitHub takes.
