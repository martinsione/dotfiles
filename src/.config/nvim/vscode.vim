" General
set rtp=$VIMRC
set nohlsearch
set timeoutlen=500
set ignorecase
set smartcase
set clipboard=unnamedplus

"-------------------- Vim mappings -------------------------------------
" Leader key
let mapleader=" "
inoremap <C-c> <Esc>
nnoremap <C-c> <Esc>
nnoremap <M-CR> :let v:hlsearch=!v:hlsearch<CR>

" Indent selected code with < / >
vnoremap < <gv
vnoremap > >gv
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

"-------------------- Better navigation --------------------------------
nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
xnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>

nnoremap <silent> <S-k>      <Cmd>call VSCodeNotify('editor.action.showHover')<CR>
nnoremap <silent> <space> gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
nnoremap <silent> <space> gd <cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>
nnoremap <silent> <space> qf <cmd>call VSCodeNotify('editor.action.quickFix')<CR>
nnoremap <silent> <C-w>gd <Cmd>call VSCodeNotify('editor.action.revealDefinitionAside')<CR>

"-------------------- Buffers ------------------------------------------
" Close active buffer
nnoremap <silent> <space>bd :call VSCodeNotify('workbench.action.closeActiveEditor')<CR>

" Move buffers
nnoremap <silent> <space>h :call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
nnoremap <silent> <space>j :call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
nnoremap <silent> <space>k :call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
nnoremap <silent> <space>l :call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>

"Reopen closed buffer
nnoremap <silent> <space>bu :call VSCodeNotify('workbench.action.reopenClosedEditor')<CR>

" Navigation between buffers
nnoremap <silent> <TAB> :call VSCodeNotify('workbench.action.nextEditor')<CR>
nnoremap <silent> <S-TAB> :call VSCodeNotify('workbench.action.previousEditor')<CR>


"-------------------- Commentary ---------------------------------------
xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

"-------------------- General ------------------------------------------
nnoremap <silent> <space>. :call VSCodeNotify('workbench.action.openSettingsJson')<CR>
nnoremap <silent> <space>; :call VSCodeNotify('workbench.action.showCommands')<CR>
nnoremap <silent> <space>m :call VSCodeNotify('editor.action.toggleMinimap')<CR>
nnoremap <silent> <space>z :call VSCodeNotify('workbench.action.toggleZenMode')<CR>

"-------------------- Search -------------------------------------------
nnoremap <silent> <C-p> :call VSCodeNotify('workbench.action.quickOpen')<CR>
nnoremap <silent> <space>pb :call VSCodeNotify('workbench.action.showAllEditors')<CR>


"-------------------- Show ---------------------------------------------

" Show debug console
nnoremap <silent> <space>sd :call VSCodeNotify('workbench.debug.action.toggleRepl')<CR>

" Show file explorer
nnoremap <silent> <space>se :call VSCodeNotify('workbench.view.explorer')<CR>

" Show source control
nnoremap <silent> <space>sg :call VSCodeNotify('workbench.view.scm')<CR>

" Show output
nnoremap <silent> <space>so :call VSCodeNotify('workbench.action.output.toggleOutput')<CR>

" Show problem
nnoremap <silent> <space>sp :call VSCodeNotify('workbench.actions.view.problems')<CR>

" Show remote explorer
nnoremap <silent> <space>sr :call VSCodeNotify('workbench.view.remote')<CR>

" Show terminal
nnoremap <silent> <space>st :call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>

" Show extensions
nnoremap <silent> <space>sx :call VSCodeNotify('workbench.view.extensions')<CR>

"-------------------- Open ---------------------------------------------
nnoremap <silent> <space>od :call VSCodeNotify('workbench.action.files.openFolder')<CR>
nnoremap <silent> <space>of :call VSCodeNotify('workbench.action.files.openFile')<CR>
nnoremap <silent> <space>or :call VSCodeNotify('workbench.action.openRecent')<CR>

"-------------------- UI toggles ---------------------------------------
nnoremap <silent> <space>ua :call VSCodeNotify('workbench.action.toggleActivityBarVisibility')<CR>
nnoremap <silent> <space>uf :call VSCodeNotify('workbench.action.toggleFullScreen')<CR>
nnoremap <silent> <space>us :call VSCodeNotify('workbench.action.selectTheme')<CR>
