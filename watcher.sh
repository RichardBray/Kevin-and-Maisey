#!/bin/bash
cecho() {
    RED="\033[0;31m"
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    NC='\033[0m'
    osascript -e 'display notification "🎉 Build finished!!!" with title "HaxeFlixel" sound name "Ping"'
    printf "${!1}${2} ${NC}\n"
}

echo "🔨  Building game!!!"
lime build html5 -debug 
cecho "GREEN" "🎉  Build finished!!!"
