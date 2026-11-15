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