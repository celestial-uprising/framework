# lsp

Language servers for [rhun](https://rhun.app): completion lists as you type (`ctrl+space` for
one at once), signature help inside a call (`ctrl+shift+space`), diagnostics in the gutter, the
status bar and the Problems panel (`ctrl+shift+m`, files that are not open too), the hover card,
**Go to Definition** (F12), **Go to Declaration**, **Go to Type Definition**, **Go to
Implementation** (ctrl+F12), **Find All References** (shift+F12, in the Results panel as the
server finds them), call and type hierarchies (shift+alt+h), **Go to Symbol in File** (ctrl+r)
and **in Project** (ctrl+t), **code actions** (ctrl+.: the server's quick fixes, refactorings and
source actions; Auto Fix shift+alt+., Organize Imports shift+alt+o), **Rename Symbol** (F2: the
server says what can be renamed; with rhun 0.18 one change across files, files that are not open
changed on disk after you confirm, undone with one Undo; earlier rhun opens every changed file
unsaved for you to review), **linked editing** (an HTML tag's name and its closing tag's change
together), **Format Document** (shift+alt+f), Format Selection, formatting as you type (with
rhun's `[editor] format_on_type = yes`), Expand and Shrink Selection (shift+alt+Right / Left) and
links under ctrl+hover. One server per
language per project, started when the first document of the language opens, run from the
project folder. Nothing is downloaded: the extension runs the server you already have on your
`PATH`:

| Language | Server | Alternatives for `lsp.ini` |
| --- | --- | --- |
| Go | gopls | |
| Rust | rust-analyzer | |
| TypeScript, JavaScript | typescript-language-server | `vtsls --stdio`, `deno lsp` |
| Python | pyright-langserver | `ty server`, `pylsp`, `basedpyright-langserver --stdio`, `jedi-language-server`, `ruff server` |
| C, C++ | clangd | `ccls` |
| Zig | zls | |
| Lua | lua-language-server | |
| Ruby | solargraph | `ruby-lsp` |
| Dart | dart language-server | |
| Kotlin | kotlin-language-server | |
| Swift | sourcekit-lsp | |
| OCaml | ocamllsp | |
| Haskell | haskell-language-server-wrapper | `haskell-language-server --lsp` |
| Elixir | elixir-ls | |
| Nix | nil | `nixd` |
| Terraform | terraform-ls | |
| YAML, JSON, HTML, CSS | the vscode language servers, yaml-language-server | |

Version 0.3.4 uses rhun 0.18.4's compiler-helper confinement and copyable setup commands.
Hold Ctrl (Command on macOS) over a symbol to underline it when the server finds a definition;
click with the same modifier to navigate there.

A missing server shows once in the status bar ("gopls not installed") and offers an **Install
instructions** button. It opens a guide in its own editor tab for that language and operating system, with prerequisites,
commands you can copy into your terminal, and links to the server's official instructions.
**Set Up Language Server** opens the same guide for the current file, or a language picker when
the file has no supported language. **Choose another language** in the guide opens that picker
at any time. The guide follows your configured server, including supported alternatives, and
explains how to retry after installing. A server being on `PATH` does not confirm it started.
Installation is manual; the extension does not run installation commands.

The servers are looked up on your login shell's `PATH`, as rhun's terminals see it. rhun
before 0.18.3 used its own `PATH` instead, which for an app started from the macOS Dock or Finder
lacks folders such as `~/go/bin` and `/opt/homebrew/bin`; start it with
`open -a rhun --env PATH="$PATH"` there. **Restart Language Servers** stops them all and starts them again for the open documents.
Choosing `deno lsp` enables Deno analysis for that language. Explicit settings and initialization
options can disable it.
Compiler-backed servers can take longer on first launch. ElixirLS may download and compile its
runtime; the status stays at starting while it prepares. Kotlin also needs the Kotlin compiler
on PATH so its server can find the standard library.

The setup page includes project prerequisites and copyable build commands. Open the project
root so servers can find dependencies and compiler settings. OCaml needs Dune build information,
Zig compiler diagnostics need a `check` build step, and Xcode projects need a compatible build
server to supply their compiler arguments. Ruff supplies linting and formatting; Jedi supplies
completion and navigation without type checking. Use Pyright, basedpyright or ty for Python
type checking. One server command is selected per language.

For fwcd Kotlin Language Server, initial queries wait for the first document diagnostics to
avoid racing its startup compiler analysis. This wait respects cancellation and process exit,
and falls back after 30 seconds for configurations that disable diagnostics. On macOS, the
SourceKit toolchain view uses in-process SourceKit and the separate `swift-frontend` dependency
scanner, avoiding duplicate compiler classes without changing the installed Xcode toolchain.

The extension follows each server's document synchronization options: full text, incremental
changes or no changes, open/close notifications, and save notifications with optional text.
A delayed server receives the latest document text when it becomes ready. Refreshes finish
before pending saves, and requests whose document changes before transmission are suppressed.
Positions convert between rhun's byte columns and UTF-16 units; a server selecting another
position encoding is rejected with a status message.

Interactive commands and deferred code actions retain open-document snapshots before execution or resolution. If typing changes
any edited target, the host rejects the edit. Edits already returned with an action retain their
versions from the initial request, including time spent waiting in the picker. A deferred edit for a file without a prior snapshot
is rejected; open that file before selecting the action. Sequential command callbacks advance only
the snapshots for their successfully applied changes. A failure rejects the remaining callbacks.

## What rhun is asked for

Each server says what it can do, and the extension tells rhun which kinds each file pattern is
really served for: a language whose server is missing or turned off is not asked at all (F2 then
renames the file, and another extension may format it), a running server is asked only for what
it declared or registered, and formatting as you type triggers on the characters the running
servers asked for. A language whose server has not started yet keeps its patterns until it does.

Long answers stream: references, implementations, definitions, workspace symbols and hierarchy
calls show as the server sends partial results, its progress shows on the request, and rhun
withdrawing a request (Escape, a new query) cancels it on the server. Diagnostics carry their
codes, links, tags and related places into the Problems panel, and code actions get back the
diagnostics they are about by id. Code actions are listed by kind with the server's preferred
fix and disabled reasons; actions the server resolves lazily are resolved when chosen. An
action's server command is a reference to the extension's runtime command `lsp.exec`: rhun runs
it after the action's edit, and the extension sends the command to the server, whose edits come
back as one apply request each (rhun builds without `command-args` get the command run by the
extension when the action is chosen). Hover text and documentation are Markdown where rhun
renders it, else plain text. Servers that offer diagnostics on request are asked for an open
document's after it changes.

## Workspace edits, file operations, linked editing (rhun 0.18)

Version 0.3.0 requires rhun 0.18 for these and the SDK v1.4.0 (protocol 1.1's features
`workspace-edits`, `file-operations`, `reveal` and `linked-editing`); with an earlier rhun the
extension behaves as 0.2. A server's workspace edit (a rename, a code action's edit, the edits
a server command asks for with `workspace/applyEdit`) goes to rhun as one transaction through
the SDK's `NormalizeOrdered`: LSP's ordered `documentChanges` mapped onto rhun's phases (an edit
after a rename names the file before it, repeated edits of a file become one), files that are
not open converted from the bytes on disk and sent with their `fnv1a64` hash (rhun refuses the
edit when the file changed since), created, renamed and deleted files (`resourceOperations`
create, rename, delete; `failureHandling` transactional), the rename's new name or the action's
title as the label, and a change annotation that needs confirmation asking rhun for its
confirmation list. `workspace/applyEdit` is answered with `applied`, `failureReason` and
`failedChange` (the `documentChanges` index rhun or the conversion refused). After an edit that
created, renamed or deleted files is made, servers that asked for them (`fileOperations`
didCreate, didRename, didDelete, static or registered) get `workspace/didCreateFiles`,
`didRenameFiles` and `didDeleteFiles`; for a rename answer, which rhun makes without telling
the extension, once the disk shows it. The `will…` requests are not sent: they are for renames
the user makes, which rhun does not report to extensions.

