"=============================================================================
" FILE: ls.vim
" AUTHOR: Shougo Matsushita <Shougo.Matsu@gmail.com>
" Last Modified: 31 Jan 2012.
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

let s:command = {
      \ 'name' : 'ls',
      \ 'kind' : 'internal',
      \ 'description' : 'ls [{argument}...]',
      \}
function! s:command.execute(args, context)"{{{
  " Check ls command.
  if !executable('ls')
    call vimshell#error_line(a:context.fd, 'ls: external command ls is not installed.')
    return 1
  endif

  let arguments = a:args

  if a:context.fd.stdout == ''
    call insert(arguments, '-FC')
  endif

  if vimshell#util#is_win()
    call insert(arguments, 'ls.exe')
  else
    call insert(arguments, 'ls')
  endif

  call vimshell#execute_internal_command('exe', arguments, a:context)
endfunction"}}}

function! vimshell#commands#ls#define()
  return s:command
endfunction
