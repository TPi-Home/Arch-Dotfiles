# ======================
# Environment
# ======================
export PATH="$HOME/.local/bin:$PATH"
export LANG=en_US.UTF-8

# If you ever see Ctrl+S "freeze" the terminal, this prevents it:
stty -ixon 2>/dev/null

# ======================
# Line editor base mode
# ======================
bindkey -e   # emacs-style (sane default)

# ======================
# Completion system
# ======================
autoload -Uz compinit
compinit

# ======================
# Plugins
# ======================

# Autosuggestions (don’t let it accept on Tab)
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(end-of-line forward-char)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# History substring search (enable arrows only if you want it)
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Syntax highlighting MUST be last plugin
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ======================
# Prompt (oh-my-posh)
# ======================
eval "$(oh-my-posh init zsh --config ~/.cache/oh-my-posh/themes/M365Princess.omp.json)"

# ======================
# zkbd (optional) + Keybindings
# ======================

# Load zkbd-generated key sequences if you have them
autoload -Uz zkbd 2>/dev/null
if [[ -d ~/.zkbd ]]; then
  # Source any non-tmp zkbd files for this terminal type
  for f in ~/.zkbd/${TERM}-*; do
    [[ -f "$f" && "$f" != *.tmp ]] && source "$f"
  done
fi

# Backspace (usually correct already, but harmless)
stty erase '^?' 2>/dev/null

# Delete/Home/End using zkbd if available, otherwise fall back
if [[ -n ${key[Delete]} ]]; then
  bindkey "${key[Delete]}" delete-char
else
  bindkey '^[[3~' delete-char   # common xterm-256color Delete
fi

[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[End]}  ]] && bindkey "${key[End]}"  end-of-line

# Force Tab to ONLY complete (prevents weird interactions)
bindkey '^I' expand-or-complete
bindkey -M emacs '^I' expand-or-complete
bindkey -M viins '^I' expand-or-complete
bindkey -M menuselect '^I' expand-or-complete

# Useful word ops that avoid Windows-key combos
bindkey '^[^?' backward-kill-word   # Alt+Backspace (common)
bindkey '^[d'  kill-word            # Alt+d
bindkey '^[D'  kill-word

