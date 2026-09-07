{ pkgs, lib, ... }:

let
  plugin = id: repo: version: files:
    pkgs.linkFarm id (lib.mapAttrsToList (name: hash: {
      inherit name;
      path = pkgs.fetchurl {
        url = "https://github.com/${repo}/releases/download/${version}/${name}";
        inherit hash;
      };
    }) files) // { manifestId = id; };

  git = plugin "obsidian-git" "Vinzent03/obsidian-git" "2.39.0" {
    "main.js" = "sha256-1adANs8XwaApV8HzP1nkfPOvg1JWQcQ3TKH6CdlfPrQ=";
    "manifest.json" = "sha256-JwQQ7dbmT1HZdDQ8binsg5lQL24FeuXWJk0lmxBPYlw=";
    "styles.css" = "sha256-9auT9NW03RvR5XeGTFx5CH9639RIrDRuBInlhHzmki0=";
  };

  importer = plugin "obsidian-importer" "obsidianmd/obsidian-importer" "3.1.5" {
    "main.js" = "sha256-UhPj+toyI30vMJ27lK0LD7DjpIQt/miAgyfsJs+y1jw=";
    "manifest.json" = "sha256-viWct3DKRR394igUbSLhMKGGYAs4EIQiPekQQWfv0Z0=";
    "styles.css" = "sha256-13Q5W51OgfKDdEltCjJ6Z6br5HrjBbRarxqxAvRqqd0=";
  };

  claude-ide = plugin "claude-code-ide" "petersolopov/obsidian-claude-ide" "0.2.5" {
    "main.js" = "sha256-OPHy6/H5bnj/ceZtiuprBiD98aTyzGF8A/OBWrvUD/k=";
    "manifest.json" = "sha256-z+OBAEnowMWFJsW+f78U4FDuxlbuahVucSeTW8XSF+g=";
  };
in
{
  programs.obsidian = {
    enable = true;
    defaultSettings.communityPlugins = [
      { pkg = git; }
      { pkg = importer; }
      { pkg = claude-ide; }
    ];
    vaults = {
      "notes/cs374" = { };
    };
  };
}
