#/bin/bash
set -eu
cd $(dirname $0)

# main
cd ..
if [ $(whoami) != "root" ]; then
  sudo $0
  exit
fi

## destroy
for number in $(seq 3); do
  if virsh list | grep "vms-play${number}" >/dev/null; then
    virsh destroy --domain "vms-play${number}"
  fi
done

echo done
