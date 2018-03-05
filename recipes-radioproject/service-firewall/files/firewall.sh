#!/bin/sh 

#Mon superbe firewall qu'il est à moi (rip johnny) 
# Il accepte 1 paramètre : "start","stop" ou "status" 
EXT=wlan0

case $1 in
		start)
				echo -n "Démarrage Firewall : " 
				#On supprime toutes les règles et macros 
				iptables -F
				iptables -X
				#Création d'une nouvelle macro LogDrop
				iptables -t filter -N LogDrop 
				iptables -t filter -A LogDrop -j LOG --log-prefix '[monFir]'
				iptables -t filter -A LogDrop -j DROP 
				# Politique par défaut 
				iptables -P INPUT DROP 
				iptables -P OUTPUT DROP
				iptables -P FORWARD DROP
				echo -n "P"
				# ON va autoriser les trames sur 127.0.0.1
				iptables -A INPUT -i lo -j ACCEPT 
				iptables -A OUTPUT -o lo -j ACCEPT
				echo -n "L" 
				# On va autoriser les trames ssh. !!  Je suis le serveur !!
				iptables -A INPUT -i $EXT -p tcp --dport 22 -j ACCEPT 
				iptables -A OUTPUT -o $EXT -p tcp --sport 22 -j ACCEPT
				echo -n "S"
				# On va autoriser les trames dns !! Je suis le client !!
				iptables -A INPUT -i $EXT -p udp --sport 53 -j ACCEPT 
				iptables -A OUTPUT -o $EXT -p udp --dport 53 -j ACCEPT 
				echo -n "D"
				# On va autoriser les trames http !! Je suis le client !!
				iptables -A INPUT -i $EXT -p tcp --sport 80 -j ACCEPT
				iptables -A OUTPUT -o $EXT -p tcp --dport 80 -j ACCEPT
				echo -n "H" 
				#Toutes les autres trames seront envoyés dans la macro
				iptables -t filter -A INPUT -i $EXT -j LogDrop
				iptables -t filter -A OUTPUT -o $EXT -j LogDrop 
				echo;;

		stop)
				echo "Arrêt du Firewall "
				#on supprime toutes les règles et macros
				iptables -F
				iptables -X
				#Politique par défaut
				iptables -P	INPUT ACCEPT
				iptables -P OUTPUT ACCEPT
				iptables -P FORWARD ACCEPT


				;;
		status)	
				iptables -L
				;;
		   	*)
				echo "$(basename $0) start|stop|status  "

				;;
esac
