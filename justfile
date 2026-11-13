# Build and then switch to the new flake
rebuild flake:
	sudo nixos-rebuild switch --flake {{flake}} &> ./nix.log
	nh clean


# Build a virtural machine of the flake
vm flake:
	- rm nixos.qcow2
	sudo nixos-rebuild build-vm --flake {{flake}} 2> ./nix.log

[private]
show:
	sudo nix flake show --all-systems
