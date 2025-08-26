#!/bin/bash
# NodeAxe Bitcoin Node Setup Script for Ubuntu 22.04/24.04
# Installs Bitcoin Core, LND, firewall, fail2ban, unattended upgrades, Tor hidden service, and WireGuard VPN

# Update and install basic dependencies
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential libtool autotools-dev automake pkg-config bsdmainutils python3 libevent-dev libboost-system-dev libboost-filesystem-dev libboost-test-dev libboost-thread-dev libdb4.8-dev libdb4.8++-dev libminiupnpc-dev libzmq3-dev libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libqrencode-dev curl gnupg apt-transport-https software-properties-common

# Install Berkeley DB 4.8 for Bitcoin Core wallet
wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz
tar -xvf db-4.8.30.NC.tar.gz
cd db-4.8.30.NC/build_unix
../dist/configure --enable-cxx --disable-shared --with-pic --prefix=/usr/local
make && sudo make install
cd ../..

# Install Bitcoin Core
wget https://bitcoincore.org/bin/bitcoin-core-25.1/bitcoin-25.1-x86_64-linux-gnu.tar.gz
tar -xvf bitcoin-25.1-x86_64-linux-gnu.tar.gz
sudo install -m 0755 -o root -g root -t /usr/local/bin bitcoin-25.1/bin/*

# Configure Bitcoin
mkdir -p ~/.bitcoin
cat <<EOF > ~/.bitcoin/bitcoin.conf
server=1
rpcuser=nodeaxerpc
rpcpassword=NodeAxe2025RPC!
rpcallowip=127.0.0.1
txindex=1
daemon=1
onlynet=onion
EOF
bitcoind -daemon

# Install LND
sudo apt install -y lnd
lncli create  # Follow prompts to create a wallet (note seed phrase)

# Set up firewall, fail2ban, and unattended upgrades
sudo apt install -y ufw fail2ban unattended-upgrades
sudo ufw allow 8333/tcp  # Bitcoin P2P
sudo ufw allow 9735/tcp  # LND default port
sudo ufw allow 22/tcp    # SSH
sudo ufw enable
sudo systemctl enable fail2ban
sudo dpkg-reconfigure --priority=low unattended-upgrades  # Enable automatic updates

# Configure Tor hidden service
sudo apt install -y tor
sudo systemctl enable tor
sudo mkdir -p /var/lib/tor/hidden_service_bitcoin
sudo sh -c 'echo "HiddenServiceDir /var/lib/tor/hidden_service_bitcoin" >> /etc/tor/torrc'
sudo sh -c 'echo "HiddenServicePort 8333 127.0.0.1:8333" >> /etc/tor/torrc'
sudo sh -c 'echo "HiddenServicePort 9735 127.0.0.1:9735" >> /etc/tor/torrc'
sudo systemctl restart tor
sleep 10  # Wait for Tor to generate keys
HIDDEN_SERVICE=$(sudo cat /var/lib/tor/hidden_service_bitcoin/hostname)
echo "NodeAxe Tor hidden service address: http://$HIDDEN_SERVICE"  # Share for mobile wallets

# Configure WireGuard VPN
sudo apt install -y wireguard
sudo mkdir -p /etc/wireguard
sudo bash -c 'umask 077; wg genkey | tee /etc/wireguard/privatekey | wg pubkey > /etc/wireguard/publickey'
PRIVATE_KEY=$(cat /etc/wireguard/privatekey)
PUBLIC_KEY=$(cat /etc/wireguard/publickey)
cat <<EOF > /etc/wireguard/wg0.conf
[Interface]
PrivateKey = $PRIVATE_KEY
Address = 10.0.0.2/24
DNS = 1.1.1.1

[Peer]
PublicKey = YOUR_PEER_PUBLIC_KEY  # Replace with VPN server public key
AllowedIPs = 0.0.0.0/0
Endpoint = YOUR_VPN_SERVER_IP:51820  # Replace with VPN server IP and port
PersistentKeepalive = 25
EOF
sudo wg-quick up wg0
sudo systemctl enable wg-quick@wg0

# Generate QR code for WireGuard config
sudo apt install -y qrencode
sudo bash -c 'wg show > /tmp/wg_config.txt'
sudo qrencode -o /tmp/wg_qr.png -t PNG < /tmp/wg_config.txt
echo "NodeAxe WireGuard QR code saved as /tmp/wg_qr.png. Scan with your phone's WireGuard app."

# Finalize and sync
sudo hostnamectl set-hostname nodeaxe-0001.local
echo "NodeAxe installation complete. Bitcoin sync (~1-2 days). Check status with 'bitcoin-cli getblockchaininfo'"
