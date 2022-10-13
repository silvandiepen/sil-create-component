#!/bin/bash

black=`tput setaf 0`
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`
reset=`tput sgr0`
bold=`tput bold`
dim=`tput dim`

function question {
    printf "\n"
    if [[ ! -z "$2" ]]; then
        if [[ ! -z "$3" ]]; then
            printf "\t${bold}${1}${reset} ${yellow}\n\t${2}${reset} \t${blue}($3)${reset}\n"
        else 
            printf "\t${bold}${1}${reset} ${blue}($2)${reset} \n"
        fi
    else 
        printf "\t${bold}${1}${reset} \n"
    fi 
}


# // Reset
declare COMPONENT_NAME=$1


if [ -z $COMPONENT_NAME ]; then
    question "What is your Components Name?" "PascalCase"
    read -p " " COMPONENT_NAME
 fi

if [ -z $COMPONENT_NAME ]; then
    echo "Without a component name, I can't do anything for you."
    exit 0
fi

declare FILE_NAME=$COMPONENT_NAME


while [[ "$FILE_NAME" =~ (.*[a-z0-9])([A-Z].*) ]] && FILE_NAME="${BASH_REMATCH[1]}-${BASH_REMATCH[2]}"; do
  :  # do nothing
done

function toLowerCase {
    echo $@ | tr "[:upper:]" "[:lower:]"
}

question "Do you want to create ${COMPONENT_NAME} in" "${PWD}" "Y/n" 
read -p " " DEST_QUESTION
DEST_ANSWER="${DEST_QUESTION:-"Y"}"
DEST=$PWD

if [ $DEST_ANSWER = "n" ] || [ $DEST_ANSWER = "N" ]; then
    question "Where do you want it?"
    read -p " " DEST_PATH_QUESTION
    DEST=$DEST_PATH_QUESTION
fi 


[ -d $DEST/$COMPONENT_NAME ] && echo "\t${red}Directory ${bold}$DEST/$COMPONENT_NAME${reset} ${red}exists already${reset}.\n" && exit 0

if [ ! -d $DEST/$COMPONENT_NAME ]; then
    mkdir -p "$DEST/$COMPONENT_NAME"
fi

ALT_FILE_NAME=""

function createFile {

    HOST="https://create-component.sil.mt"
    TEMPLATE_FILE="assets/files/$1.${2}"
    HOSTED_FILE="${HOST}/${TEMPLATE_FILE}"

    DESTINATION_FILE=""

    if [ $ALT_FILE_NAME ]; then        
        DESTINATION_FILE="${DEST}/$COMPONENT_NAME/${ALT_FILE_NAME}.${2}"
    else        
        if [ "${1}" == "component" ];
            DESTINATION_FILE="${DEST}/$COMPONENT_NAME/${COMPONENT_NAME}.${2}"
        else
            DESTINATION_FILE="${DEST}/$COMPONENT_NAME/${COMPONENT_NAME}.${1}.${2}"  
        fi    
    fi 



    if [ ! -d $TEMPLATE_FILE ]; then
        curl --silent $HOSTED_FILE -o $DESTINATION_FILE
    else
        cp $TEMPLATE_FILE $DESTINATION_FILE
    fi


    perl -pi -e "s/COMPONENT_NAME/${COMPONENT_NAME}/g" $DESTINATION_FILE
    perl -pi -e "s/FILE_NAME/$(toLowerCase $FILE_NAME)/g" $DESTINATION_FILE
    printf "\t${green}${bold}✓${reset} created file ${bold}${DESTINATION_FILE}${reset}\n"

}

createFile component vue
createFile script ts
createFile style scss
createFile template html

ALT_FILE_NAME="index"

createFile index ts    
printf "\n"
