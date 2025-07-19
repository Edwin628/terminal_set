" ========== 基础设置 ==========
set nocompatible              " 禁用兼容模式
syntax on                    " 启用语法高亮
set number                   " 显示行号
set relativenumber           " 显示相对行号
set cursorline               " 高亮当前行
set showcmd                  " 显示命令
set showmode                 " 显示当前模式
set wildmenu                 " 命令行补全美化
set ruler                    " 显示行列号
set mouse=a                  " 启用鼠标
set clipboard=unnamedplus    " 使用系统剪贴板
set title                    " 显示窗口标题

" ========== 缩进与对齐 ==========
set tabstop=4                " tab宽度
set shiftwidth=4             " 自动缩进宽度
set expandtab                " 将tab转为空格
set autoindent               " 自动缩进
set smartindent              " 智能缩进

" ========== 搜索 ==========
set ignorecase               " 搜索忽略大小写
set smartcase                " 有大写则大小写敏感
set incsearch                " 增量搜索
set hlsearch                 " 高亮搜索

" ========== 界面美化 ==========
set background=dark
colorscheme desert           " 更换为 desert 主题

" ========== 文件与编码 ==========
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,gbk

" ========== 状态栏 ==========
set laststatus=2             " 总是显示状态栏
set statusline=%f%m%r%h\ [%{&ff}]\ %y\ [%l,%v]\ [%p%%]

" ========== 快捷键增强 ==========
nnoremap <Space> :noh<CR>    " Space 清除搜索高亮
nmap <C-s> :w<CR>            " Ctrl+s 保存
imap <C-s> <Esc>:w<CR>a
vnoremap < <gv
vnoremap > >gv

" 分屏移动
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ========== 插件管理 ==========
" 静默加载插件，不显示错误信息
silent! call plug#begin('~/.vim/plugged')

silent! Plug 'tpope/vim-surround'             " 快速包裹符号
silent! Plug 'preservim/nerdtree'            " 文件树
silent! Plug 'jiangmiao/auto-pairs'          " 自动括号
silent! Plug 'itchyny/lightline.vim'         " 状态栏
silent! Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " 模糊搜索
silent! Plug 'junegunn/fzf.vim'
silent! Plug 'sheerun/vim-polyglot'          " 多语言语法支持
silent! Plug 'neoclide/coc.nvim', {'branch': 'release'}      " LSP 补全引擎

silent! call plug#end()

" ========== 插件配置 ==========
" NerdTree 快捷键（静默加载）
silent! nmap <C-n> :NERDTreeToggle<CR>

" Lightline 主题（静默加载）
silent! let g:lightline = { 'colorscheme': 'wombat' }

" CoC 设置（自动补全，静默加载）
silent! inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

silent! function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

