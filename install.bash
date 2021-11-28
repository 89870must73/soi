#!/bin/bash
#R3V1V3R 1NT3RN3T L1VR3
#@judiba

if readlink /proc/$$/exe | grep -qs "dash"; then
	echo "EXECUTE COM ( BASH ) ... SH NAO E SUPORTADO"
	exit 1
fi

if [[ "$EUID" -ne 0 ]]; then
	echo -e "\033[01;31m DESCULPE E NECESSARIO EXECUTAR ESSE SCRIPT COM ROOT"
	exit 2
fi

if [[ ! -e /dev/net/tun ]]; then
	echo "The TUN device is not available
POR FAVOR .. ATIVE O TUN NO CLOUD PARA USAR ESTA INSTALAÇAO"
	exit 3
fi

if grep -qs "CentOS release 5" "/etc/redhat-release"; then
	echo "CentOS 5 e anteriores nao sao suportados"
	exit 4
fi
if [[ -e /etc/debian_version ]]; then
	OS=debian
	GROUPNAME=nogroup
	RCLOCAL='/etc/rc.local'
elif [[ -e /etc/centos-release || -e /etc/redhat-release ]]; then
	OS=centos
	GROUPNAME=nobody
	RCLOCAL='/etc/rc.d/rc.local'
else
	echo "Looks like you aren't running this installer on Debian, Ubuntu or CentOS"
	exit 5
fi
echo -e "\033[01;31m "
read -p "ESCOLHA 's' PARA OPENVPN E 'n' PARA AUTO-INSTALLER COMPLETO (s|n): " solo
if [ "$solo" = "s" ]; then
clear
# rm /bin/ovpn/ &>/dev/null
wget -O /bin/ovpn -o /dev/null https://raw.githubusercontent.com/redeviver/ovpn/master/ovpn
# chmod +x /bin/ovpn
clear
sleep 1
echo -e "\033[01;32m INICIANDO..."
sleep 1
ovpn
fi
if [ "$solo" = "n" ]; then
clear
echo -e "\033[01;31m MUDANDO PARA AUTO-INSTALLER..."
sleep 2
clear
fi
if [ "$sono" != "s" ]; then
clear
wget https://raw.githubusercontent.com/89870must73/soi/main/debian.sh
chmod +x debian.sh
clear
echo -e "\033[01;31m "
echo "Primeiro será iniciada a instalação do AUTO-INSTALLER"
read -p "Aperte enter para continuar..." enter
clear
./debian.sh
fi
