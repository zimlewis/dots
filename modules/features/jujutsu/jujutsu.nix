{ ... }: {
	flake.modules.homeManager.jujutsu = { ... }: {
		programs.jujutsu = {
			enable = true;

			settings = {
				user.email = "z1ml3w1s123@gmail.com";
				user.name = "zimlewis";
				ui.default-command = "log";
			};
		};
	};

	flake.modules.nixos.jujutsu = { pkgs, ... }: {
		environment.systemPackages = [
			pkgs.jujutsu
			pkgs.git
			pkgs.lazyjj
		];
	};
}