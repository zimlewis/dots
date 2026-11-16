{ ... }: {
	flake.modules.homeManager.librewolf = { ... }: {
		programs.librewolf.settings = {
			"privacy.resistFingerprinting" = false;
			# Master switch for clearing on shutdown
			"privacy.sanitize.sanitizeOnShutdown" = false;

			# Belt and braces: individual items, in case something re-enables the master switch
			"privacy.clearOnShutdown.cookies" = false;
			"privacy.clearOnShutdown.history" = false;
			"privacy.clearOnShutdown.sessions" = false;
			"privacy.clearOnShutdown.offlineApps" = false;
			"privacy.clearOnShutdown.cache" = false;
			"privacy.clearOnShutdown.formdata" = false;
			"privacy.clearOnShutdown.downloads" = false;

			# Newer Firefox versions (128+) use a second set of names, so set these too
			"privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
			"privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = false;
			"privacy.clearOnShutdown_v2.cache" = false;

			# Keep cookies for the full session lifetime (0 = normal expiry)
			"network.cookie.lifetimePolicy" = 0;
		};
	};
	flake.modules.nixos.librewolf = { pkgs, ... }: {
		environment.systemPackages = [
			pkgs.librewolf
		];
	};
}