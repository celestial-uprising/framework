# debug

Debuggers for [rhun](https://rhun.app): Go with Delve, Python with debugpy, and C and C++ with
lldb-dap. rhun speaks the Debug Adapter Protocol to the adapters itself; this extension declares
them (`[debugger.TYPE]` in extension.ini) and prepares launches (feature `debug`, debug-resolve):

- **Go**: without `program`, the active file's package; `mode = test` for a `_test.go` file;
  `testAtCursor = yes` (the "Test at cursor" template) runs only the test the cursor is in
  (`-test.run ^TestXxx$`); outside a Go module it says so instead of launching. Delve listens on a
  port rhun picks (`dap --listen=127.0.0.1:${port}`).
- **Python**: the project's `.venv` or `venv` interpreter when `python` is not set (debugpy must be
  installed there: **Debug: Install debugpy**), and the program in a terminal tab by default
  (`console = integratedTerminal`) so it can read input.
- **C and C++**: lldb-dap (`xcrun lldb-dap` on macOS); build with `-g -O0` first, for example with
  `before = build`.

Templates for `.rhun/launch.ini` are in `debug/`. **Debug: Install Delve** proposes the
`go install` command in the terminal.

Install it from rhun: the extensions button in the title bar, **Install from GitHub…**, then
`rhun-editor/debug`. It needs rhun 0.18 (protocol 1.1, feature `debug`) and the debuggers
themselves: `dlv`, `debugpy` in the Python you debug with, and `lldb-dap` (Xcode's command line
tools on macOS, LLVM's `lldb-dap` on Linux and Windows).

## Settings

None of its own: a launch configuration's attributes (`.rhun/launch.ini`) choose the program,
arguments, environment and, for Python, the interpreter (`python = PATH`).

## Needs

Debug (the adapters run as you after rhun's one approval per project), documents and project
read (Test at cursor reads the test file; the virtual environment and go.mod are looked up),
terminal (the install commands).

## Build and test

```sh
go test ./...           # the resolver
tests/run.sh [RHUN]     # headless, debugging for real (python3)
tests/check.sh          # the protocol's conformance checker
```

`tests/run.sh` builds the extension, lays it out as rhun installs it and debugs for real: a Go
test at the cursor after a prelaunch build task, a Python program reading input in the terminal,
and a C program. Each workflow is skipped when its tool is missing (dlv or `RHUN_TEST_DLV`; a
python with debugpy in `RHUN_TEST_PYTHON`; cc and lldb-dap). A tag `vX.Y.Z` equal to `version` in
`extension.ini` builds Linux, macOS and Windows and publishes what Install from GitHub takes.
