build_artifacts := kernel/build/kernel-x86_64 boot/grub/grub.cfg

.PHONY: all clean run test

all: clean disk.iso

run: clean disk.iso
	@qemu-system-x86_64 disk.iso

test: clean
	@$(MAKE) -C kernel test

disk.iso: build
	@grub-mkrescue -o disk.iso build/

build: $(build_artifacts)
	@mkdir build
	@cp -r boot build/boot
	@cp kernel/build/kernel-x86_64 build/boot/kernel

kernel/build/kernel-x86_64:
	@$(MAKE) -C kernel

clean:
	-@rm disk.iso > /dev/null
	-@rm -r build/ > /dev/null
	-@$(MAKE) -C kernel clean > /dev/null
