" vim-plug 插件管理器
" 简化版本，用于解决当前的插件加载问题

function! plug#begin(...)
  " 插件开始标记
  let g:plugs = {}
endfunction

function! plug#end()
  " 插件结束标记
endfunction

function! plug#(repo, ...)
  " 插件定义函数
  let g:plugs[split(a:repo, '/')[-1]] = a:repo
endfunction

" 定义 Plug 命令
command! -nargs=+ Plug call plug#(<args>) 