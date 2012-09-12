# {{{ variables
# TODO complete bellowing list
# %m -- machine name
# %n -- username
# %c -- base path
# %~ -- full path
# %D -- date
# %T -- time
# %I -- running tasks
# %M -- hostname
# %B
# %b
# %S
# %p --
# %y -- login tty, e.g. pts/1
# %(!.#.$) -- root or user prompt
# %(?, ,%{$fg[red]%}FAIL%{$reset_color%})
# return_code='%(?..%{$fg[red]%}%? ↵%{$reset_color%})'
# }}}

# {{{ special characters
# ➤  ↵  »  ✔  ✗  ➜  ✚  ✹  ✖  ═  ✭  ⚡  ➭  ❮
# ▍ ♩ & ♫  ♪ ♬  ♭ ♮ ♯ ☺  ☻ ::  ⏎  
# ♥  ♦ ♣  ♠  • ◘ ○ ◙  ♂ ♀ 
# ☭  , ⌘  , ☠, ⌥  , ✇ , ⌤  , 
# ⍜ , ✣ , ⌨   , ⌘, ☕  
# ☮ ☠ ☻ ❀ ☃ ☆ ☄  ☢ ☉ ◎ ⊙ ░ ⍟  
# ￬ ￪ ￫ ￩ ⇧ ⇩ ⇨ ⇦ ↑ ↓ ≠ ∞ ⿻  □  "
# ☼ ► ◄  ↕ 
# }}} 

function git_prompt_info() {
   ref=$(git symbolic-ref HEAD 2> /dev/null) || return
   echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX$(git_prompt_status)"
}

function get_pwd() {
   print -D $PWD
}

function get_env() {
   if [ ${#VIRTUAL_ENV} != 0 ]; then
       echo ${#VIRTUAL_ENV} + 30
   else
       echo ${#VIRTUAL_ENV}
   fi
}

function put_spacing() {
   local git=$(git_prompt_info)
   if [ ${#git} != 0 ]; then
       ((git=${#git} - 25))
   else
       git=0
   fi

   local termwidth
   ((termwidth = ${COLUMNS} - 5 - ${#HOST} - ${#$(get_pwd)} - ${git}))

   local spacing=""
   for i in {1..$termwidth}; do
       spacing="${spacing}="
   done
   echo $spacing
}

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function precmd() {
print -rP '%{$fg[green]%}╔ %{$fg[cyan]%}%m: %{$fg[green]%}$(get_pwd)%{$fg[yellow]%}$(put_spacing)$(git_prompt_info)'
}

PROMPT='%{$fg[green]%}╚ %{$reset_color%}$(virtualenv_info) %{$fg_bold[blue]%}%n%{$fg[yellow]%} ⇒ %{$reset_color%}'

VIRTUAL_ENV_DISABLE_PROMPT=True

ZSH_THEME_GIT_PROMPT_PREFIX="[git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✓"

## git status
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚ ADDED"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%}✹ MODIFIED"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖ DELETED"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%}➜ RENAMED"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%}⌥ UNMERGED" 
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%}⌘ UNTRACKED"
