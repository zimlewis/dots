{ inputs, ... }: {
	flake.modules.homeManager.stylix = { ... }: {
	};

	flake.modules.nixos.stylix = { pkgs, ... }: {
		imports = [
			inputs.stylix.nixosModules.stylix
		];
		stylix = {
			enable = true;
			polarity = "dark";
			base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
			fonts = {
				sizes = {
					applications = 10;
					desktop = 10;
				};
				monospace = {
					name = "CaskaydiaMono Nerd Font";
					package = pkgs.nerd-fonts.caskaydia-mono;
				};
				sansSerif = {
					name = "CaskaydiaMono Nerd Font";
					package = pkgs.nerd-fonts.caskaydia-mono;
				};
			};
		};

		xdg.portal = {
			enable = true;
			extraPortals = [
				pkgs.xdg-desktop-portal-gtk
			];
		};

		programs.dconf.enable = true;
	};
}