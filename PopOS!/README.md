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