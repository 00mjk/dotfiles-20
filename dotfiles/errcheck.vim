" Adapted from
" - linter definition for staticcheck
" - ale#handlers#go#Handler function

call ale#Set('go_errcheck_executable', 'errcheck')
call ale#Set('go_errcheck_options', '')
call ale#Set('go_errcheck_lint_package', 1)
call ale#Set('go_errcheck_use_global', get(g:, 'ale_use_global_executables', 0))

function! ale_linters#go#errcheck#GetCommand(buffer) abort
    let l:options = ale#Var(a:buffer, 'go_errcheck_options')
    let l:lint_package = ale#Var(a:buffer, 'go_errcheck_lint_package')
    let l:env = ale#go#EnvString(a:buffer)

    if l:lint_package
        return l:env . '%e'
        \   . (!empty(l:options) ? ' ' . l:options : '') . ' .'
    endif

    return l:env . '%e'
    \   . (!empty(l:options) ? ' ' . l:options : '')
    \   . ' %s:t'
endfunction

function! ale_linters#go#errcheck#Handler(buffer, lines) abort
    let l:pattern = '\v^%(vet: )?([a-zA-Z]?:?[^:]+):(\d+):?(\d+)?:? ?(.+)$'
    let l:output = []
    let l:dir = expand('#' . a:buffer . ':p:h')

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        call add(l:output, {
        \   'filename': ale#path#GetAbsPath(l:dir, l:match[1]),
        \   'lnum': l:match[2] + 0,
        \   'col': l:match[3] + 0,
        \   'text': 'errcheck: unhandled error or assertion',
        \   'type': 'W',
        \})
    endfor

    return l:output
endfunction

call ale#linter#Define('go', {
\   'name': 'errcheck',
\   'executable': {b -> ale#path#FindExecutable(b, 'go_errcheck', [
\       ale#go#GetGoPathExecutable('bin/errcheck'),
\   ])},
\   'cwd': '%s:h',
\   'command': function('ale_linters#go#errcheck#GetCommand'),
\   'callback': 'ale_linters#go#errcheck#Handler',
\   'output_stream': 'both',
\   'lint_file': 1,
\})
