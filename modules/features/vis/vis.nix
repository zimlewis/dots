{ ... }: {
	flake.modules.homeManager.vis = { ... }: {
		xdg.configFile."vis".source = ./config;
	};

	flake.modules.nixos.vis = { pkgs, ... }: {
		environment.systemPackages = let 
			lua = pkgs.lua5_5;
			luaEnv = lua.withPackages (ps: [ ps.cjson ]);
			vis' = pkgs.vis.overrideAttrs (old: {
				nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.makeWrapper ];
				postFixup = (old.postFixup or "") + ''
					wrapProgram $out/bin/vis \
						--prefix LUA_CPATH ';' "${luaEnv}/lib/lua/${lua.luaversion}/?.so" \
						--prefix LUA_PATH  ';' "${luaEnv}/share/lua/${lua.luaversion}/?.lua"
				'';
			});
		in [
			vis'
			pkgs.file
		];
	};
}