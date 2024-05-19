#!/bin/bash
# Extraer informacion de nmap
# Ejecutar como:
# extractPorts allPorts

function extractPorts(){
	# say how to usage
	if [ -z "$1" ]; then
		echo "Usage: extractPorts <filename>"
		return 1
	fi

	# Say file not found
	if [ ! -f "$1" ]; then
		echo "File $1 not found"
		return 1
	fi

	#if this not found correctly, you can delete it, from "if" to "fi".
	if ! grep -qE '^[^#].*/open/' "$1"; then
		echo "Format Invalid: Use -oG <file>, in nmap for a correct format."
		return 1
	fi

	ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')";
	ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
	echo -e "\n[+] Extracting information...\n" > extractPorts.tmp
	echo -e "\t[+] IP Address: $ip_address"  >> extractPorts.tmp
	echo -e "\t[+] Open ports: $ports\n"  >> extractPorts.tmp
	echo $ports | tr -d '\n' | xclip -selection clipboard
	echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
	cat extractPorts.tmp; rm extractPorts.tmp
}
extractPorts "$1"

#by: Audiforze(Physco)
#base: kroota
