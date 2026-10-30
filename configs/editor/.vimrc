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
set mouse=                   " 启用鼠标
if has('clipboard')
  set clipboard=unnamedplus    " y/p 使用系统剪贴板
endif
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
" 删除/修改写入黑洞寄存器，不覆盖系统剪贴板
nnoremap d "_d
vnoremap d "_d
nnoremap D "_D
vnoremap D "_D
nnoremap x "_x
vnoremap x "_x
nnoremap X "_X
vnoremap X "_X
nnoremap c "_c
vnoremap c "_c
nnoremap C "_C
vnoremap C "_C

" Ex 命令删除到黑洞寄存器，避免 :%d 等污染系统剪贴板
cnoreabbrev %d %d_

" Space 清除搜索高亮
nnoremap <silent> <Space> :nohlsearch<CR>
" Ctrl+s 保存
nnoremap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>a
vnoremap < <gv
vnoremap > >gv

" 分屏移动
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ========== 代码编辑与补全 ==========
set hidden
set updatetime=300
set completeopt=menuone,noinsert,noselect
set shortmess+=c
if exists('+signcolumn')
  set signcolumn=yes
endif

" 保留用户额外的扩展；重复加载配置时不重复追加。
let g:coc_global_extensions = get(g:, 'coc_global_extensions', [])
for s:extension in ['coc-clangd', 'coc-pyright', 'coc-sh', 'coc-json',
      \ 'coc-git', 'coc-pairs', 'coc-vimlsp']
  if index(g:coc_global_extensions, s:extension) < 0
    call add(g:coc_global_extensions, s:extension)
  endif
endfor
unlet s:extension

" 默认配置随 .vimrc 部署；保留预设的 g:coc_user_config 和项目级覆盖。
" 注意：此变量的优先级高于用户级 :CocConfig，请在这里调整同名设置。
let g:coc_user_config = extend({
      \ 'suggest.noselect': v:true,
      \ 'semanticTokens.enable': v:true,
      \ 'diagnostic.refreshOnInsertMode': v:false,
      \ 'clangd.arguments': ['--background-index', '--completion-style=detailed',
      \                      '--header-insertion=never'],
      \ }, get(g:, 'coc_user_config', {}), 'force')

" ========== 插件管理 ==========
" 缺少 vim-plug 时保留基本编辑能力；已安装插件的真实错误不再被吞掉。
if exists('*plug#begin') || !empty(globpath(&runtimepath, 'autoload/plug.vim'))
  call plug#begin('~/.vim/plugged')

  Plug 'tpope/vim-surround'                  " 快速包裹符号
  Plug 'preservim/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
  Plug 'itchyny/lightline.vim'               " 状态栏
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim', { 'on': ['Files', 'GFiles', 'Buffers', 'Rg'] }
  Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }
  if has('nvim') ? has('nvim-0.8.0') : has('patch-9.0.0438')
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
  else
    echom '[terminal_set] CoC 需要 Vim >= 9.0.0438 或 Neovim >= 0.8.0，已跳过。'
  endif

  call plug#end()
else
  echom '[terminal_set] 未找到 vim-plug，使用基础编辑模式；安装后执行 :PlugInstall。'
endif
filetype plugin indent on

" ========== 插件配置 ==========
let g:lightline = { 'colorscheme': 'wombat' }
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
" 模板的正则高亮开销较大，类型信息优先由 clangd 语义高亮提供。
let g:cpp_experimental_template_highlight = 0

function! s:PluginCommand(command) abort
  if exists(':' . a:command) == 2
    execute a:command
  else
    echom '[terminal_set] 命令不可用：' . a:command . '，请先执行 :PlugInstall。'
  endif
endfunction

nnoremap <silent> <C-n> :call <SID>PluginCommand('NERDTreeToggle')<CR>
nnoremap <silent> <C-p> :call <SID>PluginCommand('Files')<CR>
nnoremap <silent> <C-g> :call <SID>PluginCommand('GFiles')<CR>
nnoremap <silent> <leader>fb :call <SID>PluginCommand('Buffers')<CR>
nnoremap <silent> <leader>fg :call <SID>PluginCommand('Rg')<CR>

function! s:CocReady() abort
  return exists('*coc#rpc#ready') && coc#rpc#ready()
endfunction

function! s:check_back_space() abort
  let column = col('.') - 1
  return !column || getline('.')[column - 1] =~ '\s'
endfunction

function! s:CocTab() abort
  if s:CocReady() && coc#pum#visible()
    return coc#pum#next(1)
  endif
  if pumvisible()
    return "\<C-n>"
  endif
  return s:check_back_space() || !s:CocReady() ? "\<Tab>" : coc#refresh()
endfunction

function! s:CocShiftTab() abort
  if s:CocReady() && coc#pum#visible()
    return coc#pum#prev(1)
  endif
  return pumvisible() ? "\<C-p>" : "\<C-d>"
endfunction

function! s:CocEnter() abort
  if s:CocReady() && coc#pum#visible()
    return coc#pum#confirm()
  endif
  return s:CocReady() ? "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>" : "\<C-g>u\<CR>"
endfunction

inoremap <silent><expr> <Tab> <SID>CocTab()
inoremap <silent><expr> <S-Tab> <SID>CocShiftTab()
inoremap <silent><expr> <CR> <SID>CocEnter()
inoremap <silent><expr> <C-Space> <SID>CocReady() ? coc#refresh() : "\<C-n>"

function! s:ShowDocumentation() abort
  if &filetype ==# 'vim' || &filetype ==# 'help'
    execute 'help ' . expand('<cword>')
  elseif s:CocReady() && CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    normal! K
  endif
endfunction

" CoC 初始化成功后再接管原生跳转键，基础模式仍保留 Vim 的 gd、K。
function! s:CocMappings() abort
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
  nmap <silent> <leader>rn <Plug>(coc-rename)
  nmap <silent> <leader>ca <Plug>(coc-codeaction-cursor)
  nmap <silent> <leader>f <Plug>(coc-format)
  xmap <silent> <leader>f <Plug>(coc-format-selected)
  nnoremap <silent> K :call <SID>ShowDocumentation()<CR>
endfunction

augroup terminal_set_coc
  autocmd!
  autocmd FileType c,cpp let b:coc_pairs_disabled = ['<']
  autocmd User CocNvimInit call <SID>CocMappings()
augroup END
if s:CocReady()
  call s:CocMappings()
endif
