#!/bin/bash

# Author: DRUK
# pullJS: https://github.com/rvismit/pullJS
# twitter: https://www.twitter.com/rvismit
# Created May 2020 | Monastery 
# New updates coming soon.

echo            "             _ _     _ ____  "
echo            " _ __  _   _| | |   | / ___| "
echo            "| '_ \| | | | | |_  | \___ \ "
echo            "| |_) | |_| | | | |_| |___) | "
echo            "| .__/ \__,_|_|_|\___/|____/ "
echo            "|_|                          "

echo -en '\n'
echo  "Enter Your Domain Name:"  "E.g exapmle.com"
read vardomain
if
                host $vardomain
                then
                echo "Resolved"
curl http://web.archive.org/cdx/search/cdx?url=*.$vardomain/.*\&output=text\&fl=original\&collapse=urlkey | grep $vardomain".js" | sort -u >> output.txt
curl http://index.commoncrawl.org/CC-MAIN-2018-22-index?url=*.$vardomain/.*\&output=json | jq -r .url | grep ".js" |sort -u >> output.txt
for URL in `cat output.txt`; do echo $URL; curl -m 10 -s -I $1 "$URL" | grep HTTP/1.1 | awk {'print $2'}; done >> output.txt
else
                echo -e "Invalid Host"
fi 
