#!/usr/bin/env zsh

# refined-catppuccin - Refined theme structure with Catppuccin colors
# Based on the "refined" theme by Sindre Sorhus with Catppuccin color palette

# Load Catppuccin flavor
if [ "$CATPPUCCIN_FLAVOR" = "frappe" ]; then
    source ${0:A:h}/catppuccin-flavors/frappe.zsh
elif [ "$CATPPUCCIN_FLAVOR" = "latte" ]; then
    source ${0:A:h}/catppuccin-flavors/latte.zsh
elif [ "$CATPPUCCIN_FLAVOR" = "macchiato" ]; then
    source ${0:A:h}/catppuccin-flavors/macchiato.zsh
else
    source ${0:A:h}/catppuccin-flavors/mocha.zsh
fi

setopt prompt_subst

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable hg bzr git
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' formats "$FX[bold]%r$FX[no-bold]/%S" "%s:%b" "%%u%c"
zstyle ':vcs_info:*:*' actionformats "$FX[bold]%r$FX[no-bold]/%S" "%s:%b" "%u%c (%a)"
zstyle ':vcs_info:*:*' nvcsformats "%~" "" ""

git_dirty() {
    command git rev-parse --is-inside-work-tree &>/dev/null || return
    command git diff --quiet --ignore-submodules HEAD &>/dev/null; [ $? -eq 1 ] && echo "*"
}

repo_information() {
    echo "%F{${catppuccin_blue}}${vcs_info_msg_0_%%/.} %F{${catppuccin_overlay1}}$vcs_info_msg_1_`git_dirty` $vcs_info_msg_2_%f"
}

cmd_exec_time() {
    local stop=`date +%s`
    local start=${cmd_timestamp:-$stop}
    let local elapsed=$stop-$start
    [ $elapsed -gt 5 ] && echo ${elapsed}s
}

preexec() {
    cmd_timestamp=`date +%s`
}

precmd() {
    setopt localoptions nopromptsubst
    vcs_info
    print -P "\n$(repo_information) %F{${catppuccin_yellow}}$(cmd_exec_time)%f"
    unset cmd_timestamp
}

PROMPT="%(?.%F{${catppuccin_mauve}}.%F{${catppuccin_red}})❯%f "
RPROMPT="%F{${catppuccin_overlay1}}${SSH_TTY:+%n@%m}%f"

























