#/bin/bash
set -eu
cd $(dirname $0)

# main
cd ..
if [ $(whoami) != "root" ]; then
  sudo $0
  exit
fi

cd definitions

## ensure ws
[ ! -e TMP_ws ] && mkdir TMP_ws

## pool
if ! virsh pool-list --all | grep vms-play >/dev/null; then
  virsh pool-define pool.xml
  virsh pool-start vms-play
  virsh pool-autostart vms-play
fi

## volumes
for number in $(seq 3); do
  if ! virsh vol-list --pool vms-play | grep "vms-play${number}.qcow2" >/dev/null; then
    sed -e "s/__NUMBER__/$number/g" <volume.xml >TMP_ws/volume${number}.xml
    virsh vol-create --pool vms-play TMP_ws/volume${number}.xml
  fi
done

## net
if ! virsh net-list --all | grep vms-play >/dev/null; then
  virsh net-define net.xml
  virsh net-start --network vms-play
  virsh net-autostart --network vms-play
fi

echo done
