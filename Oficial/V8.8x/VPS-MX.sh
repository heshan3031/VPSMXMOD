#!/bin/bash

clear
if [ `whoami` != 'root' ]
	then 
     echo -e "\e[1;31mPARA PODER USAR EL INSTALADOR ES NECESARIO SER ROOT\nAUN NO SABES COMO INICAR COMO ROOT?\nDIJITA ESTE COMANDO EN TU TERMINAL ( sudo -i )\e[0m" 
     rm *
     exit 
fi
msg () {
BRAN='\033[1;37m' && VERMELHO='\e[31m' && VERDE='\e[32m' && AMARELO='\e[33m'
AZUL='\e[34m' && MAGENTA='\e[35m' && MAG='\033[1;36m' &&NEGRITO='\e[1m' && SEMCOR='\e[0m'
 case $1 in
  -ne)cor="${VERMELHO}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -ama)cor="${AMARELO}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm)cor="${AMARELO}${NEGRITO}[!] ${VERMELHO}" && echo -e "${cor}${2}${SEMCOR}";;
  -azu)cor="${MAG}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verd)cor="${VERDE}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -bra)cor="${VERMELHO}" && echo -ne "${cor}${2}${SEMCOR}";;
  "-bar2"|"-bar")cor="${VERMELHO}————————————————————————————————————————————————————" && echo -e "${SEMCOR}${cor}${SEMCOR}";;
 esac
}
os_system(){
#code by rufu99
  system=$(cat -n /etc/issue |grep 1 |cut -d ' ' -f6,7,8 |sed 's/1//' |sed 's/      //')
  distro=$(echo "$system"|awk '{print $1}')

  case $distro in
    Debian)vercion=$(echo $system|awk '{print $3}'|cut -d '.' -f1);;
    Ubuntu)vercion=$(echo $system|awk '{print $2}'|cut -d '.' -f1,2);;
  esac

  link="https://raw.githubusercontent.com/NearVPN/VPS-MX-8.5-Sin-Key/main/Repositorios/${vercion}.list"

  case $vercion in
    8|9|10|11|16.04|18.04|20.04|20.10|21.04|21.10|22.04)wget -O /etc/apt/sources.list ${link} &>/dev/null;;
  esac
}
fun_bar () {
comando="$1"
 _=$(
$comando > /dev/null 2>&1
) & > /dev/null
pid=$!
while [[ -d /proc/$pid ]]; do
echo -ne "  \033[1;33m["
   for((i=0; i<40; i++)); do
   echo -ne "\033[1;31m>"
   sleep 0.1
   done
echo -ne "\033[1;33m]"
sleep 0.1
echo
tput cuu1 && tput dl1
done
echo -ne "  \033[1;33m[\033[1;31m>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\033[1;33m] - \033[1;32m OK \033[0m\n"
sleep 1s
}
msg -bar2
echo -e " \e[97m\033[1;41m   [----► DANSMX SCRIPT•MOD ◄----]      \033[1;37m"
msg -bar2
msg -ama "               PREPARANDO INSTALACION"
msg -bar2
INSTALL_DIR_PARENT="/usr/local/vpsmxup/"
INSTALL_DIR=${INSTALL_DIR_PARENT}
if [ ! -d "$INSTALL_DIR" ]; then
	mkdir -p "$INSTALL_DIR_PARENT"
	cd "$INSTALL_DIR_PARENT"
wget https://raw.githubusercontent.com/NearVPN/VPSMXMOD/master/zzupdate/zzupdate.default.conf.txt -O /usr/local/vpsmxup/vpsmxup.default.conf  &> /dev/null
 
else
	echo ""
fi
echo ""
#by kalix1
apt install pv -y &> /dev/null
apt install pv -y -qq --silent > /dev/null 2>&1
os_system
echo -e "\e[1;31m	SISTEMA: \e[33m$distro $vercion"
killall apt apt-get > /dev/null 2>&1 && echo -e "\033[97m    ◽️ INTENTANDO DETENER UPDATER SECUNDARIO " | pv -qL 40
dpkg --configure -a > /dev/null 2>&1 && echo -e "\033[97m    ◽️ INTENTANDO RECONFIGURAR UPDATER " | pv -qL 40
apt list --upgradable &>/dev/null && echo -e "\033[97m    ◽️ INSTALANDO APT-LIST " | pv -qL 50

