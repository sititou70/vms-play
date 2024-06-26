#/bin/bash
set -eu
cd $(dirname $0)

# main
cd ..
if [ $(whoami) != "root" ]; then
  sudo $0
  exit
fi

## download
[ ! -e TMP_assets ] && mkdir TMP_assets
cd TMP_assets

aria2c -x5 https://releases.ubuntu.com/24.04/ubuntu-24.04-live-server-amd64.iso

echo done
