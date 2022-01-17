#!/bin/bash

nc="\033[0m"
red="\033[0;31m"
green="\033[0;32m"

# file paths relative to the project root
template_files=(
    "setup.cfg.tmpl"
)

# placeholder in format placeholder:description
placeholders=(
    "PROJECT_NAME:Project name"
    "PROJECT_DESCRIPTION:Project description"
)

user_values=()

for placeholder in "${placeholders[@]}" ; do
    placeholder_name="${placeholder%%:*}"
    description="${placeholder##*:}"
    printf "$description: "
    read value
    user_values+=("$value")
done

for template_file in "${template_files[@]}" ; do
    current_path=`dirname "$0"`
    source_path="$current_path/../$template_file"

    if [ -f $source_path ] ;
    then
        dest_path="${source_path/\.tmpl/}"
        result=`cat $source_path`

        for idx in "${!user_values[@]}" ; do
            placeholder=${placeholders[idx]}
            placeholder_name="${placeholder%%:*}"
            result=`echo "$result" | sed "s/{{$placeholder_name}}/${user_values[idx]}/g"`
        done

        echo "$result" > "$dest_path"
        printf "${green}Processed and created ${nc}$dest_path\n"
        rm "$source_path"
    else
        printf "${red}File not found ${nc}$source_path\n"
    fi
done
