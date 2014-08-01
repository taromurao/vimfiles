#!/bin/sh
cp -r ~/.vim ~/.vim.old 2>/dev/null
rm -fr ~/.vim 2>/dev/null
rm -f ~/.vimrc 2>/dev/null
git clone https://github.com/taromurao/vimfiles ~/.vim && cd ~/.vim && vim -c BundleInstall! -c q -c q -u bundles.vim && ln -s ~/.vim/vimrc ~/.vimrc && git clone git@github.com:Shougo/vimproc.vim.git ~/.vim/bundle/vimproc.vim && cd ~/.vim/bundle/vimproc.vim && make
