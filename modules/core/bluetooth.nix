{ ... }: {
	flake.nixosModules.bluetooth = { ... }: {
		hardware.bluetooth = {
			enable = true;
			powerOnBoot = true;
		};

		services = {
			pipewire = {
				enable = true;
				wireplumber.enable = true;
			};
		};
	};
}
