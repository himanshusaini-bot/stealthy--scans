#!/bin/bash
clear

scan_commands=(
"nmap -sS <target>"
"nmap -sF <target>"
"nmap -sX <target>"
"nmap -sN <target>"
"nmap -sU <target>"
"nmap -sT <target>"
"nmap -sA <target>"
"nmap -sW <target>"
"nmap -sO <target>"
"nmap -PE <target>"
"nmap -sn <target>"
"arp-scan <target>"
"nmap -sI zombie <target>"
"nmap -f <target>"
"nmap -D RND:10 <target>"
"nmap --source-port 53 <target>"
"nmap --spoof-mac Apple <target>"
"nmap --mtu 24 <target>"
"nmap -sV <target>"
"nmap -O <target>"
"traceroute <target>"
"nslookup <target>"
"nmap -PS <target>"
"nmap -PA <target>"
"nmap -PO <target>"
"nmap --data-length 50 <target>"
"nmap --badsum <target>"
"nmap -6 <target>"
"nmap --scanflags SYNFINURG <target>"
"nmap --proxies http://proxy:8080 <target>"
"nmap -sS --ttl 65 <target>"
"nmap --reason <target>"
"nmap -sS --max-retries 1 <target>"
"nmap -sS --min-rate 1000 <target>"
"nmap -sS --max-rate 2000 <target>"
"nmap --host-timeout 30s <target>"
"nmap --defeat-rst-ratelimit <target>"
"nmap -sS -g 53 <target>"
"nmap -sS --randomize-hosts <target>"
"nmap -sS --top-ports 100 <target>"
"nmap -sS -F <target>"
"nmap -sS -p- <target>"
"nmap -sS -T0 <target>"
"nmap -sS -T1 <target>"
"nmap -sS -T2 <target>"
"nmap -sS -T3 <target>"
"nmap -sS -T4 <target>"
"nmap -sS -T5 <target>"
"masscan <target> -p1-65535 --rate=1000"
"nmap -sY <target>"
"nmap -sZ <target>"
)

enum_commands=(
"snmpwalk -v2c -c public <target>"
"smbclient -L //<target> -N"
"nmap --script smtp-enum-users <target>"
"nmap --script ssh-auth-methods <target>"
"nmap --script mysql-info <target>"
"nmap --script rdp-enum-encryption <target>"
"curl -I http://<target>"
"nmap --script http-methods <target>"
"whatweb <target>"
"echo | openssl s_client -connect <target>:443"
"nmap --script telnet-encryption <target>"
"nmap --script ftp-anon <target>"
"showmount -e <target>"
"rpcinfo <target>"
"nmap --script ldap-rootdse <target>"
"nbtscan <target>"
"nmap --script ms-sql-info <target>"
"nmap --script oracle-sid-brute <target>"
"mongo --host <target> --eval 'db.stats()'"
"redis-cli -h <target> INFO"
"curl http://<target>:9200"
"curl http://<target>:5984"
"curl http://<target>:2375/version"
"kubectl get pods --server=<target>"
"curl http://<target>:8080"
"curl http://<target>:8080/manager/html"
"cadaver http://<target>/webdav/"
"dig axfr @<target>"
"ike-scan <target>"
"firewalk -S 1-65535 -N 1 <target>"
"snmpwalk -v2c -c public -Cc -c <target>"
"nmap --script tftp-enum <target>"
"nmap --script pop3-capabilities <target>"
"nmap --script imap-capabilities <target>"
"nmap --script kerberos-enum-users <target>"
"enum4linux <target>"
"nmap -6 -sT <target>"
"nmap --script dns-nsid <target>"
"nmap --script http-saml-discovery <target>"
"git ls-remote http://<target>/.git"
"svn info http://<target>/svn/"
"curl http://<target>/.env"
"wpscan --url http://<target>"
"joomscan -u http://<target>"
"droopescan scan drupal -u http://<target>"
"curl http://<target>/phpmyadmin/"
"curl http://<target>/metadata"
"onesixtyone <target>"
"hydra -s 6379 -V -t 4 -l test -P pass.txt <target> redis"
)

echo "Choose a category:"
echo "[1] Scans"
echo "[2] Enumerations"
read -p "Enter category number: " category

if [[ $category -eq 1 ]]; then
  echo "Available Scan Options:"
  for i in "${!scan_commands[@]}"; do
    echo "[$((i+1))] ${scan_commands[$i]}"
  done

  read -p "Enter scan number: " option
  read -p "Enter target IP: " target

  if [[ $option -ge 1 && $option -le ${#scan_commands[@]} ]]; then
    cmd=${scan_commands[$((option-1))]}
    cmd=${cmd//"<target>"/$target}
    echo "Running scan: $cmd"
    eval $cmd
  else
    echo "Invalid scan option"
  fi

elif [[ $category -eq 2 ]]; then
  echo "Available Enumeration Options:"
  for i in "${!enum_commands[@]}"; do
    echo "[$((i+1))] ${enum_commands[$i]}"
  done

  read -p "Enter enumeration number: " option
  read -p "Enter target IP: " target

  if [[ $option -ge 1 && $option -le ${#enum_commands[@]} ]]; then
    cmd=${enum_commands[$((option-1))]}
    cmd=${cmd//"<target>"/$target}
    echo "Running enumeration: $cmd"
    eval $cmd
  else
    echo "Invalid enumeration option"
  fi

else
  echo "Invalid category selection."
fi
