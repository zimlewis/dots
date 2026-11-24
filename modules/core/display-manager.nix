{ ... }: {
	flake.nixosModules.displayManager = { pkgs, config, ... }: let
		swayConfig = pkgs.writeText "greetd-sway-config" ''
			output * scale 1
			exec "${config.services.displayManager.regreet.package}/bin/regreet; ${pkgs.sway}/bin/swaymsg exit"
		'';
	in {
		services.greetd = {
			enable = true;
			settings = {
				default_session = {
					command = "${pkgs.sway}/bin/sway --config ${swayConfig}";
					user = "greeter";
				};
			};
		};

		services.displayManager.regreet = {
			enable = true;
		};
	};
}
