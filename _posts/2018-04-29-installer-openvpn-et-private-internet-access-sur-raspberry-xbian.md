---
ID: 543
post_title: >
  Installer openvpn et private internet
  access sur raspberry xbian
author: nicolas
post_excerpt: ""
layout: post
permalink: >
  https://rouni.fr/installer-openvpn-et-private-internet-access-sur-raspberry-xbian/
published: true
post_date: 2018-04-29 18:16:25
---
<h3>Installer et configurer openvpn</h3>
apt install openvpn
<pre class="lang:sh decode:true ">cd /etc/openvpn/
sudo wget --no-check-certificate https://www.privateinternetaccess.com/openvpn/openvpn.zip
sudo unzip openvpn.zip</pre>
Créer un fichier texte contenant le login et le mot de passe du compte private internet access
<pre class="lang:sh decode:true ">sudo vi login.txt</pre>
Entrer le nom d'utilisateur et le mot de passe sur deux lignes :

<code>username</code>
<code> password</code>

Modifier les permissions du fichier pour qu'il ne soit lisible que par root :
<pre class="lang:sh decode:true">sudo chmod 700 login.txt</pre>
Éventuellement, fixer les erreurs DNS en utilisant les serveurs Google (ou cloudflare)
<pre class="lang:sh decode:true ">echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf
echo "nameserver 8.8.4.4" | sudo tee -a /etc/resolv.conf</pre>
Rendre ceci permanent :
<pre class="lang:sh decode:true">sudo chattr +i /etc/resolv.conf</pre>
&nbsp;

On peut maintenant tester que le vpn PIA fonctionne correctement :
<pre class="lang:sh decode:true">cd /etc/openvpn
sudo openvpn --config /etc/openvpn/Sweden.ovpn --auth-user-pass /etc/openvpn/login.txt</pre>
Si tout se passe bien, on obtient une séquence comme ceci :
<pre class="lang:sh decode:true">Wed May 4 08:42:37 2016 OpenVPN 2.3.4 arm-unknown-linux-gnueabihf [SSL (OpenSSL)] [LZO] [EPOLL] [PKCS11] [MH] [IPv6] built on Jan 23 2016
Wed May 4 08:42:37 2016 library versions: OpenSSL 1.0.1k 8 Jan 2015, LZO 2.08
Wed May 4 08:42:37 2016 UDPv4 link local: [undef]
Wed May 4 08:42:37 2016 UDPv4 link remote: [AF_INET]<span style="color: #ff0000;">185.3.135.34</span>:1194
Wed May 4 08:42:37 2016 WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this
Wed May 4 08:42:37 2016 [Private Internet Access] Peer Connection Initiated with [AF_INET]185.3.135.34:1194
Wed May 4 08:42:40 2016 TUN/TAP device tun0 opened
Wed May 4 08:42:40 2016 do_ifconfig, tt-&gt;ipv6=0, tt-&gt;did_ifconfig_ipv6_setup=0
Wed May 4 08:42:40 2016 /sbin/ip link set dev tun0 up mtu 1500
Wed May 4 08:42:40 2016 /sbin/ip addr add dev tun0 local 10.177.1.6 peer 10.177.1.5
Wed May 4 08:42:40 2016 Initialization Sequence Completed</pre>
On voit en rouge notre adresse IP publique qui est différente de l'IP attribuée par le FAI.

Pour vérifier, ouvrir une autre session ssh et entrer :
<pre class="lang:sh decode:true ">wget http://ipinfo.io/ip -qO -</pre>
On doit retrouver l'adresse IP en rouge ci-dessus.

La configuration de openvpn et PIA est terminée.
<h3>Connexion automatique au boot</h3>
Créer un fichier de script de démarrage OpenVPN autoconnect dans /etc/init.d.
<pre class="lang:sh decode:true ">sudo vi /etc/init.d/openvpnauto</pre>
Entrer ce qui suit dedans :

Remplacer le pays éventuellement par celui voulu (France.ovpn par exemple) dans la ligne DAEMON_OPTS
<pre class="lang:sh decode:true">#!/bin/sh
### BEGIN INIT INFO
# Provides:          OpenVPN Autoconnect
# Required-Start:    $local_fs $remote_fs $network
# Required-Stop:     $local_fs $remote_fs $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: OpenVPN Autoconnect
# Description:       OpenVPN Autoconnect
### END INIT INFO


