# editorconfig

[EditorConfig](https://editorconfig.org) for [rhun](https://rhun.app). When a file opens, the
`.editorconfig` files from its folder up to the top of its workspace folder (or the first with
`root = true`) are read, and the properties that match the file become rhun's per-document
settings:

| EditorConfig | rhun |
| --- | --- |
| `indent_style = tab` / `space` | insert spaces off / on |
| `indent_size`, or `tab_width` when the size is `tab` or unset | tab width (1 to 16) |
| `trim_trailing_whitespace` | trim trailing whitespace on save |
| `insert_final_newline` | final newline on save |

Later files (nearer the file) and later sections win, as the specification says; glob patterns
support `*`, `**`, `?`, `[...]`, `[!...]`, `{a,b}` and `{1..3}`. The user's settings apply to
files no section matches, and again when the extension stops. `end_of_line`, `charset` and
`max_line_length` are not applied (rhun keeps a file's line endings as they are).

Command: **Show EditorConfig Settings** says what applies to the current file.

It needs rhun 0.18, and shows two parts of its extension protocol 1.1:

- **Workspace folders** (feature `workspace-folders`): a window can hold several folders, and
  each is a root of its own. The `0 folders` event lists them; a file's lookup stops at the top of
  the folder it is in, so a `.editorconfig` above a folder never reaches into it. A file in no
  folder is looked up to the file system's root, as the specification says.
- **Watching the workspace** (`workspace_watch`): when a `.editorconfig` changes on disk (saved
  in rhun, or by a `git checkout`), every open file gets its settings again, and a setting no
  section gives any more goes back to the user's.

## Needs

Project: read (the `.editorconfig` files, in every folder of the window). Documents: write,
because the trim-on-save and final-newline options change what rhun writes to disk (the
extension itself never edits text or touches a file).

## Build and test

`go test ./...` covers the globs and the property mapping. `tests/run.sh [RHUN]` builds the
extension, lays it out as rhun installs it and opens files under two `.editorconfig` files in a
headless rhun, checking the settings in force for each (`tests/basic.txt`), then two workspace
folders and a `.editorconfig` edited and saved while a file is open (`tests/folders.txt`).
Releases are built by the reusable workflow from `rhun-editor/extension-template`.
