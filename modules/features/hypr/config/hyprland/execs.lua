
hl.on('hyprland.start', function ()
    hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')
    hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3"')

    hl.exec_cmd('bash -c "$HOME/.config/hypr/scripts/startqs.sh"')
    hl.exec_cmd('bash - c "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"')
    hl.exec_cmd('awww-daemon')
	hl.exec_cmd('discord')
	hl.exec_cmd('flatpak run org.jeffvli.feishin')
	hl.exec_cmd('fcitx5 -d')
	hl.exec_cmd('/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1')
end)
