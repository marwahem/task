# Initialization:
#================
iptables -F
iptables -X
iptables -Z
echo 0 > /proc/sys/net/ipv4/ip_forward
echo "1" > /proc/sys/net/ipv4/ip_dynaddr

# Set default policy to drop:
#============================
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

## Allow all connections on loopback interface:
##=============================================
iptables -A INPUT  -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

## Allow Incoming/outgoing Pings:
#================================
# Incoming:
#----------
iptables -A INPUT  -p icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT
# Outgoing:
#----------
iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A INPUT  -p icmp --icmp-type echo-reply -j ACCEPT

## Outgoing Connections:
##======================
# Web browsing:
#--------------
# http:
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT  -p tcp --sport 80 ! --syn -j ACCEPT
# https:
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT  -p tcp --sport 443 ! --syn -j ACCEPT

iptables -A INPUT  -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 ! --syn -j ACCEPT

# Web browsing:
#--------------
# http:
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 80 ! --syn -j ACCEPT
# https:
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 443 ! --syn -j ACCEPT

# DNS resolving:
#---------------
iptables -A OUTPUT -p udp  --sport 1024:65535 --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p udp  --sport 53 --dport 1024:65535 -m state --state ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 1024:65535 --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --sport 53 --dport 1024:65535 -m state --state ESTABLISHED -j ACCEPT

## INCOMING CONNECTIONS:
#=======================
# SSH:

