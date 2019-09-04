#!/bin/sh
print_help () {
    printf "Remove White Spaces.\n\n"
    printf "Removes trailing white spaces, i.e., white spaces at the end of lines in the given files.\n"
    printf "It ignores hidden files and directories.\n\n"
    printf "Usage: %s [PARAMS] <pattern>\n\n" "$0"
    printf "\033[33mWARINNIG: THIS SCRIPT CAN BE DESTRUCTIVE IN FILES SUCH AS IMAGES,\n"
    printf "BINARY FILES, ETC. IT WILL CORRUPT THEM IF RUNNING RECURSIVELY CARELESSLY.\033[0m\n\n"
    printf "Option:\n"
    printf "\t-r, --recursive  Recursive\n"
    printf "\t-h, --help       Prints this help menu\n"
}

rws_recursive="-maxdepth 1"
while [ $# -gt 0 ]
do
    rws_key="$1"

    case $rws_key in
        -r|--recursive)
            unset rws_recursive
            shift # past argument
            ;;
        -h|--help)
            print_help
            shift # past argument
            exit 0
            ;;
        -*)
            echo "Invalid argument '$1'."
            echo "For more information use argument -h or --help".
            shift # past argument
            exit 1
            ;;
        *)
            if [ "$rws_argument" = "" ]; then
                rws_argument="$1"
            else
                echo "Invalid argument '$1', only 1 value is accepted."
                echo "For more information use argument -h or --help".
                exit 1
            fi
            shift # past argument
            ;;
    esac
done

if [ "$rws_argument" = "" ]; then
    find . $rws_recursive -not -path "*/\.*" -type f -exec echo {} \; -exec sed -i 's/\s\+$//g' {} +
else
    find . $rws_recursive -not -path "*/\.*" -type f -name "$rws_argument" -exec echo {} \; -exec sed -i 's/\s\+$//g' {} +
fi
