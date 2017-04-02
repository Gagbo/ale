" Author: Gerry Agbobada <https://github.com/gagbo>
" Description: clang_check linter for cpp files

" clang_check may be preferred to clang since ClangTools can work
" with compilation databases

" Set this option to change the Clang options for warnings for CPP.
if !exists('g:ale_cpp_clang_check_options')
    let g:ale_cpp_clang_check_options = "-p build"
endif

function! ale_linters#cpp#clang_check#GetCommand(buffer) abort
    return 'clang-check -analyze %s ' .
    \ g:ale_cpp_clang_check_options
endfunction

call ale#linter#Define('cpp', {
\   'name': 'clang_check',
\   'output_stream': 'stderr',
\   'executable': 'clang-check',
\   'command_callback': 'ale_linters#cpp#clang_check#GetCommand',
\   'callback': 'ale#handlers#HandleGCCFormat',
\})
