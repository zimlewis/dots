{ self, config, ... }: {
	flake.homeUsers.zimlewis = {
		imports = with self.modules.homeManager; [
			vis
			hypr
			alacritty
			jujutsu
			tmux
			yazi
			starship
			quickshell
			stylix
			librewolf
			fzf
			television

			extra
		];

		home.stateVersion = "26.05";
	};
}