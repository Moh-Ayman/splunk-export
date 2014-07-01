#!/bin/bash
# Splunk Export script that will use the Splunk API to perform and export searches.
# Created By: Jeremy Davis
# Version: 1.0.0

## Obtain the username, password, and search query and assign it to variables.
clear
echo "Enter LDAP Username:"
read USERNAME
clear
echo "Enter Password:"
read -s PASSWD
clear
echo "Enter Splunk Search Query:"
echo "NOTE: Make sure you limit the search as this will pull all logs and could take some time."
read QUERY
clear
echo "Enter Export Filename:"
echo "NOTE: This filename will be used to store the exported logs from Splunk. Output will be in csv format. This file will be created in /tmp/"
read FILENAME
clear

## Display what we are about to do.
echo "Your username: $USERNAME"
echo "Your Query: $QUERY"
echo "Performing Splunk Search. Please wait..."

## Schedule the search and obtain the run ID in order to pull data.
RUNID=`curl -u $USERNAME:$PASSWD -d search="$QUERY" -k https://splunk.sendgrid.net:8089/servicesNS/admin/search/search/jobs -s | xml_grep 'sid' --text_only`

echo $RUNID

## If everything finished let the user know and exit clean.
echo "Finished!! Please open $FILENAME to view the exported data."
exit 0
