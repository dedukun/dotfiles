"""""""""""""""""
" Vim Functions

function ToggleNumber()
    if &number ==# 1
        echo "Numbers Off"
        NumbersToggle
        NumbersDisable
    else
        echo "Numbers On"
        NumbersEnable
        set number
    endif
endfunction

function GoyoToggle()
    if &number ==# 1
        "change terminal's font size (only works in this st configuration)
        silent exec "!xdotool key alt+shift+k"
        silent exec "!xdotool key alt+shift+k"
        silent exec "!xdotool key alt+shift+k"
        NumbersDisable
        Goyo 85%
    else
        "change terminal's font size (only works in this st configuration)
        silent exec "!xdotool key alt+shift+j"
        silent exec "!xdotool key alt+shift+j"
        silent exec "!xdotool key alt+shift+j"
        NumbersEnable
        Goyo!
        set number
    endif
endfunction

function GenerateTags()
    if filereadable("generate-tags.sh")
        echo "Generating tags... "
        execute '!./generate-tags.sh'
    elseif filereadable("../generate-tags.sh")
        echo "Generating tags... "
        execute '!../generate-tags.sh'
    else
        echo "No tag generation script found!"
    endif
endfunction

function MultipleFileSearch(search)
    exec 'grep -s' a:search ' **/* --include={*.c,*.h,*.py,*.java}'
endfunction

function SyntasticToggle()
    if !exists("g:syntoggle")
        echo "Disable Synstastic"
        let g:syntoggle = "true"
        silent! SyntasticToggleMode
        SyntasticReset
    else
        echo "Enable Synstastic"
        unlet g:syntoggle
        silent! SyntasticToggleMode
        SyntasticCheck
    endif
endfunction

function RefreshBufferAndNERDTree()
    silent! checktime
    silent! NERDTreeRefreshRoot
endfunction

" args *
" argsdo
