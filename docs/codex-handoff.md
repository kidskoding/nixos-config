# Quickshell handoff

The user requested a complete Noctalia shell replacement, then asked to batch
work and minimize usage. Implementation lives in home-manager/programs/quickshell.
See its README.md for controls, shortcuts, verification, and activation.

Implemented: niri event-driven workspaces; live PipeWire volume and microphone
controls; native Wi-Fi status and connection controls; brightness polling and
slider; UPower battery and details; MPRIS media with scrolling title and controls;
tray; clock/calendar; red power menu with confirmation; native app launcher and
clipboard picker; native notifications/history/DND; volume/brightness OSD.
NixOS launcher glyph is ``, not Arch. Volume blue, Wi-Fi lime, date/time yellow.
Terminess text and independently sized Symbols Nerd Font icons are retained.

Locking uses swaylock with NixOS PAM; hypridle handles idle/sleep locking.
Noctalia files, imports, and both flake inputs have now been removed.
The replacement login greeter is native Quickshell with Greetd authentication,
hosted by Cage; greeter.nix wires the existing niri-session executable.
Its authentication state transitions are fixture-tested; real login is not tested.
Wallpaper remains with awww. Avatar moved to quickshell/avatar.png.

Latest polish: consistent panel surfaces, focus/hover feedback, tooltips,
cleaner launcher rows/search, explicit Wi-Fi disconnect, and custom tray menu.
Centered purple media includes artwork, timeline, elapsed/total, transport,
shuffle/repeat, and multiple-player selection. Hidden without an MPRIS player.
Media render checked at intended compact size; fixture tests cover position,
unsupported duration, and removal. Tray API checked; real menu test had no
available menu, so live tray menu interaction remains unverified.

No NixOS rebuild was run; the user owns rebuild and session restart. Do not kill
Noctalia in the current session. Dev script sets QS_DEV=1 to avoid taking over
its notification daemon. New startup takes effect on the next login after rebuild.

Verification: NixOS toplevel derivation evaluates; generated shell builds;
qs-test.sh passes seven JS tests plus power-menu, launcher/session, greeter, and media smoke tests;
live readings match wpctl/nmcli/brightnessctl; native notification delivery tested
on a private D-Bus session. Workspace switching and restoration verified live.
Lock/logout/suspend/reboot/shutdown were not executed during verification.

Conventions: no comments in QML/Nix/shell additions; two-space indent;
alejandra for Nix; Conventional Commits with no co-author attribution.
The user's .gitignore change must not be included in implementation commits.

Latest verification: all qs-test.sh checks pass; full NixOS evaluation and
replacement greeter dependency build pass. No rebuild or session activation run.
