#!/bin/sh
# FreeIPA client setup
# Add nameserver for DNS
echo "Por favor ingrese el nameserver:"
read ns
nmcli con mod awk(nmcli con show) +ipv4.dns $ns

# Setup FQDN
# Check if the OS is Linux
if [[ "$OSTYPE" == "linux"* ]]; then
  echo "Por favor ingrese el FQDN:"
  read fqdn
  hostnamectl set-hostname $fqdn

  sudo systemctl restart NetworkManager.service
  if [ $? -ne 0 ]; then
    sudo nmcli connection reload
  fi
  #OR
  #nmcli con up <CON>

  hostname -f

# Setup hostname on OSX hosts
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Por favor ingrese el hostname:"
  read hn
  scutil --set ComputerName $hn
  scutil --set HostName $hn
fi

# Work in progress