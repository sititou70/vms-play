#/bin/bash
set -eu
cd $(dirname $0)

# main
cd ..
if [ $(whoami) != "root" ]; then
  sudo $0
  exit
fi

## check commands
if ! type virsh >/dev/null; then
  echo "virsh not found !!!"
  exit 1
fi

echo done
