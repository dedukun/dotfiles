#!/bin/sh
# This is a script to manage a todo list, with taskwarrior, between projects using a cli or dmenu/rofi
# [WIP]

todo_project="general"

print_help () {
    echo "TODO list."
    echo "Calling it with no arguments will start the default todo list."
    printf "\t -l, --list      List the pending tasks of the project\n"
    printf "\t -p, --project      Specify the project to use\n"
    printf "\t -h, --help         Prints this help menu\n"
}

list_tasks() {
    height=$(task "project:$todo_project" count)
}

while [ $# -gt 0 ]
do
    todo_key="$1"

    case $todo_key in
        -l|--list)
            list_tasks
            shift # past argument
            exit
        -p|--project)
            todo_project="$2"
            shift # past argument
            shift # past value
            ;;
        -h|--help)
            shift # past argument
            print_help
            exit 0
            ;;
        *)
            echo "Invalid argument '$1'."
            echo "For more help use argument -h or --help."
            shift # past argument
            exit 1
            ;;
    esac
done
