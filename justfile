
rebuild flake:
	sudo nixos-rebuild switch --flake {{flake}} 2> ./nix.log

vm flake:
	- rm nixos.qcow2
	sudo nixos-rebuild build-vm --flake {{flake}} 2> ./nix.log

[private]
show:
	sudo nix flake show --all-systems