apt-get install software-properties-common -y > /dev/null 2>&1 && echo -e "\033[97m    ◽️ INSTALANDO S-P-C " | pv -qL 50
apt-get install curl -y &>/dev/null
apt install python -y &>/dev/null && echo -e "\033[97m    ◽️ INSTALANDO PY " | pv -qL 50
apt-get install python-pip -y &>/dev/null && echo -e "\033[97m    ◽️ INSTALANDO PY-PIP " | pv -qL 50
apt-get install python3 -y &>/dev/null && echo -e "\033[97m    ◽️ INSTALANDO PY3 " | pv -qL 50
apt-get install python3-pip -y &>/dev/null && echo -e "\033[97m    ◽️ INSTALANDO PY3-PIP " | pv -qL 50

sudo apt-add-repository universe -y > /dev/null 2>&1 && echo -e "\033[97m    ◽️ INSTALANDO LIBRERIA UNIVERSAL " | pv -qL 50
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || apt-get install net-tools -y &>/dev/null && echo -e "\033[97m    ◽️ INSTALANDO NET-TOOLS" | pv -qL 40
sed -i 's/.*pam_cracklib.so.*/password sufficient pam_unix.so sha512 shadow nullok try_first_pass #use_authtok/' /etc/pam.d/common-password > /dev/null 2>&1 && echo -e "\033[97m    ◽️ DESACTIVANDO PASS ALFANUMERICO " | pv -qL 50
apt-get install lsof -y &>/dev/null && echo -e "\033[97m    ◽️ INSTALANDO LSOF" | pv -qL 40
apt-get install sudo -y &>/dev/null && echo -e "\033[97m    ◽️ INSTALANDO SUDO" | pv -qL 40
apt-get install bc -y &>/dev/null && echo -e "\033[97m    ◽️ INSTALANDO BC" | pv -qL 40
#service ssh restart > /dev/null 2>&1 && echo -e "\033[97m    ◽️ REINICIANDO SERVICIO SSH RESTART" | pv -qL 60

rootvps(){

echo -e "\033[31m     OPTENIENDO ACCESO ROOT    "
wget https://raw.githubusercontent.com/NearVPN/VPSMXMOD/master/SR/root.sh &>/dev/null -O /usr/bin/rootlx &>/dev/null
chmod 775 /usr/bin/rootlx &>/dev/null
rootlx
clear
echo -e "\033[31m     ACCESO ROOT CON ÉXITO    "
sleep 1
rm -rf /usr/bin/rootlx
}
	msg -bar
	echo -e "\033[1;37m  YA TIENES ACCESO ROOT A TU VPS?\n  ESTO SOLO FUNCIONA PARA (AWS,GOOGLECLOUD,AZURE,ETC)\n  SI YA TIENES ACCESO A ROOT SOLO IGNORA ESTE MENSAJE\n  Y SIGUE CON LA INSTALACION NORMAL..."
   msg -bar
   read -p "Responde [ s | n ]: " -e -i n rootvps
   [[ "$rootvps" = "s" || "$rootvps" = "S" ]] && rootvps
   
