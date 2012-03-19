"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Script: ColorV 
"    File: plugin/colorv.vim
" Summary: A vim plugin that makes handling colors easier
"  Author: Rykka10 <Rykka10(at)gmail.com>
" Last Update: 2012-03-19
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:save_cpo = &cpo
set cpo&vim

if v:version < 700
    finish
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -nargs=*  ColorV          call colorv#win("",<q-args>)
command! -nargs=*  ColorVMid       call colorv#win("mid",<q-args>)
command! -nargs=*  ColorVMin       call colorv#win("min",<q-args>)
command! -nargs=*  ColorVMax       call colorv#win("max",<q-args>)
command! -nargs=0  ColorVQuit      call colorv#exit()
command! -nargs=0  ColorVClear     call colorv#clear_all()

command! -nargs=0  ColorVView      call colorv#cursor_win()
command! -nargs=0  ColorVEdit       call colorv#cursor_win(1)
command! -nargs=0  ColorVEditAll    call colorv#cursor_win(2)
command! -nargs=1  ColorVEditTo     call colorv#cursor_win(1,<q-args>)

command! -nargs=0  ColorVName      call colorv#list_win()
command! -nargs=+  ColorVList      call colorv#cursor_win(3,<f-args>)

command! -nargs=0  ColorVAutoPreview  call colorv#prev_aug()
command! -nargs=0  ColorVPreview      call colorv#preview()
command! -nargs=0  ColorVPreviewHomo  call colorv#preview("bc")
command! -nargs=0  ColorVPreviewLine  call colorv#preview_line("c")

command! -nargs=0  ColorVDropper   call colorv#dropper()

if !exists('g:ColorV_no_global_map')
  let g:ColorV_no_global_map = 0
endif

if !exists('g:ColorV_global_leader')
  let g:ColorV_global_leader = '<Leader>c'
endif

function! colorv#define_global() "{{{
    if g:ColorV_no_global_map==1
        return
    endif
    let leader_maps=g:ColorV_global_leader
    let map_dicts=[
    \{'key': ['v'] ,       'cmd': ':ColorV<CR>'},
    \{'key': ['1','m'] ,   'cmd': ':ColorVMin<CR>'},
    \{'key': ['2'] ,       'cmd': ':ColorVMid<CR>'},
    \{'key': ['3','x'] ,   'cmd': ':ColorVMax<CR>'},
    \{'key': ['w' ],       'cmd': ':ColorVView<CR>'},
    \{'key': ['e' ],       'cmd': ':ColorVEdit<CR>'},
    \{'key': ['E' ],       'cmd': ':ColorVEditAll<CR>'},
    \{'key': ['d' ],       'cmd': ':ColorVDropper<CR>'},
    \{'key': ['n' ],       'cmd': ':ColorVName<CR>'},
    \{'key': ['q' ],       'cmd': ':ColorVQuit<CR>'},
    \{'key': ['pp'] ,      'cmd': ':ColorVPreview<CR>'},
    \{'key': ['pa'] ,      'cmd': ':ColorVAutoPreview<CR>'},
    \{'key': ['pl'] ,      'cmd': ':ColorVPreviewLine<CR>'},
    \{'key': ['pc'] ,      'cmd': ':ColorVClear<CR>'},
    \{'key': ['ph'] ,      'cmd': ':ColorVViewHomo<CR>'},
    \{'key': ['2x'] ,      'cmd': ':ColorVEditTo HEX<CR>'},
    \{'key': ['2h'] ,      'cmd': ':ColorVEditTo HSV<CR>'},
    \{'key': ['2n'] ,      'cmd': ':ColorVEditTo NAME<CR>'},
    \{'key': ['2r'] ,      'cmd': ':ColorVEditTo RGB<CR>'},
    \{'key': ['2m'] ,      'cmd': ':ColorVEditTo CMYK<CR>'},
    \{'key': ['2p'] ,      'cmd': ':ColorVEditTo RGBP<CR>'},
    \{'key': ['2l'] ,      'cmd': ':ColorVEditTo HSL<CR>'},
    \{'key': ['2s','2#'] , 'cmd': ':ColorVEditTo NS6<CR>'},
    \{'key': ['2l' ],      'cmd': ':ColorVEditTo HSL<CR>'},
    \{'key': ['l1', 'lh'] ,'cmd': ':ColorVList Hue 20 15<CR>'},
    \{'key': ['ls'] ,      'cmd': ':ColorVList Saturation 20 15<CR>'},
    \{'key': ['lv'] ,      'cmd': ':ColorVList Value 20 5 1<CR>'},
    \{'key': ['la'] ,      'cmd': ':ColorVList Analogous<CR>'},
    \{'key': ['lq'] ,      'cmd': ':ColorVList Square<CR>'},
    \{'key': ['ln'] ,      'cmd': ':ColorVList Neutral<CR>'},
    \{'key': ['lc'] ,      'cmd': ':ColorVList Clash<CR>'},
    \{'key': ['lp'] ,      'cmd': ':ColorVList Split-Complementary<CR>'},
    \{'key': ['lm'] ,      'cmd': ':ColorVList Monochromatic<CR>'},
    \{'key': ['l2'] ,      'cmd': ':ColorVList Complementary<CR>'},
    \{'key': ['l3'] ,      'cmd': ':ColorVList Triadic<CR>'},
    \{'key': ['l4'] ,      'cmd': ':ColorVList Tetradic<CR>'},
    \{'key': ['l5'] ,      'cmd': ':ColorVList Five-Tone<CR>'},
    \{'key': ['l6'] ,      'cmd': ':ColorVList Six-Tone<CR>'},
    \]
    for i in map_dicts
        if !hasmapto(i.cmd, 'n')
        for k in i['key']
            silent! exe 'nmap <unique> <silent> '.leader_maps.k.' '.i['cmd'] 
        endfor
        endif
    endfor
endfunction "}}}

call colorv#define_global()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let &cpo = s:save_cpo
unlet s:save_cpo
