## setup

```sh
sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients aria2
```

### qemu user setting

```sh
sudo vim /etc/libvirt/qemu.conf
```

```text
user = "root"
group = "root"
```

```sh
sudo systemctl restart libvirtd
```

## base machine

### enable serial console

`sudo vim /etc/default/grub`

```text
GRUB_CMDLINE_LINUX="console=tty0 console=ttyS0"
```

`sudo grub-mkconfig -o /boot/grub/grub.cfg`

### enable network

`sudo vim /etc/netplan/50-cloud-init.yaml`

```text
network:
    ethernets:
        ens3:
            dhcp4: true
            match:
                name: ens*
    version: 2
```
