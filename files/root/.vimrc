" General Settings
set nocompatible            " 禁用兼容模式，启用 Vim 扩展功能
set number                  " 显示行号
set relativenumber          " 显示相对行号
set showcmd                 " 显示命令
set cursorline              " 高亮显示当前行
set wildmenu                " 启用命令行自动补全菜单
set ignorecase              " 搜索时忽略大小写
set smartcase               " 如果搜索中包含大写字母，则大小写敏感
set incsearch               " 增量搜索
set hlsearch                " 搜索结果高亮

" Tabs and Indentation
set tabstop=4               " Tab 宽度为4个空格
set shiftwidth=4            " 自动缩进为4个空格
set expandtab               " 将Tab替换为空格
set autoindent              " 自动缩进
set smartindent             " 智能缩进

" Visual Settings
set background=dark         " 适合深色主题
syntax on                   " 启用语法高亮
set wrap                    " 自动换行
set linebreak               " 在单词边界处换行

" Clipboard
set clipboard=unnamedplus   " 使用系统剪贴板

" File Handling
set backspace=indent,eol,start  " 启用更智能的退格键
set undofile                " 启用撤销文件保存功能

" Performance
set lazyredraw              " 在宏或脚本执行时优化重绘
set ttyfast                 " 提升终端速度

" Status Line
set laststatus=2            " 始终显示状态栏

" Mappings
nnoremap <C-s> :w<CR>       " Ctrl+s 保存文件


