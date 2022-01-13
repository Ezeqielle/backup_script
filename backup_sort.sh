#!/bin/bash

# Nom			: backup_sort.sh
# Description	: complementaire de backup_script.sh
#
# Auteur		: Mathis DI MASCIO
# Email			: mathis.dimascio@gmail.com
#
# Version		: 1.0

tar czf /BACKUP/LINUX/backup_$(date +%Y%m%d_%H%M%S).tar.gz /BACKUP/ARCHIVE/LINUX/
tar czf /BACKUP/WIN10/backup_$(date +%Y%m%d_%H%M%S).tar.gz /BACKUP/ARCHIVE/WIN10/
tar czf /BACKUP/SERVER/backup_$(date +%Y%m%d_%H%M%S).tar.gz /BACKUP/ARCHIVE/SERVER/