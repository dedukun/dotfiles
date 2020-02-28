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

""""""""""""""""""""""""""""""""""""""""""""""""""
""""""" N E R D T R E E   F U N C T I O N S """"""
""""""""""""""""""""""""""""""""""""""""""""""""""

function ToggleNERDTree()
  let nerdtree_buffer = GetNERDTreeActiveBuffers()
  if len(nerdtree_buffer) == 0
    NERDTreeFocus
    call ResizeNERDTree()
  else
    NERDTreeClose
  endif
endfunction

function RefreshBufferAndNERDTree()
    silent! checktime
    silent! NERDTreeRefreshRoot
endfunction

function GetNERDTreeActiveBuffers()
  let buffers = filter(range(1, bufnr('$')), 'bufexists(v:val)')
  let buffers_active = filter(buffers, 'bufwinid(v:val) > -1')
  let buffer_filter = "NERD_Tree_"
  let nerdtree_buffer = filter(buffers_active, 'match(bufname(v:val), buffer_filter) > -1')
  return nerdtree_buffer
endfunction

function ResizeNERDTree()
  let nerdtree_buffer = GetNERDTreeActiveBuffers()
  if len(nerdtree_buffer) == 0
    echo "No buffer was detected to belong to NerdTree"
  elseif len(nerdtree_buffer) > 1
    echo "ERROR: ". len(nerdtree_buffer) ." buffers were detected to belong to NerdTree"
  else
    let lines = getbufline(nerdtree_buffer[0], 5, "$")
    let max_file_len = 0
    let tmp_len=-1
    for line in lines
      let tmp_len=strlen(line)
      if max_file_len < tmp_len
        let max_file_len = tmp_len
      endif
    endfor

    " Set new size and refresh NERDTree
    let g:NERDTreeWinSize=max_file_len
    NERDTreeFocus
  endif
endfunction

