{ inputs, ... }: {
	imports = [
		inputs.home-manager.flakeModules.home-manager
	];

	systems = [
		"x86_64-linux"
		"aarch64-linux"
	];

	perSystem = { config, self', inputs', pkgs, system, ... }: {
		packages.caskaydia-mono = pkgs.nerd-fonts.caskaydia-mono;


		packages.hello = pkgs.hello;
		packages.hyprland = pkgs.hyprland;
		packages.file = pkgs.file;
		packages.vis = pkgs.vis;
		packages.alacritty = pkgs.alacritty;
		packages.rofi = pkgs.rofi;
		packages.starship = pkgs.starship;
		packages.git = pkgs.git;
		packages.jujutsu = pkgs.jujutsu;
		packages.tmux = pkgs.tmux;
		packages.just = pkgs.just;
		packages.lazyjj = pkgs.lazyjj;
		packages.tree = pkgs.tree;
		packages.fzf = pkgs.fzf;
		packages.nautilus = pkgs.nautilus;
		packages.imv = pkgs.imv;
		packages.mpv = pkgs.mpv;


		packages.zen-browser = inputs'.zen-browser.packages.default;
	};
}