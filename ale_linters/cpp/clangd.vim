" Author: gagbo <gagbobada+git@gmail.com>
" Description: A language server for C/C++ by Clang

call ale#Set('cpp_clangd_executable', 'clangd')

function! ale_linters#cpp#clangd#GetExecutable(buffer) abort
    return ale#Var(a:buffer, 'cpp_clangd_executable')
endfunction

function! ale_linters#cpp#clangd#GetCommand(buffer) abort
    let l:executable = ale_linters#cpp#clangd#GetExecutable(a:buffer)

    " Try to find compilation database to link automatically
    let l:build_dir = ale#Var(a:buffer, 'c_build_dir')

    if empty(l:build_dir)
        let l:build_dir = ale#c#FindCompileCommands(a:buffer)
    endif

      return ale#Escape(l:executable)
      \   . (!empty(l:build_dir) ? ' -compile-comands-dir=' . ale#Escape(l:build_dir) : '')
endfunction

function! ale_linters#cpp#clangd#GetProjectRoot(buffer) abort
    return fnamemodify(ale#path#FindNearestDirectory(a:buffer, '.git'), ':h')
endfunction

call ale#linter#Define('cpp', {
\   'name': 'clangd',
\   'lsp': 'stdio',
\   'executable_callback': 'ale_linters#cpp#clangd#GetExecutable',
\   'command_callback': 'ale_linters#cpp#clangd#GetCommand',
\   'language': 'cpp',
\   'project_root_callback': 'ale_linters#cpp#clangd#GetProjectRoot',
\})
