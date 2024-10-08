set mouse=a  " enable mouse
set encoding=utf-8
set number
set cursorline
set noswapfile
set scrolloff=7



call plug#begin()
" Packer o'zini o'rnatish
Plug 'wbthomason/packer.nvim'

""
Plug 'neovim/nvim-lspconfig'     " LSP konfiguratsiyasi uchun
Plug 'hrsh7th/nvim-cmp'           " Autocompletion uchun
Plug 'hrsh7th/cmp-nvim-lsp'       " LSP bilan ishlash uchun nvim-cmp
Plug 'hrsh7th/cmp-buffer'         " Buffer-based completion
Plug 'hrsh7th/cmp-path'           " Fayl yo'llari uchun completion
Plug 'hrsh7th/cmp-cmdline'        " Komanda qatori uchun completion
Plug 'L3MON4D3/LuaSnip'           " Snippetlar uchun
Plug 'saadparwaiz1/cmp_luasnip'
"colors
Plug 'briones-gabriel/darcula-solid.nvim'
Plug 'rktjmp/lush.nvim'
Plug 'ellisonleao/gruvbox.nvim'



" coc.nvim o'rnatish
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Auto close tag plagin
Plug 'm4xshen/autoclose.nvim'

" nvim-tree
Plug 'nvim-neo-tree/neo-tree.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'MunifTanjim/nui.nvim'

" Floaterm
Plug 'voldikss/vim-floaterm'

" Add bufferline.nvim
Plug 'akinsho/bufferline.nvim'

call plug#end()

set background=dark " or light if you want light mode
""colorscheme gruvbox


colorscheme darcula-solid





autocmd BufWritePre * silent! call CocAction('runCommand', 'editor.action.organizeImport')

if filereadable(expand("$LOCALAPPDATA/nvim/coc-settings.json"))
  let g:coc_user_config_file = expand("$LOCALAPPDATA/nvim/coc-settings.json")
endif

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'

inoremap <silent><expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

inoremap <silent><expr> <TAB> pumvisible() ? "\<CR>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<CR>" : "\<S-TAB>"

autocmd BufWritePre *.py :CocCommand python.sortImports

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')


lua << EOF
require("autoclose").setup()
EOF

let g:nvim_tree_auto_ignore_ft = ['dashboard']  
let g:nvim_tree_quit_on_open = 1  

let g:floaterm_keymap_toggle = '<C-t>'
let g:floaterm_keymap_new = '<C-n>'
let g:floaterm_keymap_prev = '<C-p>'
let g:floaterm_keymap_next = '<C-k>'
let g:floaterm_keymap_kill = '<C-x>'
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9

lua << EOF
require("bufferline").setup({
  options = {
    numbers = "none",
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    left_mouse_command = "buffer %d",
    middle_mouse_command = nil,
    offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "left"}},
    show_buffer_close_icons = true,
    show_buffer_icons = true,
    show_tab_indicators = true,
    separator_style = "thin",
    enforce_regular_tabs = true,
    always_show_bufferline = true,
    sort_by = "id",
  },
})
EOF



nnoremap <C-c> :w !clip<CR><CR>
vnoremap <C-c> :w !clip<CR><CR>         -- ctrl+c copy text
inoremap <C-c> <Esc>:w !clip<CR><CR> 

nnoremap <C-x> :w !clip<CR><CR>
vnoremap <C-x> :w !clip<CR><CR>         -- ctrl+x delete text
inoremap <C-x> <Esc>:w !clip<CR><CR>

nnoremap <C-v> :r !powershell -command "Get-Clipboard"<CR>
vnoremap <C-v> :r !powershell -command "Get-Clipboard"<CR>        --ctrl+v paste text
inoremap <C-v> <Esc>:r !powershell -command "Get-Clipboard"<CR>

nnoremap <C-z> u
vnoremap <C-z> u        
inoremap <C-z> <Esc>u

nnoremap <C-y> <C-r>
vnoremap <C-y> <C-r>
inoremap <C-y> <C-r>

nnoremap <C-tab> :bnext<CR>
nnoremap <C-S-tab> :bprevious<CR>

nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>

noremap <C-a> ggVG

lua << EOF
require("neo-tree").setup {
  sources = { "filesystem", "git_status" }, -- Qo'llab-quvvatlanadigan manbalar
  close_if_last_window = true,              -- Oxirgi oynani yopish
  popup_border_style = "rounded",            -- Popup chegarasi uslubi
  window = {
    position = "left",                       -- Neo-tree oynasining pozitsiyasi
    width = 30,                              -- Oynaning kengligi
    mappings = {
      ["<space>"] = false,                  -- Oynada har qanday maxsus klavish
    },
  },
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,                 -- Yashirin fayllarni ko‘rsatish
      hide_gitignored = false,                 -- Git tomonidan e'tiborga olinmagan fayllarni yashirish
    },
  },
  git_status = {
    symbols = {
      added = "✚",                           -- Qo'shilgan fayllar belgisi
      modified = "✹",                        -- O'zgargan fayllar belgisi
      deleted = "✘",                         -- O'chirilgan fayllar belgisi
      renamed = "➜",                         -- Nomlangan fayllar belgisi
      untracked = "●",                       -- Kuzatilmagan fayllar belgisi
      ignored = "☒",                         -- E'tiborga olinmagan fayllar belgisi
    },
  },
}
EOF

nnoremap <C-d> :Neotree toggle<CR>

nnoremap <C-f> :Neotree focus<CR>

nnoremap <S-%> :lua require("neo-tree").commands.create_file(require("neo-tree").get_state())<CR>

nnoremap <S-d> :lua require("neo-tree").commands.create_directory(require("neo-tree").get_state())<CR>


nnoremap <S-n> :BufferLineCycleNext<CR>
nnoremap <S-p> :BufferLineCyclePrev<CR>


lua << EOF
local lspconfig = require('lspconfig')

-- Python uchun pyright LSP o'rnatish
lspconfig.pyright.setup{}

-- nvim-cmp konfiguratsiyasi
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require('luasnip').expand_or_jumpable() then
        require('luasnip').expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require('luasnip').jumpable(-1) then
        require('luasnip').jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

-- `:` cmdline uchun completion
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

EOF
