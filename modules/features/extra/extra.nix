# Extra features that don't need to be cared for much
{ moduleWithSystem, inputs, ... }: {
	flake.modules.homeManager.extra = { pkgs, ... }: {
		gtk = {
			enable = true;
			iconTheme = {
				name = "Fluent";
				package = pkgs.fluent-icon-theme;
			};
		};
	};

	flake.modules.nixos.extra = moduleWithSystem({ pkgs, self', ... }: {
		programs.bash = {
			shellAliases = {
				z = "zoxide";
				ls = "eza -lh --group-directories-first --icons=auto";
				lsa = "ls -la";
			};
		};
		programs.zoxide.enable = true;

		environment.systemPackages = [
			pkgs.nautilus
			pkgs.tree
			pkgs.just
			pkgs.imv
			pkgs.mpv
			pkgs.lf
			pkgs.nnn
			pkgs.nh
			pkgs.zoxide
			pkgs.wiremix
			pkgs.htop
			pkgs.bat
			pkgs.fastfetch
			pkgs.eza
			pkgs.wl-clipboard
			pkgs.qutebrowser
			pkgs.proton-vpn-cli
			pkgs.woomer
			pkgs.librewolf
			pkgs.chromium

			pkgs.fluent-icon-theme
			pkgs.gnome-disk-utility
			pkgs.baobab
		];

		environment.pathsToLink = [
			"/share/icons"
			"/share/pixmaps"
		];
	});


	perSystem = { config, self', inputs', pkgs, system, ... }: {
		# packages.zen-browser = inputs'.zen-browser.packages.default;
		# packages.limusic = inputs'.limusic.packages.default;
	};
}
