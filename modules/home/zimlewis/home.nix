{ self, config, ... }: {
	flake.modules.homeManager.zimlewis = {
		imports = with self.modules.homeManager; [
			vis
			hypr
			alacritty
			jujutsu
			tmux
			yazi
			extra
		];

		home.stateVersion = "26.05";
	};
}