"=============================================================================
" FILE: autoload/unite/sources/ghq.vim
" AUTHOR: haya14busa
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================
scriptencoding utf-8
" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}

let s:source = {
            \ 'name' : 'ghq',
            \ 'description' : 'Jump to local repositories under ghq management',
            \ 'type' : 'directory',
            \ }
" NOTE:

function! unite#sources#ghq#define()
    return executable('ghq') ? s:source : {}
endfunction

function! s:source.gather_candidates(args, context)
    let repos = split(unite#util#system('ghq list --full-path'), "\n")
    let candidates = []

    for repo in repos
        call add(candidates, {
        \   'word' : repo,
        \   'kind' : 'directory',
        \   "action__directory": repo
        \ })
    endfor
    return candidates
endfunction

" Helper
function! s:error_msg(msg)
    echohl ErrorMsg
    echomsg 'unite-ghq: ' . a:msg
    echohl None
endfunction


" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
unlet s:save_cpo
" }}}
" __END__  {{{
" vim: expandtab softtabstop=4 shiftwidth=4
" vim: foldmethod=marker
" }}}
