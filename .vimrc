if empty(glob('~/.vim/autoload/plug.vim'))
  execute "silent !curl -fLo " . fnamemodify("~/.vim/autoload/plug.vim", ":p") . " --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall --sync
endif

source ~/.config/nvim/init.vim