Linked editing asks the server's `textDocument/linkedEditingRange` for `[provides] linked`
files (`*.html *.htm *.xml *.jsx *.tsx *.vue`); a `wordPattern` that is one character class
becomes the characters rhun lets you type in the ranges, another keeps rhun's default.
`window/showDocument` opens the file in rhun with the selection and reveals it; external
documents and other schemes are refused, and rhun always activates the tab it opens.

## Workspace folders

With rhun's workspace folders (a window with several folders), every folder is a workspace folder
of the servers: `initialize` names them all (`rootUri` the primary one), `workspace/workspaceFolders`
answers them and `workspace/configuration` may name resources in any of them. As the extension
reads the project, rhun restarts it when the folders change, and the servers start again with the
new set; a server that is told of changes while it runs (`changeNotifications`, or a registration)
gets `workspace/didChangeWorkspaceFolders`.

## Folding, semantic colors, inlay hints, code lens, highlights and colors

With rhun 0.18 (protocol 1.1) the server's folding ranges replace rhun's indentation ranges, its
semantic tokens color the code by meaning (the server's legend is registered with rhun; deltas are
applied here and rhun gets the whole array in byte columns), its inlay hints show inside lines
(a part with a location is a place to go; the hint's text edits are made by a double click), its
code lenses show above lines (a click runs the lens's command through `workspace/executeCommand`,
as a code action's command runs), the places of the symbol under the cursor are marked, color
swatches come from `textDocument/documentColor`, a new color written through
`textDocument/colorPresentation`, and `textDocument/inlineCompletion` shows as ghost text after the
cursor (Tab takes it; a snippet's placeholders become their text).

## Source actions before saving

Enable source kinds in rhun's Settings, such as `source.organizeImports source.fixAll`, to run
code actions before formatting and writing. The source phase has one total timeout. Save Without
Formatting bypasses it, and Cancel Save leaves the document unsaved. Typing during the phase
saves the latest text and skips further automatic transforms.

The bridge requests each precise source kind over the whole document, resolves deferred actions
when the server supports resolution, and re-queries after each action using the updated text.
Only the saving document may change. Numeric LSP edit versions are checked against the server's
synchronized version, separately from rhun's version. A stale, foreign or unsupported edit stops
the source phase and lets the host continue to formatting and saving with a warning.

Server commands are serialized per language. Their apply-edit requests are registered in reader
order, applied and synchronized before acknowledgement, and drained before the command finishes.
Command-based source actions use a fresh server session after each command. A source batch also
retires any session that previously executed a command. This prevents delayed command edits from
joining a later save; it adds server startup time. Edit-only source actions reuse the session.
Edits arriving outside an active command are refused.

## Settings

`$RHUN_STATE/lsp.ini` (rhun shows the folder in Settings > Extensions) overrides a server
command per language, by rhun's grammar name:

```ini
[servers]
Python = ty server
Go = gopls -remote=auto
```

Use `off` to disable a server, such as `Rust = off`. Commands must contain an executable, and
rhun's sandbox starts only the programs the manifest's `run` list names: the servers and
alternatives in the table above. Any other program shows "not allowed to start" in the status
bar; open an issue to have it added.
For arguments or paths containing spaces, use a JSON string array:

```ini
[servers]
Go = ["gopls", "-remote=auto"]
```

`$RHUN_STATE/settings.json` supplies server settings and initialization options. Defaults apply
to every language; a language's settings merge into them recursively. A `null` value overrides
a default value. Language initialization options replace the default options as a whole.

```json
{
  "defaults": {
    "settings": {},
    "initializationOptions": {}
  },
  "languages": {
    "Go": {
      "settings": {
        "gopls": { "gofumpt": true }
      }
    }
  }
}
```

**Reload Language Server Settings** reloads `settings.json` and notifies running servers.
Servers still starting receive the latest settings before becoming ready. Initialization
options and changes to server commands take effect with **Restart Language Servers**. An
invalid reload keeps the previous settings. An invalid restart configuration keeps the running
servers. A missing file uses defaults. Both configuration files have a 1 MiB limit.

Servers can request configuration sections, including dotted sections such as `gopls.hints`,
and the current workspace folder. Unknown sections and unknown resource scopes return `null`
in their matching response positions. Unsupported server requests receive a method error.

Work progress appears in the extension's status text. When several languages report progress,
the most recently updated live operation appears; ending it restores the next live operation.
**Cancel All Language Server Work** sends cancellation for every live operation marked
cancellable. The server decides when cancellation completes. Progress from a replaced server
cannot overwrite its replacement's status.

Language services follow the server's advertised capabilities. Servers may also register or
remove any of them (hover, completion, signature help, the definition-likes, references,
symbols, code actions, rename, formatting, hierarchies, selection ranges, links and diagnostics
on request) while running. Registrations can select documents by language, URI
scheme and path glob, including relative patterns. Invalid batches are rejected together.
There are at most 256 registrations and 1 MiB of registration options per server. Removing a
registration suppresses queued queries before the removal acknowledgement; requests already
written can finish. An independent static capability remains active.

## Server reliability

Requests have deadlines. Completion and language features use deadlines shorter than the
editor's own wait; initialization, hover and server commands wait at most 15 seconds. Timed
out requests release their pending state and send best effort `$/cancelRequest` notifications.
A server can have at most 256 pending requests.

Messages are limited to 8 KiB of headers and 16 MiB of JSON, with request IDs limited to
4 KiB and method names to 4 KiB. Configuration responses are checked cumulatively before building the full response. Invalid framing or JSON-RPC
messages end the server connection and show the reason in its status. Writes wait at most two
seconds. If a server stops reading its input, the extension stops it and releases pending work.
Use **Restart Language Servers** after correcting a server failure.

Exited servers are reaped immediately. The reader drains final responses before closing the
connection, with a 500 ms limit for pipes held open by descendant processes.

## Needs

Documents: write (completion, code actions, rename and formatting can edit documents).
Project: write, for compiler outputs, indexes and dependency metadata. Network: yes, for package
and schema resolution and build-tool coordination. The run list names the servers and their
runtime helpers (Node, Java, Ruby, Dune, GHC, Swift, Zig, Elixir and shell utilities). `@build`
permits compiler-generated programs in the extension cache and writable project, such as Swift
package manifests and Cargo build scripts. The user's other home files remain inaccessible.

Rustup toolchains require a rhun build that passes `RUSTUP_HOME` and permits the selected Rust
installation. Flutter's Dart server runs directly from its bundled Dart SDK. On macOS, Swift uses
the matching in-process SourceKit library from Xcode, with generated interfaces in extension
state. OCaml uses the tools alongside the selected `ocamllsp`; build the Dune project before
expecting compiler diagnostics. Zig type errors require a `check` step in `build.zig` and a save,
as described in the [ZLS guide](https://zigtools.org/zls/guides/build-on-save/).

## Build and test

`tests/run.sh [RHUN]` builds the extension and a fake language server, points the extension at
the fake through `lsp.ini`, lays everything out as rhun installs it and runs `tests/basic.txt`
headlessly: diagnostics, marks following an edit, incremental sync agreeing with the editor,
hover, go to definition, configuration callbacks, reloads, progress and cancellation;
`tests/lang.txt` and `tests/lang11.txt` the language features, including the provider scope,
references with a partial result, declaration, implementation, prepare-rename, Auto Fix, Format
Selection, formatting as you type, the call hierarchy and the Problems store; `tests/linked.txt`
linked editing in an HTML document; `tests/folders.txt` two workspace folders and a third added.
The Go tests drive
each protocol 1.1 mapping through the real SDK against an in-process fake rhun and fake server
(`harness_test.go`). Releases are built by the reusable workflow from
`rhun-editor/extension-template`.


The native gate also runs `tests/source-actions.py`: sequential edits, source-kind filtering,
resolution, command reply/edits ordering, fresh command sessions, duplicate action handling,
versions, foreign edits, cancellation, timeout and typing during a save.
