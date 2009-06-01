"=============================================================================
" FILE: history.vim
" AUTHOR: Shougo Matsushita <Shougo.Matsu@gmail.com>(Modified)
" Last Modified: 31 Jan 2009
" Usage: Just source this file.
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
" Version: 1.1, for Vim 7.0
"-----------------------------------------------------------------------------
" ChangeLog: "{{{
"   1.1:
"     - Supported vimshell Ver.3.2.
"   1.0:
"     - Initial version.
""}}}
"-----------------------------------------------------------------------------
" TODO: "{{{
"     - Nothing.
""}}}
" Bugs"{{{
"     -
""}}}
"=============================================================================

function! vimshell#internal#history#execute(program, args, fd, other_info)
    if get(g:vimshell#hist_buffer, 0) =~ '^history'
        " Delete from history.
        call remove(g:vimshell#hist_buffer, 0)
    endif

    let l:cnt = 0
    let l:arguments = join(a:args, ' ')
    if l:arguments =~ '^\d\+$'
        let l:max = str2nr(l:arguments)
    elseif empty(l:arguments)
        " Default max value.
        let l:max = 20
    else
        let l:max = len(g:vimshell#hist_buffer)
    endif
    if l:max >= len(g:vimshell#hist_buffer)
        " Overflow.
        let l:max = len(g:vimshell#hist_buffer)
    endif
    while l:cnt < l:max
        call vimshell#print_line(printf('%3d: %s', l:cnt, g:vimshell#hist_buffer[l:cnt]))
        let l:cnt += 1
    endwhile
endfunction