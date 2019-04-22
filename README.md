# vim_setup
My  current vim-config &amp; submodules

    install vim
    run the script below
    add new submodule: git submodule add <git-repo-for-plugin> ./bundle/<plugin-name>

```bash
  #!/bin/bash
  cd ~
  mkdir .vim
  cd .vim
  git clone --recurse-submodules https://github.com/matildasmeds/vim_setup.git .
  ln -s ~/.vim/vimrc ~/.vimrc
```
