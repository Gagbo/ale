" Author: gagbo <gagbobada+git@gmail.com>
" Description: A language server for C/C++

call ale#Set('cpp_clangd_executable', 'cquery')

function! ale_linters#cpp#cquery#GetExecutable(buffer) abort
    return ale#Var(a:buffer, 'cpp_cquery_executable')
endfunction

function! ale_linters#cpp#cquery#GetCommand(buffer) abort
    let l:executable = ale_linters#cpp#cquery#GetExecutable(a:buffer)

      return ale#Escape(l:executable)
    \ . ' --log-file=/tmp/cq.log --init=''{"cacheDirectory": "/tmp/cquery", "emitQueryDbBlocked": true}'''
endfunction

function! ale_linters#cpp#cquery#GetProjectRoot(buffer) abort
    return fnamemodify(ale#path#FindNearestFile(a:buffer, 'compile_commands.json'), ':h')
endfunction

call ale#linter#Define('cpp', {
\   'name': 'cquery',
\   'lsp': 'stdio',
\   'executable_callback': 'ale_linters#cpp#cquery#GetExecutable',
\   'command_callback': 'ale_linters#cpp#cquery#GetCommand',
\   'language': 'cpp',
\   'project_root_callback': 'ale_linters#cpp#cquery#GetProjectRoot',
\   'project_callback': 'ale_linters#cpp#cquery#GetProjectRoot',
\})
