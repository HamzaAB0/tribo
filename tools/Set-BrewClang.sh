#!/usr/bin/env sh

# Source this file to use Homebrew Clang for subsequent shell commands:
#   . ./tools/Set-BrewClang.sh

if ! command -v brew >/dev/null 2>&1; then
    printf '%s\n' 'Homebrew was not found on PATH.' >&2
    return 1 2>/dev/null || exit 1
fi

if ! _brewclang_prefix=$(brew --prefix llvm); then
    printf '%s\n' 'Could not locate Homebrew LLVM. Install it with: brew install llvm' >&2
    unset _brewclang_prefix
    return 1 2>/dev/null || exit 1
fi

if [ ! -x "$_brewclang_prefix/bin/clang" ]; then
    printf '%s\n' 'Homebrew Clang was not found. Install it with: brew install llvm' >&2
    unset _brewclang_prefix
    return 1 2>/dev/null || exit 1
fi

case "$PATH" in
    "$_brewclang_prefix/bin"|"$_brewclang_prefix/bin":*) ;;
    *) export PATH="$_brewclang_prefix/bin:$PATH" ;;
esac

unset _brewclang_prefix
