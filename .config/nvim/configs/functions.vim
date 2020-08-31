"""""""""""""""""
" Vim Functions

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

function CreateSectionHeader(comment)
  let header_size = 45
  let minimun_border_size = 6
  let border_character = '#'
  let inside_character = '#'

  let final_comment_size = strlen(a:comment) * 2 + 1

  if final_comment_size > (header_size - minimun_border_size)
    let header_size = final_comment_size + minimun_border_size

    echo "Header Size was extended to " . header_size
  endif

  let print_str = '/*' . repeat("#", header_size) . '*'
  call append(line('.')-1, print_str)

  let end_filler_counter = ((header_size - final_comment_size) / 2)
  " left border
  let print_str= ' *' . border_character .repeat(inside_character, end_filler_counter-1)
  " comment
  let print_str = print_str . ' ' . join(split(toupper(a:comment), '\zs'), ' ')
  " right border
  let print_str = print_str . ' ' . repeat(inside_character, end_filler_counter-1) . border_character . "*"
  call append(line('.')-1, print_str)

  let print_str = ' *' . repeat("#", header_size) . '*/'
  call append(line('.')-1, print_str)
endfunction

"""""""""""""""""
" Coc

function! COC_Check_Back_Space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! COC_Show_Documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
