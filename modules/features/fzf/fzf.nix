{ ... }: {
	flake.modules.homeManager.fzf = { ... }: {
	};

	flake.modules.nixos.fzf = { pkgs, ... }: {
		environment.variables.FZF_DEFAULT_OPTS = "--bind 'esc:disable-search+unbind(esc)+rebind(j,k,g,G,q,i,/)' --bind 'j:down,k:up,g:first,G:last' --bind 'i:enable-search+unbind(j,k,g,G,q,i,/)+rebind(esc)' --bind '/:enable-search+unbind(j,k,g,G,q,i,/)+rebind(esc)' --bind 'q:abort' --bind 'start:unbind(j,k,g,G,q,i,/)'";
		environment.systemPackages = [
			pkgs.fzf
		];
	};
}