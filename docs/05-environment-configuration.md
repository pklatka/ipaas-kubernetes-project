# Environment Configuration

## Installing Docker

All the instructions were created from https://docs.docker.com/engine/install/

 - Linux installation
```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## Installing kwok

All the instructions were created from https://kwok.sigs.k8s.io/docs/user/installation/

- Homebrew  
```brew install kwok```

- Binary releases
```bash
# KWOK repository
KWOK_REPO=kubernetes-sigs/kwok
# Get latest
KWOK_LATEST_RELEASE=$(curl "https://api.github.com/repos/${KWOK_REPO}/releases/latest" | jq -r '.tag_name')

wget -O kwokctl -c "https://github.com/${KWOK_REPO}/releases/download/${KWOK_LATEST_RELEASE}/kwokctl-$(go env GOOS)-$(go env GOARCH)"
chmod +x kwokctl
sudo mv kwokctl /usr/local/bin/kwokctl

wget -O kwok -c "https://github.com/${KWOK_REPO}/releases/download/${KWOK_LATEST_RELEASE}/kwok-$(go env GOOS)-$(go env GOARCH)"
chmod +x kwok
sudo mv kwok /usr/local/bin/kwok
```