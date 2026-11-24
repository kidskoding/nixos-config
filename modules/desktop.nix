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
        "inode/directory" = "yazi.desktop";
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

      inputs.llm-agents.packages.${system}.claude-desktop

      # orca: a wonderful ade for working with many coding agents !!
      inputs.llm-agents.packages.${system}.orca

      # hermes agent: the desktop version of hermes agent, another very awesome open source and self improving agentic tool !!
      inputs.llm-agents.packages.${system}.hermes-desktop # hermes-agent desktop!

      # ----------------------------------------------------------------------------------------------------------------------------
      # artcraft apps

      # cadcraft: an AutoCAD clone written in Rust 🦀 !!
      # inputs.artcraft-nix.packages.${system}.cadcraft

      # deckcraft: a Microsoft PowerPoint clone written in Rust 🦀 !!
      (craft "deckcraft")

      # designcraft: an Adobe InDesign clone written in Rust 🦀 !!
      # inputs.artcraft-nix.packages.${system}.designcraft

      # effectcraft: an Adobe After Effects clone written in Rust 🦀 !!
      # inputs.artcraft-nix.packages.${system}.effectcraft

      # filmcraft: an Adobe Premiere Pro clone written in Rust 🦀 !!
      (craft "filmcraft")

      # gridcraft: a Microsoft Excel clone written in Rust 🦀 !!
      (craft "gridcraft")

      # lightcraft: an Adobe Lightroom clone written in Rust 🦀 !!
      # inputs.artcraft-nix.packages.${system}.lightcraft

      # pdfcraft: an Adobe Acrobat clone written in Rust 🦀 !!
      (craft "pdfcraft") # acrobat clone

      # photocraft: an Adobe Photoshop clone written in Rust 🦀 !!
      # inputs.artcraft-nix.packages.${system}.photocraft

      # soundcraft: a clone of the Pro Tools DAW written in Rust 🦀 !!
      (craft "soundcraft") # pro tools clone

      # vectorcraft: an Adobe Illustrator clone written in Rust 🦀 !!
      # inputs.artcraft-nix.packages.${system}.vectorcraft

      # wordcraft: a Microsoft Word clone written in Rust 🦀 !!
      (craft "wordcraft")

      inputs.cromite.packages.${system}.default
    ];
  };
}
