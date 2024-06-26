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

## create
for number in $(seq 3); do
  if ! virsh list | grep "vms-play${number}" >/dev/null; then
    sed -e "s/__NUMBER__/$number/g" <vm.xml >TMP_ws/vm${number}.xml
    virsh create TMP_ws/vm${number}.xml
  fi
done

echo done
