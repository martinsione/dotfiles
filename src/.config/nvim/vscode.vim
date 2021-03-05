" General
set hlsearch
set timeoutlen=1000
set ignorecase
set smartcase
set clipboard=unnamedplus

"-------------------- Vim mappings -------------------------------------
" Leader key
let mapleader=" "
inoremap <C-c> <Esc>
nnoremap <C-c> <Esc>
nnoremap <expr> <CR> {-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()

" Indent selected code with < / >
vnoremap < <gv
vnoremap > >gv
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

"-------------------- Better navigation --------------------------------
nnoremap <silent> <C-j>       <cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>
nnoremap <silent> <C-k>       <cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>
nnoremap <silent> <C-h>       <cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>
nnoremap <silent> <C-l>       <cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>

nnoremap <silent> K           <cmd>call VSCodeNotify('editor.action.showHover')<CR>
nnoremap <silent> <space>gr   <cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
nnoremap <silent> <space>qf   <cmd>call VSCodeNotify('editor.action.quickFix')<CR>
nnoremap <silent> <space>gd   <cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>
nnoremap <silent> <C-w>gd     <cmd>call VSCodeNotify('editor.action.revealDefinitionAside')<CR>

"-------------------- Buffers ------------------------------------------
" Close active buffer
nnoremap <silent> <space>bd   <cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>

" Move buffers
nnoremap <silent> <space>h    <cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
nnoremap <silent> <space>j    <cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
nnoremap <silent> <space>k    <cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
nnoremap <silent> <space>l    <cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>

"Reopen closed buffer
nnoremap <silent> <space>bu   <cmd>call VSCodeNotify('workbench.action.reopenClosedEditor')<CR>

" Navigation between buffers
nnoremap <silent> <TAB>       <cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>
nnoremap <silent> <S-TAB>     <cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>


"-------------------- Commentary ---------------------------------------
xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

"-------------------- General ------------------------------------------
nnoremap <silent> <space>.    <cmd>call VSCodeNotify('workbench.action.openSettingsJson')<CR>
nnoremap <silent> <space>;    <cmd>call VSCodeNotify('workbench.action.showCommands')<CR>
nnoremap <silent> <space>m    <cmd>call VSCodeNotify('editor.action.toggleMinimap')<CR>
nnoremap <silent> <space>z    <cmd>call VSCodeNotify('workbench.action.toggleZenMode')<CR>

"-------------------- Search -------------------------------------------
nnoremap <silent> <C-p>       <cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
nnoremap <silent> <space>pb   <cmd>call VSCodeNotify('workbench.action.showAllEditors')<CR>


"-------------------- Show ---------------------------------------------

" Show debug console
nnoremap <silent> <space>sd   <cmd>call VSCodeNotify('workbench.debug.action.toggleRepl')<CR>

" Show file explorer
nnoremap <silent> <space>se   <cmd>call VSCodeNotify('workbench.view.explorer')<CR>

" Show source control
nnoremap <silent> <space>sg   <cmd>call VSCodeNotify('workbench.view.scm')<CR>

" Show output
nnoremap <silent> <space>so   <cmd>call VSCodeNotify('workbench.action.output.toggleOutput')<CR>

" Show problem
nnoremap <silent> <space>sp   <cmd>call VSCodeNotify('workbench.actions.view.problems')<CR>

" Show remote explorer
nnoremap <silent> <space>sr   <cmd>call VSCodeNotify('workbench.view.remote')<CR>

" Show terminal
nnoremap <silent> <space>st   <cmd>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>

" Show extensions
nnoremap <silent> <space>sx   <cmd>call VSCodeNotify('workbench.view.extensions')<CR>

"-------------------- Open ---------------------------------------------
nnoremap <silent> <space>od   <cmd>call VSCodeNotify('workbench.action.files.openFolder')<CR>
nnoremap <silent> <space>of   <cmd>call VSCodeNotify('workbench.action.files.openFile')<CR>
nnoremap <silent> <space>or   <cmd>call VSCodeNotify('workbench.action.openRecent')<CR>

"-------------------- UI toggles ---------------------------------------
nnoremap <silent> <space>ua   <cmd>call VSCodeNotify('workbench.action.toggleActivityBarVisibility')<CR>
nnoremap <silent> <space>uf   <cmd>call VSCodeNotify('workbench.action.toggleFullScreen')<CR>
nnoremap <silent> <space>us   <cmd>call VSCodeNotify('workbench.action.selectTheme')<CR>
