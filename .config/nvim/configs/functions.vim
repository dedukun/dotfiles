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
