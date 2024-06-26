#/bin/bash
set -eu
cd $(dirname $0)

# main
cd ..
if [ $(whoami) != "root" ]; then
  sudo $0
  exit
fi

## boot base machine
[ ! -e TMP_pool ] && mkdir TMP_pool
cd TMP_pool

[ ! -e base.qcow2 ] && qemu-img create -f qcow2 base.qcow2 16G

qemu-system-x86_64 \
  -enable-kvm \
  -smp 4 \
  -m 8G \
  -cdrom ../TMP_assets/*.iso \
  base.qcow2

echo done