msg -bar
clear
rm -rf /usr/bin/vpsmxup
rm -rf lista-arq
rm -rf VPS-MX.sh
function printTitle
{
    echo ""
    echo -e "\033[1;92m$1\033[1;91m"
    printf '%0.s-' $(seq 1 ${#1})
    echo ""
}

printTitle "Limpieza de caché local"
apt-get clean

printTitle "Actualizar información de paquetes disponibles"
apt-get update

printTitle "PAQUETES DE ACTUALIZACIÓN"
apt-get dist-upgrade -y

printTitle "Limpieza de paquetes (eliminación automática de paquetes no utilizados)"
apt-get autoremove -y

printTitle "Versión actual"
lsb_release -d

clear

cd $HOME
#sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1 > /dev/null 2>&1
#sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1 > /dev/null 2>&1
#sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1 > /dev/null 2>&1
#systemedia &> /dev/null
rm $(pwd)/$0 &> /dev/null
SCPdir="/etc/VPS-MX"
SCPinstal="$HOME/install"
SCPidioma="${SCPdir}/idioma"
SCPusr="${SCPdir}/controlador"
SCPfrm="${SCPdir}/herramientas"
SCPinst="${SCPdir}/protocolos"
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;
rm -rf /etc/localtime &>/dev/null
ln -s /usr/share/zoneinfo/America/Chihuahua /etc/localtime &>/dev/null
rm -rf /usr/local/lib/systemubu1 &> /dev/null
### COLORES Y BARRA 
clear
#msg -bar2
# PAQUETES PRINCIPALES 
msg -bar2
msg -ama "     [ \033[1;97m [----► DANSMX SCRIPT•MOD ◄----]\033[1;33m ]"
msg -bar
echo -e "\033[97m"
echo -e "  \033[41m    -- INSTALACION DE PAQUETES  --    \e[49m"
echo -e "  \033[100m     PONER ATENCION  PARA SIGUIENTE PREGUNTA     "
echo -e "\033[97m"
msg -bar

#grep
apt-get install sudo -y &>/dev/null
apt-get install grep -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "grep"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "grep"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install grep............ $ESTATUS "
#gawk
apt-get install gawk -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "gawk"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "gawk"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install gawk............ $ESTATUS "
#mlocate
apt-get install mlocate -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "mlocate"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "mlocate"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install mlocate......... $ESTATUS "
#lolcat gem
apt-get install lolcat -y &>/dev/null
sudo gem install lolcat &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install lolcat.......... $ESTATUS "
#at
[[ $(dpkg --get-selections|grep -w "at"|head -1) ]] || apt-get install at -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "at"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "at"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install at.............. $ESTATUS "
#nano
[[ $(dpkg --get-selections|grep -w "nano"|head -1) ]] || apt-get install nano -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "nano"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "nano"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install nano............ $ESTATUS "
#iptables
#echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
#echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
[[ $(dpkg --get-selections|grep -w "iptables"|head -1) ]] || apt-get install iptables -y &>/dev/null
#[[ $(dpkg --get-selections|grep -w "iptables"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
#[[ $(dpkg --get-selections|grep -w "iptables"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
#echo -e "\033[97m    # apt-get install iptables........ $ESTATUS "
#bc
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || apt-get install bc -y &>/dev/null
#[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
#[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
#systemedia &> /dev/null
#echo -e "\033[97m    # apt-get install bc.............. $ESTATUS "
#lsof
[[ $(dpkg --get-selections|grep -w "lsof"|head -1) ]] || apt-get install lsof -y &>/dev/null
#[[ $(dpkg --get-selections|grep -w "lsof"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
#[[ $(dpkg --get-selections|grep -w "lsof"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
#echo -e "\033[97m    # apt-get install lsof............ $ESTATUS "
#figlet
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || apt-get install figlet -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install figlet.......... $ESTATUS "
#cowsay
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || apt-get install cowsay -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install cowsay.......... $ESTATUS "
#screen
[[ $(dpkg --get-selections|grep -w "screen"|head -1) ]] || apt-get install screen -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "screen"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "screen"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install screen.......... $ESTATUS "
#python
[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] || apt-get install python -y &>/dev/null
#[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
#[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
#echo -e "\033[97m    # apt-get install python.......... $ESTATUS "
#python3
[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] || apt-get install python3 -y &>/dev/null
#[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
#[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
#echo -e "\033[97m    # apt-get install python3......... $ESTATUS "
#python3-pip
[[ $(dpkg --get-selections|grep -w "python3-pip"|head -1) ]] || apt-get install python3-pip -y &>/dev/null
#[[ $(dpkg --get-selections|grep -w "python3-pip"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
#[[ $(dpkg --get-selections|grep -w "python3-pip"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
#echo -e "\033[97m    # apt-get install python3-pip..... $ESTATUS "
#ufw
[[ $(dpkg --get-selections|grep -w "ufw"|head -1) ]] || apt-get install ufw -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "ufw"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "ufw"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install ufw............. $ESTATUS "
#unzip
[[ $(dpkg --get-selections|grep -w "unzip"|head -1) ]] || apt-get install unzip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "unzip"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "unzip"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install unzip........... $ESTATUS "
#zip
[[ $(dpkg --get-selections|grep -w "zip"|head -1) ]] || apt-get install zip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "zip"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "zip"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install zip............. $ESTATUS "
#apache2
apt-get install apache2 -y &>/dev/null
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf > /dev/null 2>&1
service apache2 restart > /dev/null 2>&1 
#
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m    # apt-get install apache2......... $ESTATUS "
msg -bar2

read -t 20 -n 1 -rsp $'\033[1;39m Por Favor Preciona Enter Para continuar\n'
clear
### FIXEADOR PARA SISTEMAS 86_64
idfix64_86 () {
clear
clear
msg -bar2
#msg -ama "     [ VPS - MX - SCRIPT \033[1;97m MOD\033[1;33m ]"
msg -bar2
echo ""
echo -e "\e[91m   INSTALACION SEMI MANUAL DE PAQUETES "
echo -e "\e[91m(En caso de pedir confirmacion escoja: #y#) \e[0m"
echo ""
sleep 7s
apt-get update; apt-get upgrade -y
apt-get install curl -y
apt-get install lsof -y
apt-get install sudo -y
apt-get install figlet -y
apt-get install cowsay -y
apt-get install bc -y
apt-get install python -y
apt-get install at -y
apt-get install apache2 -y
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart
clear
clear
clear
msg -bar2
#msg -ama "     [ VPS - MX - SCRIPT \033[1;97m  MOD   \033[1;33m ]"
msg -bar2
echo ""
echo -e "\e[91mESCOJER PRIMERO #All locales# Y LUEGO #en_US.UTF-8# \e[0m" 
echo ""
sleep 7s
 export LANGUAGE=en_US.UTF-8\
   && export LANG=en_US.UTF-8\
   && export LC_ALL=en_US.UTF-8\
   && export LC_CTYPE="en_US.UTF-8"\
   && locale-gen en_US.UTF-8\
   && sudo apt-get -y install language-pack-en-base\
   && sudo dpkg-reconfigure locales
clear
}
clear
clear
msg -bar2
#msg -ama "     [ VPS - MX - SCRIPT \033[1;97m  MOD \033[1;33m ]"
figlet "Bienvenido" | lolcat 
#msg -bar2
echo -e "\033[1;97m  ¿PRECENTO ALGUN ERROR ALGUN PAQUETE ANTERIOR?" 
msg -bar2
echo -e "\033[1;32m 1- Escoja:(N) No. Para Instalacion Normal"
echo -e "\033[1;31m 2- Escoja:(S) Si. Saltaron errores."
msg -bar2
echo -e "\033[1;39m Al precionar enter continuara la instalacion Normal"
msg -bar2
read -p " [ S | N ]: " idfix64_86   
[[ "$idfix64_86" = "s" || "$idfix64_86" = "S" ]] && idfix64_86
clear

funcao_idioma () {
clear
clear
msg -bar2
msg -bar2
figlet " NOTY-BOT" | lolcat 
echo -e "     ESTE SCRIPT ESTA OPTIMIZADO A IDIOMA ESPAÑOL"
msg -bar2
pv="$(echo es)"
[[ ${#id} -gt 2 ]] && id="es" || id="$pv"
byinst="true"
}
clear && clear
  msg -bar
  msg -bar
  figlet " SLOGAN" | lolcat 
  msg -bar
  echo -ne "\033[1;97m Digite su slogan: \033[1;32m" && read slogan
  tput cuu1 && tput dl1
  echo -e "$slogan"
  msg -bar
  clear && clear

mkdir /etc/VPS-MX >/dev/null 2>&1

cd /etc/VPS-MX
wget https://www.dropbox.com/s/zc8uy4spy9kiwuk/VPS-MX.tar.xz >/dev/null 2>&1
tar -xf VPS-MX.tar.xz >/dev/null 2>&1
chmod +x VPS-MX.tar.xz >/dev/null 2>&1
rm -rf VPS-MX.tar.xz
cd
chmod -R 755 /etc/VPS-MX
rm -rf /etc/VPS-MX/MEUIPvps
echo "/etc/VPS-MX/menu" >/usr/bin/menu && chmod +x /usr/bin/menu
echo "/etc/VPS-MX/menu" >/usr/bin/VPSMX && chmod +x /usr/bin/VPSMX
echo "$slogan" >/etc/VPS-MX/message.txt
[[ ! -d /usr/local/lib ]] && mkdir /usr/local/lib
[[ ! -d /usr/local/lib/ubuntn ]] && mkdir /usr/local/lib/ubuntn
[[ ! -d /usr/local/lib/ubuntn/apache ]] && mkdir /usr/local/lib/ubuntn/apache
[[ ! -d /usr/local/lib/ubuntn/apache/ver ]] && mkdir /usr/local/lib/ubuntn/apache/ver
[[ ! -d /usr/share ]] && mkdir /usr/share
[[ ! -d /usr/share/mediaptre ]] && mkdir /usr/share/mediaptre
[[ ! -d /usr/share/mediaptre/local ]] && mkdir /usr/share/mediaptre/local
[[ ! -d /usr/share/mediaptre/local/log ]] && mkdir /usr/share/mediaptre/local/log
[[ ! -d /usr/share/mediaptre/local/log/lognull ]] && mkdir /usr/share/mediaptre/local/log/lognull
[[ ! -d /etc/VPS-MX/B-VPS-MXuser ]] && mkdir /etc/VPS-MX/B-VPS-MXuser
[[ ! -d /usr/local/protec ]] && mkdir /usr/local/protec
[[ ! -d /usr/local/protec/rip ]] && mkdir /usr/local/protec/rip
[[ ! -d /etc/protecbin ]] && mkdir /etc/protecbin
cd
[[ ! -d /etc/VPS-MX/v2ray ]] && mkdir /etc/VPS-MX/v2ray
[[ ! -d /etc/VPS-MX/Slow ]] && mkdir /etc/VPS-MX/Slow
[[ ! -d /etc/VPS-MX/Slow/install ]] && mkdir /etc/VPS-MX/Slow/install
[[ ! -d /etc/VPS-MX/Slow/Key ]] && mkdir /etc/VPS-MX/Slow/Key
msg -ama "               Estamos Finalizando la Instalación" && msg bar2
install_fim () {
msg -ama "               Hemos Finalizando Instalacion" && msg bar2
#rm -rf /etc/VPS-MX/controlador/nombre.log &>/dev/null
[[ $(find /etc/VPS-MX/controlador -name nombre.log|grep -w "nombre.log"|head -1) ]] || wget -O /etc/VPS-MX/controlador/nombre.log https://github.com/NearVPN/VPSMXMOD/raw/master/ArchivosUtilitarios/nombre.log &>/dev/null
[[ $(find /etc/VPS-MX/controlador -name IDT.log|grep -w "IDT.log"|head -1) ]] || wget -O /etc/VPS-MX/controlador/IDT.log https://github.com/NearVPN/VPSMXMOD/raw/master/ArchivosUtilitarios/IDT.log &>/dev/null
[[ $(find /etc/VPS-MX/controlador -name tiemlim.log|grep -w "tiemlim.log"|head -1) ]] || wget -O /etc/VPS-MX/controlador/tiemlim.log https://github.com/NearVPN/VPSMXMOD/raw/master/ArchivosUtilitarios/tiemlim.log &>/dev/null
touch /usr/share/lognull &>/dev/null
wget https://github.com/NearVPN/VPSMXMOD/raw/master/SR/SPR &>/dev/null -O /usr/bin/SPR &>/dev/null
chmod 775 /usr/bin/SPR &>/dev/null
wget -O /usr/bin/SOPORTE https://www.dropbox.com/s/i0p36pn8h61osip/soporte &>/dev/null
chmod 775 /usr/bin/SOPORTE &>/dev/null
SOPORTE &>/dev/null
echo "ACCESO ACTIVADO" >/usr/bin/SOPORTE
wget -O /bin/rebootnb https://raw.githubusercontent.com/NearVPN/VPSMXMOD/master/SCRIPT-8.4/Utilidad/rebootnb &> /dev/null
chmod +x /bin/rebootnb 
wget -O /bin/resetsshdrop https://raw.githubusercontent.com/NearVPN/VPSMXMOD/master/SCRIPT-8.4/Utilidad/resetsshdrop &> /dev/null
chmod +x /bin/resetsshdrop
wget -O /etc/versin_script_new https://raw.githubusercontent.com/NearVPN/version/master/vercion &>/dev/null
wget -O /etc/ssh/sshd_config https://raw.githubusercontent.com/NearVPN/ZETA/master/sshd &>/dev/null
chmod 777 /etc/ssh/sshd_config
msg -bar2
echo '#!/bin/sh -e' > /etc/rc.local
sudo chmod +x /etc/rc.local
echo "sudo rebootnb" >> /etc/rc.local
echo "sudo resetsshdrop" >> /etc/rc.local
echo "sleep 2s" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
/bin/cp /etc/skel/.bashrc ~/
echo 'clear' >> .bashrc
echo 'echo ""' >> .bashrc
#
echo 'rebootnb login >/dev/null 2>&1' >>.bashrc
echo 'echo -e "\033[1;31m————————————————————————————————————————————————————" ' >>.bashrc
echo 'echo -e "\033[1;93m════════════════════════════════════════════════════" ' >>.bashrc
echo 'figlet -w 85 -f smslant "         SCRIPT
     DANSMX"   | lolcat' >>.bashrc
echo 'echo -e "\033[1;93m════════════════════════════════════════════════════" ' >>.bashrc
echo 'echo -e "\033[1;31m————————————————————————————————————————————————————" ' >>.bashrc
#echo 'echo "" '>> .bashrc
echo 'mess1="$(less /etc/VPS-MX/message.txt)" ' >> .bashrc
echo 'echo "" '>> .bashrc
echo 'echo -e "\t\033[92mRESELLER : $mess1 "'>> .bashrc
echo 'echo -e "\t\e[1;33mVERSION: \e[1;31m$(cat /etc/versin_script_new)"'>> .bashrc
echo 'echo "" '>> .bashrc                                               
echo 'echo -e "\t\033[97mPARA MOSTAR PANEL BASH ESCRIBA: sudo menu "'>> .bashrc

echo 'echo ""'>> .bashrc
echo -e "         COMANDO PRINCIPAL PARA ENTRAR AL PANEL "
echo -e "  \033[1;41m               sudo menu             \033[0;37m" && msg -bar2
rm -rf /usr/bin/pytransform &> /dev/null
rm -rf VPS-MX.sh
rm -rf lista-arq
service ssh restart &>/dev/null
#exit
}

verificar_arq () {
[[ ! -d ${SCPdir} ]] && mkdir ${SCPdir}
[[ ! -d ${SCPusr} ]] && mkdir ${SCPusr}
[[ ! -d ${SCPfrm} ]] && mkdir ${SCPfrm}
[[ ! -d ${SCPinst} ]] && mkdir ${SCPinst}
case $1 in
"menu"|"message.txt"|"ID")ARQ="${SCPdir}/";; #Menu
"usercodes")ARQ="${SCPusr}/";; #Panel SSRR
"C-SSR.sh")ARQ="${SCPinst}/";; #Panel SSR
"openssh.sh")ARQ="${SCPinst}/";; #OpenVPN
"squid.sh")ARQ="${SCPinst}/";; #Squid
"dropbear.sh"|"proxy.sh"|"wireguard.sh")ARQ="${SCPinst}/";; #Instalacao
"proxy.sh")ARQ="${SCPinst}/";; #Instalacao
"openvpn.sh")ARQ="${SCPinst}/";; #Instalacao
"ssl.sh"|"python.py")ARQ="${SCPinst}/";; #Instalacao
"shadowsocks.sh")ARQ="${SCPinst}/";; #Instalacao
"Shadowsocks-libev.sh")ARQ="${SCPinst}/";; #Instalacao
"Shadowsocks-R.sh")ARQ="${SCPinst}/";; #Instalacao 
"v2ray.sh"|"slowdns.sh")ARQ="${SCPinst}/";; #Instalacao
"budp.sh")ARQ="${SCPinst}/";; #Instalacao
"sockspy.sh"|"PDirect.py"|"PPub.py"|"PPriv.py"|"POpen.py"|"PGet.py")ARQ="${SCPinst}/";; #Instalacao
*)ARQ="${SCPfrm}/";; #Herramientas
esac
mv -f ${SCPinstal}/$1 ${ARQ}/$1
chmod +x ${ARQ}/$1
}

