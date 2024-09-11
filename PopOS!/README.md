# GRUB

1. sudo apt install grub-efi grub2-common grub-customizer
2. sudo grub-install
3. (No error reported)
4. sudo cp /boot/grub/x86_64-efi/grub.efi /boot/efi/EFI/pop/grubx64.efi
5. grub-customizer
6. (Cambiar entorno)
7. (OUTPUT_FILE: /boot/efi/EFI/pop/grub.cfg)
8. (Gardar configuración)
9. (Aplicar)

# Ubuntu / PopOS 21.04 - Screen blinking
https://askubuntu.com/questions/1362829/ubuntu-popos-21-04-screen-blinking

**Solución 1:**
1. `nano /etc/defaults/grub`
2. `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash i915.enable_psr=0"`
3. `sudo update-grub`
    
**Solución 2:**
>Nota: Para personas que no usan grub

1. `sudo echo "options i915 enable_psr=0" >> /etc/modprobe.d/i915.conf`
2. `sudo update-initramfs -c -k $(uname -r)`
3. `reboot`

