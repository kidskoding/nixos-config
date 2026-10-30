# gui apps for the nixos hosts; victus on pop!_os gets these from apt/flatpak
{...}: {
  flake.homeModules.desktop = {
    inputs,
    pkgs,
    ...
  }: let
    system = pkgs.stdenv.hostPlatform.system;
  in {
    programs.mcp.servers = {
      deckcraft = {
        command = "deckcraft-cli";
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

    home.packages = [
      # applications
      pkgs.discord
      pkgs.doxygen_gui
      pkgs.libreoffice
      pkgs.obsidian
      pkgs.popsicle
      pkgs.ruffle
      pkgs.spotify
      pkgs.teams-for-linux
      pkgs.zathura
      pkgs.zoom-us

      inputs.claude-desktop.packages.${system}.claude-desktop-with-fhs
      inputs.llm-agents.packages.${system}.orca # a wonderful ade for working with many coding agents!
      inputs.llm-agents.packages.${system}.hermes-desktop # hermes-agent desktop!

      # artcraft apps
      # inputs.artcraft-nix.packages.${system}.cadcraft     # autocad clone
      inputs.artcraft-nix.packages.${system}.deckcraft # powerpoint clone
      # inputs.artcraft-nix.packages.${system}.designcraft  # indesign clone
      # inputs.artcraft-nix.packages.${system}.effectcraft  # after effects clone
      # inputs.artcraft-nix.packages.${system}.filmcraft    # premiere pro clone
      inputs.artcraft-nix.packages.${system}.gridcraft # excel clone
      # inputs.artcraft-nix.packages.${system}.lightcraft   # lightroom clone
      inputs.artcraft-nix.packages.${system}.pdfcraft # acrobat clone
      # inputs.artcraft-nix.packages.${system}.photocraft   # photoshop clone
      inputs.artcraft-nix.packages.${system}.soundcraft # pro tools clone
      # inputs.artcraft-nix.packages.${system}.vectorcraft  # illustrator clone
      inputs.artcraft-nix.packages.${system}.wordcraft # word clone

      inputs.cromite.packages.${system}.default
      inputs.zen-browser.packages.${system}.default
    ];
  };
}