NOTIFY () {
clear
clear
msg -bar
#msg -ama "     [ VPS - MX - SCRIPT \033[1;97m MOD \033[1;33m ]"
#msg -bar
msg -ama " Notify-BOT (Notificasion Remota)|@notidansmxbot "
msg -bar
echo -e "\033[1;94m Notify-BOT es un simple notificador de:"
echo -e "\033[1;94m >> Usuario Expirado"
echo -e "\033[1;94m >> Usuario Eliminado"
echo -e "\033[1;94m >> Avisos de VPS Reiniciada"
echo -e "\033[1;94m >> Avisos de Monitor de Protocolos"
echo -e "\033[1;97m Inicie El BOT de Telegram"
echo -e "\033[1;92m ¡¡ Para sacar su ID entre al BOT @notidansmxbot"
echo -e "\033[1;92m Aparesera algo parecido 👤 → Tu ID es: 45145564   "
msg -bar
echo -e "\033[1;93mIgrese un nombre para el VPS:\033[0;37m"; read -p " " nombr
echo "${nombr}" > /etc/VPS-MX/controlador/nombre.log
echo -e "\033[1;93mIgrese su ID 👤:\033[0;37m"; read -p " " idbot
echo "${idbot}" > /etc/VPS-MX/controlador/IDT.log 
msg -bar
echo -e "\033[1;32m              ID AGREGADO CON EXITO"
msg -bar
wget -qO- ifconfig.me > /etc/VPS-MX/IP.log
ipt=`less /etc/VPS-MX/IP.log` > /dev/null 2>&1
Nip="$(echo $ipt)"
NOM="$(less /etc/VPS-MX/controlador/nombre.log)"
NOM1="$(echo $NOM)"
IDB1=`less /etc/VPS-MX/controlador/IDT.log` > /dev/null 2>&1
IDB2=`echo $IDB1` > /dev/null 2>&1
KEY="5733339829:AAHcQnzQSKMHK2Ev7cyMrY4PbAK51QHiTWc"
URL="https://api.telegram.org/bot$KEY/sendMessage"
MSG="⚠️ ►► AVISO DE VPS: $NOM1 ⚠
👉 ►► IP: $Nip
👉 ►► MENSAJE DE PRUEBA
🔰 ►► NOTI-BOT ACTIVADO CORRECTAMENTE"
curl -s --max-time 10 -d "chat_id=$IDB2&disable_web_page_preview=1&text=$MSG" $URL &>/dev/null
echo -e "\033[1;34m            SE ENVIO MENSAJE DE PRUEBA "
}

