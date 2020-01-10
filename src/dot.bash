#! /usr/bin/env bash

die() {
    echo >&2 "$@"
    exit 1
}

do_git_clone() {
    $DRY_RUN_CMD git clone --bare "$1" "$HOME/.files" 2>/dev/null || true
}

do_git() {
    $DRY_RUN_CMD git -C "$HOME" --git-dir="$HOME/.files" --work-tree="$HOME" "$@"
}

cmd_init() {
    [ "$#" -eq 1 ] || die "1 argument required, $# provided"

    do_git_clone
    do_git checkout
    do_git config status.showUntrackedFiles no
}

cmd_git() {
    do_git "$@"
}

cmd_inspect() {
    # do_git ls-files --other --exclude=.cache | grep -v /
    do_git config status.showUntrackedFiles normal
    do_git status --porcelain "$@"
    do_git config status.showUntrackedFiles no
}

case "$1" in
    init) shift;    cmd_init "$@" ;;
    inspect) shift; cmd_inspect "$@";;
    *)              cmd_git "$@" ;;

esac

exit 0
