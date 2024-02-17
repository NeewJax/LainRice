# Lain.zsh-theme

autoload -U add-zsh-hook
autoload -Uz vcs_info

local c1=$'\e[38;5;209m\e[1m'  # Color for "jax@archlinux"
local c2=$'\e[35m'
local c3=$'\e[31m'
local c4=$'\e[31;1m'
local c5=$'\e[32m'
local c6=$'\e[32;1m'
local c12=$'#cb6f86\e[1m'  # Color for Git indicators
local c13=$'#cb6f86\e[1m'  # Color for Git indicators

zsh_path() {
  setopt localoptions nopromptsubst

  local colors
  colors=$(echoti colors)

  local -A yellow
  yellow=(
    1  '%F{228}'   2  '%F{222}'   3  '%F{192}'   4  '%F{186}'
    5  '%F{227}'   6  '%F{221}'   7  '%F{191}'   8  '%F{185}'
    9  '%F{226}'   10  '%F{220}'   11  '%F{190}'   12  '%F{184}'
    13  '%F{214}'   14  '%F{178}'  15  '%F{208}'   16  '%F{172}'
    17  '%F{202}'   18  '%F{166}'
  )

  local dir i=1
  for dir (${(s:/:)PWD}); do
    if [[ $i -eq 1 ]]; then
      if [[ $colors -ge 256 ]]; then
        print -Pn "%F{065}%B $c1%n%{$reset_color%}%b"
      else
        print -Pn "\e[31;1m /"
      fi
    else
      if [[ $colors -ge 256 ]]; then
        print -Pn "${yellow[$i]:-%f} » "
      else
        print -Pn "%F{yellow} > "
      fi
    fi

    (( i++ ))

    if [[ $colors -ge 256 ]]; then
      print -Pn "%F{065}$dir"
    else
      print -Pn "%F{blue}$dir"
    fi
  done
  print -Pn "%f"
}

zstyle ':vcs_info:*' actionformats \
    '%{$c8%}(%f%s)%{$c7%}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '

zstyle ':vcs_info:*' formats \
    "%{$c8%}%s%%{$c7%}❨ %{$c9%}%{$c11%}%b%{$c7%} ❩%{$reset_color%}%f "

zstyle ':vcs_info:*' enable git

add-zsh-hook precmd prompt_jnrowe_precmd

prompt_jnrowe_precmd () {
  vcs_info
  local dir_status="%{$c1%} %n%{$c4%}@%{$c2%}%m%{$c0%}:%{$c3%}%l%{$c6%}->%{$(zsh_path)%} %{$c0%}(%{$c5%}%?%{$c0%})"

  if [ -n "${vcs_info_msg_0_}" ]; then
    dir_status+=" %{$c12%}G%{$reset_color%}"
  fi

  if [[ -d .git || -n $(git rev-parse --git-dir 2>/dev/null) ]]; then
    dir_status+=" %{$c13%}>"
  fi

  PROMPT="${dir_status}%{$reset_color%}
> "
}