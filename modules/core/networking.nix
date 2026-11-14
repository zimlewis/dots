{ ... }: {
	flake.nixosModules.networking = {
		services.resolved = {
			enable = true;
			settings.Resolve= {
				DNSSEC = "true";
				Domains = [ "~." ];
				FallbackDNS = [
					"8.8.8.8"
					"8.8.4.4"
					"2001:4860:4860::8888"
					"2001:4860:4860::8844"
				];
				DNSOverTLS = "true";
			};
		};
		networking = {
			hostName = "nixos";
			networkmanager = {
				enable = true;
			};
			nameservers = [
				"8.8.8.8"
				"8.8.4.4"
				"2001:4860:4860::8888"
				"2001:4860:4860::8844"
			];
		};
	};
}


