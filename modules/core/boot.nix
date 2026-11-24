{ ... }: {
	flake.nixosModules.bootloader = { ... }: {
		boot = {
			#kernelParams = [
			#	"quiet"
			#];
			loader = {
				systemd-boot.enable = true;
				efi.canTouchEfiVariables = true;
				timeout = null;
				systemd-boot.extraEntries."windows-clover.conf" = ''
title Windows (via Clover)
efi   /EFI/CLOVER/CLOVERX64.efi
				'';
			};
		};
	};
}