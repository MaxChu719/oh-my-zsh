function git_prompt_info() {
   ref=$(git symbolic-ref HEAD 2> /dev/null) || return
   echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function get_pwd() {
   print -D $PWD
}

function get_env() {
   if [ ${#VIRTUAL_ENV} != 0 ]; then
       echo ${#VIRTUAL_ENV} + 31
   else
       echo ${#VIRTUAL_ENV}
   fi
}

function put_spacing() {
   local git=$(git_prompt_info)
   if [ ${#git} != 0 ]; then
       ((git=${#git} - 10))
   else
       git=0
   fi

   local termwidth
   ((termwidth = ${COLUMNS} - 5 - ${#HOST} - ${#$(get_pwd)} - ${git}))

   local spacing=""
   for i in {1..$termwidth}; do
       spacing="${spacing} "
   done
   echo $spacing
}

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function precmd() {
print -rP '%{$fg[green]%}╔ %{$fg[cyan]%}%m: %{$fg[yellow]%}$(get_pwd)$(put_spacing)%{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}'
}

PROMPT='%{$fg[green]%}╚ %{$reset_color%}$(virtualenv_info) %{$fg_bold[blue]%}%n ⇒ %{$reset_color%}'

VIRTUAL_ENV_DISABLE_PROMPT=True

ZSH_THEME_GIT_PROMPT_PREFIX="[git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="]"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✚"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}✖"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"
