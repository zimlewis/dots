{ self, config, ... }: {
	flake.nixosModules.features = {
		imports = with self.modules.nixos; [
			vis
			hypr
			alacritty
			yazi
			tmux
			jujutsu
			extra
			starship
			quickshell
		];
	};
}