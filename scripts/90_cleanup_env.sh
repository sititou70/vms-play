#/bin/bash
set -eu
cd $(dirname $0)

# main
cd ..
if [ $(whoami) != "root" ]; then
  sudo $0
  exit
fi

## net
if virsh net-list --all | grep vms-play >/dev/null; then
  virsh net-destroy --network vms-play
  virsh net-undefine --network vms-play
fi

## volumes
if virsh pool-list --all | grep vms-play >/dev/null; then
  for number in $(seq 3); do
    if virsh vol-list --pool vms-play | grep "vms-play${number}.qcow2" >/dev/null; then
      virsh vol-delete --pool vms-play --vol "vms-play${number}.qcow2"
    fi
  done
fi

## pool
if virsh pool-list --all | grep vms-play >/dev/null; then
  sudo virsh pool-destroy --pool vms-play
  sudo virsh pool-undefine --pool vms-play
fi

echo done
