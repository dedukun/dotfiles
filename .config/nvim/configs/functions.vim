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

function CreateSectionHeader(comment)
  let filler_str = ''

  let c = 1
  let header_size = 45

  let final_comment_size = strlen(a:comment) * 2 + 1

  if final_comment_size > header_size
    let header_size = final_comment_size + 6

    echo "Header Size was extended to " . header_size
  endif

  while c <= header_size
    let filler_str = filler_str . "#"
    let c += 1
  endwhile

  let print_str = '/*' . filler_str . '*'
  call append(line('.')-1, print_str)

  let print_str = ' *'
  let c = 1
  let sc = 0
  let end_filler_counter = (header_size - final_comment_size) / 2
  while c <= header_size
    if c <= end_filler_counter
      let print_str = print_str . '#'
    elseif c > (end_filler_counter + final_comment_size)
      let print_str = print_str . '#'
    elseif c % 2
      let print_str = print_str . toupper(strpart(a:comment,sc,1))
      let sc = sc + 1
    else
      let print_str = print_str . ' '
    endif
    let c += 1
  endwhile
  let print_str = print_str . '*'

  call append(line('.')-1, print_str)

  let print_str = ' *' . filler_str . '*/'
  call append(line('.')-1, print_str)
endfunction
