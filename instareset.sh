#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
ORANGE='\033[0;33m'
PURPLE='\033[1;35m'
NC='\033[0m'

CSRF=`pwgen 33 1`
username=$1
curl=`curl -s 'https://www.instagram.com/accounts/account_recovery_send_ajax/' -H 'Host: www.instagram.com' -H 'User-Agent: Mozilla/1.22 (compatible; MSIE 2.0; Windows 3.1)' -H 'Accept: */*' -H 'Accept-Language: de,de-DE;q=0.5' --compressed -H 'Referer: https://www.instagram.com/accounts/password/reset/' -H 'X-CSRFToken: '${CSRF} -H 'Content-Type: application/x-www-form-urlencoded' -H 'X-Requested-With: XMLHttpRequest' -H 'Cookie: csrftoken='${CSRF} -H 'Connection: keep-alive' --data 'email_or_username='${username}`
curlout=`echo "${curl}" > test.out && cat test.out | awk -F "gehe zu " {'print $2'} | awk -F " und" {'print $1'} > test.out2 && cat test.out2`
UsID=`curl -s -L https://www.instagram.com/${username} | awk -F "profilePage_" {'print $2'} | cut -d'"' -f1 | tr -d '\n'`
isUsID=`cat uid.txt | grep ${UsID}`

rm test.out*

clear
echo -e ${BLUE}' ______                        __                _______                                   __     '${NC}
echo -e ${PURPLE}'/      |                      /  |              /       \                                 /  |    '${NC}
echo -e ${PURPLE}'$$$$$$/  _______    _______  _$$ |_     ______  $$$$$$$  |  ______    _______   ______   _$$ |_   '${NC}
echo -e ${RED}'  $$ |  /       \  /       |/ $$   |   /      \ $$ |__$$ | /      \  /       | /      \ / $$   |  '${NC}
echo -e ${RED}'  $$ |  $$$$$$$  |/$$$$$$$/ $$$$$$/    $$$$$$  |$$    $$< /$$$$$$  |/$$$$$$$/ /$$$$$$  |$$$$$$/   '${NC}
echo -e ${ORANGE}'  $$ |  $$ |  $$ |$$      \   $$ | __  /    $$ |$$$$$$$  |$$    $$ |$$      \ $$    $$ |  $$ | __ '${NC}
echo -e ${ORANGE}' _$$ |_ $$ |  $$ | $$$$$$  |  $$ |/  |/$$$$$$$ |$$ |  $$ |$$$$$$$$/  $$$$$$  |$$$$$$$$/   $$ |/  |'${NC}
echo -e ${YELLOW}'/ $$   |$$ |  $$ |/     $$/   $$  $$/ $$    $$ |$$ |  $$ |$$       |/     $$/ $$       |  $$  $$/ '${NC}
echo -e ${YELLOW}'$$$$$$/ $$/   $$/ $$$$$$$/     $$$$/   $$$$$$$/ $$/   $$/  $$$$$$$/ $$$$$$$/   $$$$$$$/    $$$$/  '${NC}
echo '                      < Instagram Password Reset program from exit_n0de >                         '
echo ""
echo ""
echo ""

if [ "${curlout}" = "" ]
then
        echo "ERROR getting Mail/Mobile Number - Try again!!"
        echo ""
elif [ "${isUsID}" == "${UsID}" ]
then
        echo -e "Password reset link for ${BLUE}${username}${NC} was sent to: ${RED}${curlout}${NC}"
        echo -e "User ID: ${RED}${UsID}${NC}"
        echo ""
        echo ""
        echo -e "${GREEN}User already listed:${NC}      "`cat user_uid_mail.txt | grep ${UsID}`
        echo ""
else
        echo -e "Password reset link for ${BLUE}${username}${NC} was sent to: ${RED}${curlout}${NC}"
        echo -e "User ID: ${RED}${UsID}${NC}"
        echo ""
        echo ""
        echo -e "${GREEN}Username and Mail/Mobile Number saved:" ${RED}`pwd`${NC}
        echo ""
        echo ""
        #echo "${username}" >> usernames.txt
        #echo "${curlout}" >> mails.txt
        #echo "${UsID}" >> uid.txt
        echo "${username}":"${UsID}"::"${curlout}" >> user_uid_mail.txt
fi
