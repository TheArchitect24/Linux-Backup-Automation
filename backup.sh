#!/bin/bash

# ------------------------------------------------------
# backup.sh
# Author: Onyinyechukwu Kenneth Nebe
# Description:
#   A Linux automation script that backs up encrypted 
#   password files (or any target files) updated within 
#   the past 24 hours. 
#
# Features:
#   - Validates input arguments
#   - Checks that directories exist
#   - Identifies modified files
#   - Archives and compresses files with a timestamp
#   - Moves backup to destination directory
#   - Logs activity for audit trail
# ------------------------------------------------------

# --------------------------
# Step 1: Validate arguments
# --------------------------
if [[ $# != 2 ]]
then
  echo "Usage: backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

# --------------------------
# Step 2: Set variables
# --------------------------
targetDirectory=$1                                         # Directory to back up
destinationDirectory=$2                                    # Destination backup folder 
currentTS=`date +%s`                                       # Current timestamp in seconds

# Confirm the target and destination directories and print them out
echo "Target Directory: $targetDirectory"
echo "Destination Directory: $destinationDirectory"

# This variable stores the name of the archived and compressed backup file that the script will create.
backupFileName="backup-[$currentTS].tar.gz"

origAbsPath=`pwd`

# Absolute path of destination directory
cd $destinationDirectory
destDirAbsPath=`pwd`

cd $origAbsPath
cd $targetDirectory

yesterdayTS=$(($currentTS - 24*60*60))

#Declare an array backup
declare -a toBackup

# --------------------------
# Step 3: Find modified files
# --------------------------
# Loop over all files/dirs in target directory

#In the for loop, use the wildcard to iterate over all files and directories in the current folder.
for file in *
do
  if [[ `date -r $file +%s` -gt $yesterdayTS ]]
  then
    toBackup+=($file)
  fi
done

# --------------------------
# Step 4: Create backup archive
# --------------------------
if [[ ${#toBackup[@]} -eq 0 ]]
then
    echo "No files modified in the last 24 hours. Nothing to back up."
    exit 0
fi

# Compress and archive the files
tar -czvf $backupFileName ${toBackup[@]}
echo "Backup file created: $backupFileName"

# --------------------------
# Step 5: Move backup to destination
# --------------------------
mv "$backupFileName" "$destDirAbsPath"
echo "Backup moved to: $destDirAbsPath/$backupFileName"


# --------------------------
# Bonus Step 6: Logging
# --------------------------
logFile="backup.log"

{
  echo "------------------------------------"
  echo "Backup Date: $(date)"
  echo "Target Directory: $targetDirectory"
  echo "Destination Directory: $destAbsPath"
  echo "Backup File: $backupFileName"
  echo "Files Backed Up: ${toBackup[*]}"
  echo "------------------------------------"
} >> $logFile

mv "$logFile" "$destDirAbsPath"
