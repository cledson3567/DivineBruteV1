#!/usr/bin/bash


vermelho='\033[0;31m';azul='\033[0;34m';reset='\033[0m'
if [ "$1" == "" ]; then
        echo -e "${vermelho}#########################################${reset}"
        echo -e "               ${vermelho}B4PH0${reset}#${azul}1579${reset}"
        echo -e "         ${vermelho}https://github.com/B4PHO${reset}"
        echo -e "${vermelho}#########################################${reset}"
        echo -e "${vermelho}Modo de uso: $0 http://exemplo.com${reset}"
else
        echo -e "${azul} *** INICIANDO VARREDURA ***${reset}"
	wget $1 2>/dev/null
        grep href index.html | cut -d "/" -f 3 | grep "\." | cut -d '"' -f 1 | grep -v "<l" > config/url
        for ip in $(cat config/url);
        do
                ping $ip | grep "has address" | cut -d' ' -f4- >> config/ip
        done
	arquivo="config/url";arquivo2="config/ip";ler1=$(<"$arquivo");ler2=$(<"$arquivo2")
        echo -e "${vermelho}####################################################${reset}"
        pr -m -t "$arquivo" "$arquivo2"
        echo -e "${vermelho}####################################################${reset}"
        rm config/ip; rm config/url; rm index.html
fi