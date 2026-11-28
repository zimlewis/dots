{ self, config, ... }: {
	flake.nixosModules.features = {
		imports = with self.modules.nixos; [
			vis
			hypr
			alacritty
			yazi
			tmux
			jujutsu
			starship
			quickshell
			stylix
			librewolf
			fzf
			television
			lf
			vencord
			zed
			sonora

			extra
		];
	};
}
