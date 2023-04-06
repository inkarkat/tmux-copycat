#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

SUPPORTED_VERSION="1.9"

PATTERN="$1"

supported_tmux_version_ok() {
	$CURRENT_DIR/check_tmux_version.sh "$SUPPORTED_VERSION"
}

main() {
	local pattern="$1"
	if supported_tmux_version_ok; then
		$CURRENT_DIR/copycat_generate_results.sh "$pattern" || return 0 # will `exit 1` if no results
		$CURRENT_DIR/copycat_jump.sh 'next'
	fi
}
main "$PATTERN"
