#!/bin/bash

# Nom			: backup_script.sh
# Description	: Script de backup
#
# Auteur		: Mathis DI MASCIO
# Email			: mathis.dimascio@gmail.com
#
# Version		: 1.0

# item in list split by space
readonly DIR_LIST='<your directory list to save (can be multiple folder)>'
readonly DIR_SAVE='<where you want to save your backup (can be multiple folder)>'
readonly EXCLUDE_LIST='<element you want to exclude (can be multiple)>'

usage() {
    if [ "${1}" == "help" ];
    then
        local dir_number=0
        echo 'Usage: backupSys <action> [dir_number] [init]'
        echo '      Actions:'
        echo '              - save: Sauvegarde les repertoires de DIR_LIST dans DIR_SAVE[dir_number]'
        echo '                      [dir_number] est un nombre entre 1 et 3'
        for dir in ${DIR_SAVE[@]}; do
            echo "              - ${dir_number}: ${dir}"
            done
            exit 0
        done
    fi  
}

# sauvegarde des repertoires de DIR_LIST dans DIR_SAVE[dir_number]
# ${1}: numero du repertoire a utiliser
# ${2}: initialisation du fichier error.log
save() {
    if [ -z ${1} ] || [ -z ${DIR_SAVE[${1}]} ];
    then
        echo 'Dossier ${1} inexistant'
        exit 1
    fi
    if [ ! -z ${2} ];
    then
        mv ${ERROR_LOG} ${ERROR_SAVE}
    fi
    local exclude=""
    while read -r directory || [[ -n "${directory}"]]; do
        exclude="--exclude=${directory} ${exclude}"
    done < "${EXCLUDE_LIST}"
    while read -r directory || [[ -n "${directory}" ]];do
        rsync -aH --delete --progress --force --stats ${exclude} ${DIR_LIST} ${DIR_SAVE[${1}]} 2>> ${ERROR_LOG} | logger -p local0.notice
    done < ${DIR_LIST} | tar -czvf ${DIR_SAVE[${1}]}/backup_$(date +%Y%m%d_%H%M%S).tar.gz -C /
}

if [ "${1}" == "save" ];
then
    save ${2}
else
    usage 'help'
fi