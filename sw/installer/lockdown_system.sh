#!/bin/bash
#
# This is just a small script for lockdown of the system
# it will close down all ports and stop ssh daemon
# additionally it will prevent the ssh daemon from starting again in the futur
# funnily you can execute this script via ssh and work on the system until you disconnect
# :-)
#



function initiallockdown {
  echo ""
  echo "== locking down system =="
  
  /etc/init.d/ssh stop
  iptables -P INPUT ACCEPT
  iptables -P OUTPUT ACCEPT
  iptables -P FORWARD ACCEPT
  iptables -t nat -F
  iptables -F 

  ip6tables -P INPUT ACCEPT
  ip6tables -P OUTPUT ACCEPT
  ip6tables -P FORWARD ACCEPT
  ip6tables -F
  
  #allow local network
  iptables  -A INPUT -i lo -j ACCEPT
  ip6tables -A INPUT -i lo -j ACCEPT
  
  #allow established connections
  iptables  -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
  ip6tables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
  
  #drop everything else
  iptables  -A INPUT -j DROP
  ip6tables -A INPUT -j DROP
}


function create_filewallscript {
  echo ""
  echo "== Create the firewall script == "
  
  echo "#!/bin/bash">/etc/firewall
  echo "" >>/etc/firewall
  echo "iptables -P INPUT ACCEPT" >>/etc/firewall
  echo "iptables -P OUTPUT ACCEPT" >>/etc/firewall
  echo "iptables -P FORWARD ACCEPT" >>/etc/firewall
  echo "iptables -t nat -F" >>/etc/firewall
  echo "iptables -F " >>/etc/firewall
  echo "" >>/etc/firewall
  echo "ip6tables -P INPUT ACCEPT" >>/etc/firewall
  echo "ip6tables -P OUTPUT ACCEPT" >>/etc/firewall
  echo "ip6tables -P FORWARD ACCEPT" >>/etc/firewall
  echo "ip6tables -F" >>/etc/firewall
  echo "" >>/etc/firewall
  echo "#allow local network" >>/etc/firewall
  echo "iptables  -A INPUT -i lo -j ACCEPT" >>/etc/firewall
  echo "ip6tables -A INPUT -i lo -j ACCEPT" >>/etc/firewall
  echo "" >>/etc/firewall
  echo "#allow established connections" >>/etc/firewall
  echo "iptables  -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT" >>/etc/firewall
  echo "ip6tables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT" >>/etc/firewall
  echo "" >>/etc/firewall
  echo "#drop everything else" >>/etc/firewall
  echo "iptables  -A INPUT -j DROP" >>/etc/firewall
  echo "ip6tables -A INPUT -j DROP" >>/etc/firewall
  chmod 755 /etc/firewall
  
  cat /etc/rc.local |grep -v "exit 0" |grep -v "/etc/firewall" >/tmp/rc.local_tmp
  echo "/etc/firewall" >>/tmp/rc.local_tmp
  echo "exit 0" >>/tmp/rc.local_tmp
  cat /tmp/rc.local_tmp >/etc/rc.local
  rm /tmp/rc.local_tmp
}

function rmssh {
  echo ""
  echo "== Removing ssh from init system =="
  
  find /etc/rc2.d/ -name "*ssh" -exec rm {} \;
}


##########################################################################################
###     main
##########################################################################################
initiallockdown
create_filewallscript
rmssh