wget -O /usr/bin/trans https://github.com/NearVPN/script/raw/master/Install/trans &> /dev/null
wget -O /bin/Desbloqueo.sh https://github.com/NearVPN/VPSMXMOD/raw/master/SCRIPT-8.4/Utilidad/Desbloqueo.sh &> /dev/null
chmod +x /bin/Desbloqueo.sh
wget -O /bin/monitor.sh https://raw.githubusercontent.com/heshan3031/VPSMXMOD/master/Monitor-Service/monitor.sh &> /dev/null
chmod +x /bin/monitor.sh
wget -O /var/www/html/estilos.css https://github.com/NearVPN/VPSMXMOD/raw/master/SCRIPT-8.4/Utilidad/estilos.css &> /dev/null
[[ -f "/usr/sbin/ufw" ]] && ufw allow 443/tcp &>/dev/null; ufw allow 80/tcp &>/dev/null; ufw allow 3128/tcp &>/dev/null; ufw allow 8799/tcp &>/dev/null; ufw allow 8080/tcp &>/dev/null; ufw allow 81/tcp &>/dev/null
clear
msg -bar2
msg -ama "     [ \033[1;97m  [----► NEAR SCRIPT•MOD ◄----]\033[1;33m ]"
msg -ama "  \033[1;96m      🔰Usar Ubuntu 20 a 64 De Preferencia🔰 "
msg -bar2
[[ $1 = "" ]] && funcao_idioma || {
[[ ${#1} -gt 2 ]] && funcao_idioma || id="$1"
 }

   wget -qO- ifconfig.me > /etc/VPS-MX/IP.log
  userid="${SCPdir}/ID"
  if [[ ! -e ${userid} ]]; then
	id="❌ID-SIN-REGISTRO❌"
	else
	id=$(cat ${userid})
	 fi
  
 		TOKEN="5733339829:AAHcQnzQSKMHK2Ev7cyMrY4PbAK51QHiTWc"
			URL="https://api.telegram.org/bot$TOKEN/sendMessage"
			MSG=" 👇= VPS INSTALADO =👇
╔═════ ▓▓ ࿇ ▓▓ ═════╗
 User ID: $id
 - - - - - - - ×∆× - - - - - - -
 Usuario: $(cat ${SCPdir}/message.txt)
 - - - - - - - ×∆× - - - - - - -
 IP: $(cat ${SCPdir}/IP.log)
 - - - - - - - ×∆× - - - - - - -
 🌮🌵🇲🇽 BIENVENIDO 🇲🇽🌵🌮
 - - - - - - - ×∆× - - - - - - -
 By @DansBotMx
 - - - - - - - ×∆× - - - - - - -
 VPS ONLINE 🟢 ACTIVO
 - - - - - - - ×∆× - - - - - - -
╚═════ ▓▓ ࿇ ▓▓ ═════╝
"
#envia a usuarios
curl -s --max-time 10 -d "chat_id=$id&disable_web_page_preview=1&text=$MSG" $URL &>/dev/null
#envia al adm

   rm ${SCPdir}/IP.log &>/dev/null
   [[ ! -d ${SCPdir}/tmp ]] && mkdir ${SCPdir}/tmp
   wget -O ${SCPdir}/tmp/verifi https://www.dropbox.com/s/4a9s7ork33vp7ha/verifi &>/dev/null
   wget -O ${SCPdir}/tmp/monitor https://www.dropbox.com/s/1ql777rj718p3h1/monitor &>/dev/null
   wget -O ${SCPdir}/tmp/autodes https://www.dropbox.com/s/9ux7j9zgr4jrsr6/autodes &>/dev/null
   chmod 777 ${SCPdir}/tmp/*
   rm ${SCPdir}/ID &>/dev/null
   sleep 1s
   msg -bar2
   listaarqs="$(locate "lista-arq"|head -1)" && [[ -e ${listaarqs} ]] && rm $listaarqs   
   cat /etc/bash.bashrc|grep -v '[[ $UID != 0 ]] && TMOUT=15 && export TMOUT' > /etc/bash.bashrc.2
   echo -e '[[ $UID != 0 ]] && TMOUT=15 && export TMOUT' >> /etc/bash.bashrc.2
   mv -f /etc/bash.bashrc.2 /etc/bash.bashrc
   
   echo "${SCPdir}/menu" > /usr/bin/menu && chmod +x /usr/bin/menu
   echo "${SCPdir}/menu" > /usr/bin/VPSMX && chmod +x /usr/bin/VPSMX
   echo "$Key" > ${SCPdir}/key.txt
   [[ -d ${SCPinstal} ]] && rm -rf ${SCPinstal}   
   [[ ${#id} -gt 2 ]] && echo "es" > ${SCPidioma} || echo "${id}" > ${SCPidioma}

   echo -e "${cor[2]}         DESEAS INSTALAR NOTI-BOT?(Default n)"
   echo -e "\033[1;34m  (Deves tener Telegram y el BOT: @notidansmxbot)"
   msg -bar2
   read -p " [ s | n ]: " NOTIFY   
   [[ "$NOTIFY" = "s" || "$NOTIFY" = "S" ]] && NOTIFY
   msg -bar2
   [[ ${byinst} = "true" ]] && install_fim
   REBOOT=1
REBOOT_TIMEOUT=10
if [ "$REBOOT" = "1" ]; then
echo -e "	\e[1;97m\e[1;100mREINICIANDO VPS EN 10 SEGUNDOS\e[0m"
while [ $REBOOT_TIMEOUT -gt 0 ]; do
msg -ne "	-$REBOOT_TIMEOUT-"
sleep 1
: $((REBOOT_TIMEOUT--))
done
reboot
fi
rm -rf VPS-MX.sh lista-arq
