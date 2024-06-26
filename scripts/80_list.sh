#/bin/bash
set -eu
cd $(dirname $0)

# main
cd ..
if [ $(whoami) != "root" ]; then
  sudo $0
  exit
fi

echo vm
virsh list --all

echo pools
virsh pool-list --all --details

echo volumes
virsh vol-list --pool vms-play --details

echo networks
virsh net-list --all

echo done
