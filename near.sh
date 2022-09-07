#/usr/bin/bash

sudo apt update && sudo apt upgrade -y

curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -  
sudo apt install build-essential nodejs
PATH="$PATH"
sudo apt install -y git binutils-dev libcurl4-openssl-dev zlib1g-dev libdw-dev libiberty-dev cmake gcc g++ python docker.io protobuf-compiler libssl-dev pkg-config llvm cargo
sudo apt install -y clang build-essential make
sudo apt install -y curl jq
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -  
sudo apt install -y nodejs
PATH="$PATH"
node -v && npm -v
sudo npm install -g near-cli
export NEAR_ENV=shardnet
echo 'export NEAR_ENV=shardnet' >> ~/.bashrc
sudo apt install -y python3-pip
USER_BASE_BIN=$(python3 -m site --user-base)/bin
export PATH="$USER_BASE_BIN:$PATH"
sudo apt install curl build-essential gcc make -y
echo "Вибираємо -> 1) Proceed with installation (default)"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.profile
source ~/.cargo/env
cd ~
git clone https://github.com/near/nearcore
cd nearcore
git fetch
git checkout $checkuot
cargo build -p neard --release --features shardnet
./target/release/neard --home ~/.near init --chain-id shardnet --download-genesis
rm ~/.near/config.json
wget -O ~/.near/config.json https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/shardnet/config.json
sudo apt-get install awscli -y
echo "[Unit]
Description=NEARd Daemon Service
[Service]
Type=simple
User=root
WorkingDirectory=/root/.near
ExecStart=/root/nearcore/target/release/neard run
Restart=on-failure
RestartSec=30
KillSignal=SIGINT
TimeoutStopSec=45
KillMode=mixed
[Install]
WantedBy=multi-user.target"  | tee -a /etc/systemd/system/neard.service
sudo systemctl daemon-reload
sudo systemctl enable neard
sudo systemctl restart neard
