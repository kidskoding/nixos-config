{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.desktop.home-manager.sharedModules = [self.homeModules.desktop];

  flake.homeModules.desktop = {pkgs, ...}: let
    system = pkgs.stdenv.hostPlatform.system;
    craft = name:
      pkgs.symlinkJoin {
        name = "${name}-dbus";
        paths = [inputs.artcraft-nix.packages.${system}.${name}];
        nativeBuildInputs = [pkgs.makeWrapper];
        postBuild = "wrapProgram $out/bin/${name} --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath [pkgs.dbus]}";
      };
  in {
    my.caches = [
      # llm-agents (numtide) cache
      {
        url = "https://cache.numtide.com";
        key = "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=";
      }
      # artcraft cache
      {
        url = "https://applicative-systems.cachix.org";
        key = "applicative-systems.cachix.org-1:ND41hRBh0ST2abuI/oee3yWVf3n0FsAftyJJ/Tb7KDE=";
      }
    ];

    programs.mcp.servers = {
      deckcraft = {
        command = "deckcraft-cli";
        args = ["mcp"];
      };

      filmcraft = {
        command = "filmcraft-cli";
        args = ["mcp"];
      };

      gridcraft = {
        command = "gridcraft-cli";
        args = ["mcp"];
      };

      pdfcraft = {
        command = "pdfcraft-cli";
        args = ["mcp" "--compact"];
      };

      soundcraft = {
        command = "soundcraft-cli";
        args = ["mcp"];
      };

      wordcraft = {
        command = "wordcraft-cli";
        args = ["mcp"];
      };
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
        "inode/directory" = "org.gnome.Nautilus.desktop";
        "image/png" = "qimgv.desktop";
        "image/jpeg" = "qimgv.desktop";
        "image/gif" = "qimgv.desktop";
        "image/webp" = "qimgv.desktop";
        "image/bmp" = "qimgv.desktop";
      };
    };

    home.packages = with pkgs; [
      # fonts
      nerd-fonts.symbols-only
      symbola
      corefonts

      # applications
      anki
      discord
      doxygen_gui
      libreoffice
      obsidian
      popsicle
      ruffle
      slack
      spotify
      teams-for-linux
      zathura
      zoom-us

      inputs.claude-desktop.packages.${system}.claude-desktop-with-fhs
      inputs.llm-agents.packages.${system}.orca # a wonderful ade for working with many coding agents!
      inputs.llm-agents.packages.${system}.hermes-desktop # hermes-agent desktop!

      # artcraft apps
      # inputs.artcraft-nix.packages.${system}.cadcraft     # autocad clone
      (craft "deckcraft") # powerpoint clone
      # inputs.artcraft-nix.packages.${system}.designcraft  # indesign clone
      # inputs.artcraft-nix.packages.${system}.effectcraft  # after effects clone
      (craft "filmcraft") # premiere pro clone
      (craft "gridcraft") # excel clone
      # inputs.artcraft-nix.packages.${system}.lightcraft   # lightroom clone
      (craft "pdfcraft") # acrobat clone
      # inputs.artcraft-nix.packages.${system}.photocraft   # photoshop clone
      (craft "soundcraft") # pro tools clone
      # inputs.artcraft-nix.packages.${system}.vectorcraft  # illustrator clone
      (craft "wordcraft") # word clone

      inputs.cromite.packages.${system}.default
    ];
  };
}
