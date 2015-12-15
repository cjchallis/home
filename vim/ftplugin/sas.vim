" don't wrap lines - makes partial windows more helpful
set nowrap
" run code from active window and open log and output files
map <F3> :w<CR>:only<CR>:!sas %<CR>:vs %<.log<CR>:vs %<.lst<CR>

" for current filename, set windows to code, log, and output
map <F4> :e %<.sas<CR>:only<CR>:vs %<.log<CR>:vs %<.lst<CR>

" close all but the current window
map <F8> :vertical resize 170<CR>

" open a new window or switch to existing open window
map <F5> :set nowfw<CR>:let name = expand('%<')<CR>:vert sbuffer <C-R>=name<CR>.sas<CR> :set wfw<CR>:vertical resize 110<CR>:call NormalizeWidths()<CR>
map <F6> :set nowfw<CR>:let name = expand('%<')<CR>:vert sbuffer <C-R>=name<CR>.log<CR> :set wfw<CR>:vertical resize 110<CR>:call NormalizeWidths()<CR>
map <F7> :set nowfw<CR>:let name = expand('%<')<CR>:vert sbuffer <C-R>=name<CR>.lst<CR> :set wfw<CR>:vertical resize 110<CR>:call NormalizeWidths()<CR>

" run only current selection
map <F9> :'<,'>w! ~/sas/temp.sas<CR>:only<CR>:!sas ~/sas/temp.sas -log '%<.log' -print '%<.lst' -autoexec ~/sas/autoexec.sas<CR>:vs %<.log<CR>:vs %<.lst<CR>

" change the autoexec to the selected code
" useful for setting libraries and macro variables
map <F1> :'<,'>w! ~/sas/autoexec.sas<CR>

" the following map Shift-F5, -F6, and -F7, respectively, to view only the
" corresponding file
noremap [28~ :e %<.sas<CR>:only<CR>
noremap [29~ :e %<.log<CR>:only<CR>
noremap [31~ :e %<.lst<CR>:only<CR>

" switch windows with Ctrl-i,j,k,l
" for right and left switching, make the selected window large
nnoremap <C-J> :set nowfw<CR> <C-W><Left> :set wfw<CR>:vertical resize 110<CR>:call NormalizeWidths()<CR>
nnoremap <C-I> <C-W><Up>
nnoremap <C-L> :set nowfw<CR> <C-W><Right> :set wfw<CR>:vertical resize 110<CR>:call NormalizeWidths()<CR>
nnoremap <C-K> <C-W><Down>

" comment out selected code
vnoremap q c<CR><CR>*/<Up>/*<CR><ESC>p

" command  and function for look at contents of datasets
vnoremap <Leader>p y :call ProcPrint("<C-R>0")<CR>

fun! ProcPrint(dataset)
    silent !echo "proc print data=" > ~/sas/print.sas
    execute "silent !echo ".a:dataset." >> ~/sas/print.sas" 
    silent ! echo "; run;" >> ~/sas/print.sas
    silent ! sas ~/sas/print.sas -autoexec ~/sas/autoexec.sas
    vs print.lst
    redraw!
endf

" generate rebin SAS code from Python script
nnoremap <Leader>r :!python gen_sas_rebin.py '%' rebin.txt<CR>:vs rebin.txt<CR>

" functions for toggling and managing file browser
fun! VexToggle(dir)
    if exists("t:vex_buf_nr")
        call VexClose()
    else
        call VexOpen(a:dir)
    endif
endf

fun! VexOpen(dir)
    let g:netrw_browse_split=4
    let vex_width = 25

    execute "Vexplore " . a:dir
    let t:vex_buf_nr = bufnr("%")
    wincmd H

    call VexSize(vex_width)
endf

fun! VexClose()
    let cur_win_nr = winnr()
    let target_nr = ( cur_win_nr == 1 ? winnr("#") : cur_win_nr )

    1wincmd w
    close
    unlet t:vex_buf_nr

    execute (target_nr - 1) . "wincmd w"
    call NormalizeWidths()
endf

fun! VexSize(vex_width)
    execute "vertical resize" . a:vex_width
    set winfixwidth
    call NormalizeWidths()
endf

fun! NormalizeWidths()
    let eadir_pref = &eadirection
    set eadirection=hor
    set equalalways! equalalways!
    let &eadirection = eadir_pref
endf

augroup NetrwGroup
    autocmd! BufEnter * call NormalizeWidths()
augroup END

noremap <Leader><Tab> :call VexToggle(getcwd())<CR>

" specific commands for common files
nnoremap <Leader>m :vs /opt/apps/sas/MKT_data/shared_data/datascience/macrolib/modeling_macro_library_v03.sas<CR>
