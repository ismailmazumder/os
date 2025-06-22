# nasm -f bin main.asm -o bootloader.bin
# sudo dd if=bootloader.bin of=/dev/sdX bs=512 count=1
# sudo dd if=image.raw of=/dev/sdX bs=512 seek=1
# sudo qemu-system-x86_64 -fda /dev/sdX
# nasm -f bin main.asm -o bootloader.bin
# sudo dd if=bootloader.bin of=/dev/sdc1 bs=512 count=1
# sudo dd if=image.raw of=/dev/sdc1 bs=512 seek=1
# sudo qemu-system-x86_64 -fda /dev/sdc1
nasm -f bin main.asm -o main.bin
qemu-system-x86_64 main.bin