# Documentation available at
# http://refspecs.linuxfoundation.org/LSB_3.1.0/LSB-Core-generic/LSB-Core-generic/iniscrptfunc.html
# Debian provides some extra functions though
. /lib/lsb/init-functions


DAEMON_NAME="openvpnauto"
DAEMON_USER=root
DAEMON_PATH="/usr/sbin/openvpn"
DAEMON_OPTS="--config /etc/openvpn/Sweden.ovpn --auth-user-pass /etc/openvpn/login.txt"
DAEMON_PWD="/etc/openvpn"
DAEMON_DESC=$(get_lsb_header_val $0 "Short-Description")
DAEMON_PID="/var/run/${DAEMON_NAME}.pid"
DAEMON_NICE=0
DAEMON_LOG='/var/log/openvpnauto.log'

[ -r "/etc/default/${DAEMON_NAME}" ] &amp;&amp; . "/etc/default/${DAEMON_NAME}"

do_start() {
  local result

    pidofproc -p "${DAEMON_PID}" "${DAEMON_PATH}" &gt; /dev/null
    if [ $? -eq 0 ]; then
        log_warning_msg "${DAEMON_NAME} is already started"
        result=0
    else
        log_daemon_msg "Starting ${DAEMON_DESC}" "${DAEMON_NAME}"
        touch "${DAEMON_LOG}"
        chown $DAEMON_USER "${DAEMON_LOG}"
        chmod u+rw "${DAEMON_LOG}"
        if [ -z "${DAEMON_USER}" ]; then
            start-stop-daemon --start --quiet --oknodo --background \
                --nicelevel $DAEMON_NICE \
                --chdir "${DAEMON_PWD}" \
                --pidfile "${DAEMON_PID}" --make-pidfile \
                --exec "${DAEMON_PATH}" -- $DAEMON_OPTS
            result=$?
        else
            start-stop-daemon --start --quiet --oknodo --background \
                --nicelevel $DAEMON_NICE \
                --chdir "${DAEMON_PWD}" \
                --pidfile "${DAEMON_PID}" --make-pidfile \
                --chuid "${DAEMON_USER}" \
                --exec "${DAEMON_PATH}" -- $DAEMON_OPTS
            result=$?
        fi
        log_end_msg $result
    fi
    return $result
}

do_stop() {
    local result

    pidofproc -p "${DAEMON_PID}" "${DAEMON_PATH}" &gt; /dev/null
    if [ $? -ne 0 ]; then
        log_warning_msg "${DAEMON_NAME} is not started"
        result=0
    else
        log_daemon_msg "Stopping ${DAEMON_DESC}" "${DAEMON_NAME}"
        killproc -p "${DAEMON_PID}" "${DAEMON_PATH}"
        result=$?
        log_end_msg $result
        rm "${DAEMON_PID}"
    fi
    return $result
}

do_restart() {
    local result
    do_stop
    result=$?
    if [ $result = 0 ]; then
        do_start
        result=$?
    fi
    return $result
}

do_status() {
    local result
    status_of_proc -p "${DAEMON_PID}" "${DAEMON_PATH}" "${DAEMON_NAME}"
    result=$?
    return $result
}

do_usage() {
    echo $"Usage: $0 {start | stop | restart | status}"
    exit 1
}

case "$1" in
start)   do_start;   exit $? ;;
stop)    do_stop;    exit $? ;;
restart) do_restart; exit $? ;;
status)  do_status;  exit $? ;;
*)       do_usage;   exit  1 ;;
esac</pre>
Activer le script et le lancer :
<pre class="lang:sh decode:true ">sudo chmod +x /etc/init.d/openvpnauto
sudo update-rc.d openvpnauto defaults 98
sudo service openvpnauto start</pre>
On peut à nouveau vérifier l'adresse IP publique obtenue qui doit être différente de celle fournie par le FAI :
<pre class="lang:sh decode:true ">wget http://ipinfo.io/ip -qO -</pre>
Pour vérifier le bon lancement au boot, on... reboote !
<pre class="lang:sh decode:true ">sudo reboot</pre>
Et voilà !

&nbsp;

Source : <a href="https://www.htpcguides.com/autoconnect-private-internet-access-vpn-boot-linux/" target="_blank" rel="noopener">Autoconnect Private Internet Access VPN on Boot Linux</a>