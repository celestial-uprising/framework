# format

Format Document for [rhun](https://rhun.app). JSON is formatted by the extension itself; every
other language is handed to the formatter you already have installed, found on your `PATH`:
gofmt, rustfmt, ruff or black, prettier, clang-format, shfmt, zig fmt, nixfmt, terraform fmt,
sql-formatter, dart format, swift-format, ktfmt, stylua, rubocop, mix format, ormolu or
fourmolu, ocamlformat, buf, taplo. Nothing is downloaded.

Format Document: **Shift+Alt+F** (rhun asks the extension, with the document's tab width and
spaces; JSON follows them unless `format.ini` sets its own) or the extension's command
(Ctrl+Shift+I). Only the lines that changed are replaced, as one undo step; if you typed
meanwhile, nothing changes. An invalid JSON file is left as it is and the toast names the line
and column.

It needs rhun 0.18, and shows these parts of its extension protocol 1.1:

- **Format Selection** (feature `partial-format`, `range_format` in `[provides]`): only the
  selected lines change. The formatters format whole files, so the extension formats the whole
  text and keeps the changed lines that fall in the selection.
- **Formatting as you type** (`type_format`, with `[editor] format_on_type = yes` in rhun's
  config): typing `}` tidies the block it closes, Enter tidies the line it ended. Errors stay
  quiet there, since the code is half typed.
- **Format on save** is rhun's own `[files] format_on_save = true`: it asks this extension as
  Shift+Alt+F does before it writes the file. Nothing in the extension is needed for it.
- **A status bar item** (`status-items`) when a file does not format: the reason in the error
  color, shown while that file is the active one (a `when` clause on its path), the whole message
  as its tooltip. When the message names a line and a column, a click goes there: the item
  carries a command reference with them as arguments (`command-args`) to the command
  `goto_error`, which `[command-options]` keeps out of the palette.

## Settings

`$RHUN_STATE/format.ini` (rhun shows the folder in Settings > Extensions):

```ini
[json]
indent = 2      # spaces per level
tabs = no       # tabs instead of spaces
[run]
timeout = 10    # seconds a formatter may take
```

## Needs

Documents: write (that is the point). Project: read (formatters read configuration files such
as `.prettierrc` or `rustfmt.toml` next to the file). Run: the formatters above, by name; no
network.

## Build and test

`go test ./...` covers the line comparison behind partial formatting. `tests/run.sh [RHUN]` builds
the extension, lays it out as rhun installs it and runs `tests/basic.txt` (Format Document) and
`tests/partial.txt` (the 1.1 parts above) headlessly. Releases are built by the reusable workflow from
`rhun-editor/extension-template`.
