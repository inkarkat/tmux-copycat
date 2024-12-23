#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

unbind_cancel_bindings() {
	local cancel_mode_bindings=$(copycat_quit_copy_mode_keys copycat_mode_quit.sh)
	local key
	for key in $cancel_mode_bindings; do
		tmux unbind-key -n "$key"
	done
}

unbind_prev_next_bindings() {
	tmux unbind-key -n "$(copycat_next_key)"
	tmux unbind-key -n "$(copycat_prev_key)"
}

unbind_all_bindings() {
	grep -v copycat </tmp/copycat_$(whoami)_recover_keys | while read key_cmd; do
		sh -c "tmux $key_cmd"
	done < /dev/stdin
	rm /tmp/copycat_$(whoami)_recover_keys
}

main() {
	if in_copycat_mode; then
		reset_copycat_position
		unset_copycat_mode
		copycat_decrease_counter
		eval "$(get_tmux_option "$tmux_option_on_copycat_mode_quit" '')"
	fi
}
main
