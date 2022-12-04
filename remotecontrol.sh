#!/bin/bash

figlet WELCOME
echo "Before we get started, let us check if we have the relevant applications first"

function inst()
{
	#install ssh
		
	sudo apt-get install openssh-client

	#install nipe
	checknipe=$(cd nipe|grep -w no)
	if [ ! -z $checknipe ]
	then
		git clone https://github.com/htrgouvea/nipe && cd nipe
		sudo cpan install Try::Tiny Config::Simple JSON
		perl nipe.pl install
	else
		echo "You have nipe installed"
	fi
	
	#install sshpass
	
	sudo apt-get install sshpass
	
	#install nmap
	
	sudo apt-get install nmap
	clear
}

function anon()
{
	#check if the connection is anonymous
	country=$(curl -s https://ipinfo.io/$ip|grep -w country|awk '{print $2}'|tr -d '[:punct:]')
	echo "You are from $country . Please go anonymous"
	cd /home/kali/nipe
	sudo perl nipe.pl status
	stat_check=$(sudo perl nipe.pl status|grep -w activated)
	


	if [ ! -z "$stat_check" ]
	then
		echo "You are anonymous."
	else
		echo "Getting anonymity.Please wait"
		sudo perl nipe.pl start
		sudo perl nipe.pl status
	fi 
}

function vps()
{
	#connect to a vps via sshpass
	echo "Enter IP address to whois/nmap:"
	read ipadd
	#run nmap/whois on VPS
	sshpass -p tc ssh tc@192.168.122.170 "nmap $ipadd > nmap.txt;whois $ipadd > whois.txt"
	#viewing the results
	sshpass -p tc ssh tc@192.168.122.170 "cat nmap.txt"
	echo "Press enter to view the whois result"
	read
	sshpass -p tc ssh tc@192.168.122.170 "cat whois.txt"
		
}



inst
anon

vps


sudo perl nipe.pl stop
