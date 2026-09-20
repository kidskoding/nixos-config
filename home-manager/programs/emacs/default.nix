{ config, pkgs, ... }:

let
  gitColors = config.programs.git.settings.color.fileStatus;
    emacs = pkgs.emacs-unstable-pgtk.pkgs.withPackages (
    epkgs: with epkgs; [ treesit-grammars.with-all-grammars ]
  );
in

{
  home.packages = [ emacs pkgs.zathura ];

  services.emacs = {
    enable = true;
    package = emacs;
    socketActivation.enable = true;
    startWithUserSession = true;
  };

  systemd.user.services.emacs.Service = {
    Environment = [ "COLORTERM=truecolor" ];
    KillMode = "mixed";
    TimeoutStopSec = 10;
  };

  home.sessionVariables = {
    EDITOR = "emacsclient -nw";
    VISUAL = "emacsclient -nw";
  };

  xdg.configFile."doom" = {
    source = ./doom.d;
    recursive = true;
  };

  # Generated from the palette declared in git.nix, alongside the Doom config.
  xdg.configFile."doom/git-colors.el".text = ''
    (custom-set-faces!
      '(diff-hl-insert :foreground "${gitColors.added}" :background "${gitColors.added}")
      '(diff-hl-delete :foreground "${gitColors.removed}" :background "${gitColors.removed}")
      '(diff-hl-change :foreground "${gitColors.modified}" :background "${gitColors.modified}")
      '(diff-hl-dired-insert :foreground "${gitColors.added}")
      '(diff-hl-dired-delete :foreground "${gitColors.removed}")
      '(diff-hl-dired-change :foreground "${gitColors.modified}")
      '(diff-hl-dired-unknown :foreground "${gitColors.untracked}")
      '(diff-hl-dired-ignored :foreground "${gitColors.ignored}")
      '(magit-diff-added :foreground "${gitColors.added}")
      '(magit-diff-added-highlight :foreground "${gitColors.added}")
      '(magit-diff-removed :foreground "${gitColors.removed}")
      '(magit-diff-removed-highlight :foreground "${gitColors.removed}"))
  '';
}
