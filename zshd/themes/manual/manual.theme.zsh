# nopriv/priv user prompts
plebe="->"
root="*>"

# ret_color is a string that will prompt expand to red or green depending on return value
ret_color="%(?.green.red)"
# string that prompt expands to >> or #> depending on the users privilege
user_prompt="%(!.$plebe.$root)"

status_prompt="%{\$fg[${ret_color}]%}${user_prompt}%{\$reset_color%}"


PROMPT="%{$fg[green]%} %~ %{$reset_color%}${status_prompt}"

# RPROMPT= $(git_prompt_info)$(svn_prompt_info) %{$fg[blue]%}%0(t.%b.)[%T]%0(t.%b.)%{$reset_color%}


m_time_color="%{$fg_bold[blue]%}"
m_time="%{$m_time_color%}[%T] %{$reset_color%}"



RPROMPT="$(git_prompt_info) $m_time"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}<" 
ZSH_THEME_GIT_PROMPT_SUFFIX=">%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[blue]%} %{$fg_bold[yellow]%}dirty%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[blue]%} %{$fg_bold[green]%}clean%{$reset_color%}"

ZSH_PROMPT_BASE_COLOR="%{$fg_bold[cyan]%}"
ZSH_THEME_REPO_NAME_COLOR="%{$fg_bold[red]%}"

ZSH_THEME_SVN_PROMPT_PREFIX="svn:["
ZSH_THEME_SVN_PROMPT_SUFFIX="]"
ZSH_THEME_SVN_PROMPT_DIRTY="%{$fg[yellow]%} dirty %{$reset_color%}"
ZSH_THEME_SVN_PROMPT_CLEAN=" "
