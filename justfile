# Build and then switch to the new flake
rebuild configuration clean="false" flake=".":
	sudo nixos-rebuild switch --flake {{flake}}#{{configuration}} 2>&1 | tee ./nix.log
	if {{ clean }} == "true"; then nh clean all; fi


# Build a virtural machine of the flake
vm configuration flake=".":
	- rm nixos.qcow2
	sudo nixos-rebuild build-vm --flake {{flake}}#{{configuration}} 2>&1 | tee ./nix.log

[private]
show:
	sudo nix flake show --all-systems
