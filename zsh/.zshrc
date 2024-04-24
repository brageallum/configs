## FROM AUTOCONFIG

ZSH_THEME="powerlevel10k/powerlevel10k"

for config_file ($HOME/.zsh/*.zsh); do
    source $config_file
done

## END AUTOCONFIG

