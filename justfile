# Build and then switch to the new flake
rebuild configuration flake=".":
	sudo nixos-rebuild switch --flake {{flake}}#{{configuration}} 2>&1 | tee ./nix.log
	nh clean all


# Build a virtural machine of the flake
vm configuration flake=".":
	- rm nixos.qcow2
	sudo nixos-rebuild build-vm --flake {{flake}}#{{configuration}} 2>&1 | tee ./nix.log

[private]
show:
	sudo nix flake show --all-systems
