{ self, config, ... }: {
	flake.homeUsers.zimlewis = {
		imports = with self.modules.homeManager; [
			vis
			hypr
			alacritty
			jujutsu
			tmux
			yazi
			extra
			starship
			quickshell
		];

		home.stateVersion = "26.05";
	};
}