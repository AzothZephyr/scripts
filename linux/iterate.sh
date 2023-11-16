#!/bash
#
# iterate.sh: this script uses sublist3r.py to search for subdomains of a given
# root domain, then resolves each domain.
#
# azoth zephyr <azoth@zephyr.sx>
#

# if fqdn is not provided, return usage and exit
if [ -z "$1" ]; then
	echo "Usage: `basename $0` <fqdn of target>"
	echo "example: $ bash `basename $0` pdx.net"
	exit 1
fi

fqdn=$1

# if dns server isn't provided, default to cloudflare
if [ -z "$2" ]; then
	dns_server="1.1.1.1"
	echo "no dns server provided, using '1.1.1.1'"
fi

python sublist3r.py -d $fqdn -v\
	|grep $fqdn\
	|grep -vi ssl\
	|grep -vi Enumerating\
	|sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2};?)?)?[mGK]//g" > hostnames.txt

for hostname in $(cat hostnames.txt);
do
	sign="+"
	ip=`dig @$dns_server +short $hostname`
	# if ip does not resolve
	if [ -z "$ip" ]; then
		ip="no dns record found"
		sign="-"
	fi
	echo $sign $hostname: $ip
done


rm hostnames.txt
