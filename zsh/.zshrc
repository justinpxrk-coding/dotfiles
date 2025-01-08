# Justin Park (github.com/justinpxrk-coding)
#
# Contains my zsh configuration for interactive zsh shells.

### Benchmarking Tools
# zmodload profiles zsh startup calls and start_time/end_time are used to
# calculate execution time. These tools should be used separately for accurate
# results. Make sure to uncomment the corresponding commands at the bottom of
# this script as well.
#
# zmodload zsh/zprof
# start_time=$(date +%s)
###

# Define XDG home path environment variables only. All other path environment
# variables should be defined in .zshrc_paths
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"

# Enable Powerlevel10k instant prompt. Should stay close to the top of
# ~/.config/zsh/.zshrc. Initialization code that may require console input
# (password prompts, [y/n] confirmations, etc.) must go above this block;
# everything else may go below.
if
  [[
    -f "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
  ]];
then 
  source "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
if [[ -f "${XDG_CONFIG_HOME}/zsh/.p10k.zsh" ]]; then
  source "${XDG_CONFIG_HOME}/zsh/.p10k.zsh"
fi

# Source Other Config Files
zsh_config_home="${XDG_CONFIG_HOME}/zsh"
# Configure Paths
source "${zsh_config_home}/.zshrc_paths"
# Configure aliases
source "${zsh_config_home}/.zshrc_aliases"

# Load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# Load Zinit plugins
# powerlevel10k
zinit for \
    light-mode \
  romkatv/powerlevel10k

# After loading eval-cache, run `source .zshrc_evals` since `.zshrc_evals`
# relies on `_evalcache`
zinit for \
    atload"source ${zsh_config_home}/.zshrc_evals" \
    lucid \
    wait \
  mroth/evalcache

# Turbo mode (load asynchronously after first prompt)
zinit for \
    lucid \
    wait \
  rupa/z \
  zsh-users/zsh-autosuggestions \
  lukechilds/zsh-nvm

# fast-syntax-highlighting should be loaded last so `zicompinit` can be hooked
# before it loads
zinit for \
    atinit"zicompinit; zicdreplay" \
    lucid \
    wait \
  zdharma-continuum/fast-syntax-highlighting

# Unset any non exported variables here to avoid memory leaks
unset zsh_config_home

### Benchmarking Tools
# zprof
# end_time=$(date %s)
# echo "Initialization took $(($end_time - $start_time)) seconds."
###
