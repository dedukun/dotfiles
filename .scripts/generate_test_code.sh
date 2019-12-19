#!/bin/sh

print_help() {
    printf "Optional arguments for custom use:\\n"
    printf "  -r: Dotfiles repository (local file or url)\\n"
    printf "  -p: Dependencies and programs csv (local file or url)\\n"
    printf "  -a: AUR helper (must have pacman-like syntax)\\n"
    printf "  -h: Show this message\\n"
}

while getopts ":a:r:b:p:h" o; do case "${o}" in
	h) print_help && exit ;;
	r) dotfilesrepo=${OPTARG} && git ls-remote "$dotfilesrepo" || exit ;;
	b) repobranch=${OPTARG} ;;
	p) progsfile=${OPTARG} ;;
	a) aurhelper=${OPTARG} ;;
	*) printf "Invalid option: -%s\\n" "$OPTARG" && exit ;;
esac done
