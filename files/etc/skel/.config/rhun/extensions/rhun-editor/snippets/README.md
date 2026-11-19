# snippets

Text snippets for [rhun](https://rhun.app). As you type, the completion list offers the
snippets of the document's language among its items; Enter or Tab puts one in. **Expand
Snippet** (ctrl+alt+e) replaces the word before the cursor with the snippet of that name for the
document's language; when several names start with the word, a pick list asks which. **Insert
Snippet…** (the palette, or the editor's context menu) picks from all of them and inserts at the
cursor, or around the selection.

A snippet's fields are rhun's own: the first is selected, typing replaces it, Tab and Shift+Tab
move between them, a field used twice changes in both places, a choice opens a list of its
values, and the last Tab puts the cursor at `$0`. Escape ends it.

It needs rhun 0.18, and shows these parts of its extension protocol 1.1:

- **Native snippets** (features `snippets`, `snippet-variants`, `snippet-transforms`): a body is
  a TextMate template, prepared by rhun-ext's template support and inserted with its fields
  (`InsertSnippetProgram`, or `WithSnippetProgram` for a completion item). The variables come
  from rhun's snapshot of the place (`snippet-context`): the selection, the line, the path, the
  workspace, the indentation and the line comment; the extension adds the clock and randomness.
- **Commands with arguments** (`command-args`): Insert Snippet takes a snippet's name, so a key
  binding of your own inserts one directly. In `[keys]` of rhun's config:
  `ctrl+alt+t = snippets.insert td`.
- **When clauses**: the key binding, `[command-options]` and the context menu item apply only
  while a document that can be edited has the keys (`editorFocus && !editorReadonly`).

## Snippet files

`$RHUN_STATE/snippets/*.ini` (rhun shows the folder in Settings > Extensions) and
`PROJECT/.rhun/snippets.ini`, read at every expansion so edits apply at once. A section per
language, by rhun's grammar name, or `[*]` for every language; one snippet per line:

```ini
[Go]
fn = func ${1:name}($2) {\n\t$0\n}
for = for ${1:i} := 0; $1 < ${2:n}; $1++ {\n\t$0\n}
iferr = if err != nil {\n\t$SELECTION$0\n}

[*]
td = ${1|TODO,FIXME,NOTE|}: $0
hdr = $LINE_COMMENT $TM_FILENAME, $CURRENT_YEAR-$CURRENT_MONTH-$CURRENT_DATE
```

`\n` and `\t` in a body are a line feed and a tab; lines after the first keep the indentation of
the line the snippet goes in, and a tab indents as the document does (spaces when it inserts
spaces). The rest is the template's: `$1`, `${1:default}`, `${1|one,two|}`, `$0`, variables such
as `$TM_FILENAME`, `$TM_FILENAME_BASE`, `$SELECTION`, `$TM_CURRENT_LINE`, `$WORKSPACE_NAME`,
`$LINE_COMMENT`, `$CURRENT_YEAR`, `$UUID` (with `${VAR:default}` and transforms such as
`${TM_FILENAME_BASE/(.*)/${1:/upcase}/}`), and `\$`, `\}`, `\\` for a literal `$`, `}` and `\`.
A later file or section with the same name replaces an earlier one; the project's file comes
last.

## Needs

Documents: write (the expansion is one undo step). Project: read (`.rhun/snippets.ini`).

## Build and test

`go test ./...` covers the bodies and templates. `tests/run.sh [RHUN]` builds the extension, lays
it out as rhun installs it with a snippet file in its state folder (and one in the project), and
runs `tests/basic.txt` headlessly: an exact expansion, a pick list for an ambiguous prefix, the
insert list, an unknown name and the completion list; then `tests/fields.txt`: fields, mirrors, a
choice, variables, a snippet around the selection, a name as Insert Snippet's argument and the
key binding's clause. Releases are built by the reusable workflow from
`rhun-editor/extension-template`.
