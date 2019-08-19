# Load dotfiles like ~/.bash_prompt, etc…
#   ~/.extra is used for settings not committed to the repository,
for file in ~/.{extra,path,bash_prompt,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
