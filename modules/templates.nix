{...}: {
  flake.templates = {
    uv2nix = {
      path = ../templates/uv2nix;
      description = "python project built from uv.lock";
    };

    bun2nix = {
      path = ../templates/bun2nix;
      description = "bun project built from bun.lock";
    };

    pnpm2nix = {
      path = ../templates/pnpm2nix;
      description = "pnpm project built from pnpm-lock.yaml";
    };

    crane = {
      path = ../templates/crane;
      description = "rust project built from Cargo.lock";
    };

    bundix = {
      path = ../templates/bundix;
      description = "ruby project built from Gemfile.lock";
    };

    gomod2nix = {
      path = ../templates/gomod2nix;
      description = "go project built from go.sum";
    };

    elm2nix = {
      path = ../templates/elm2nix;
      description = "elm project built from elm.json";
    };

    gradle2nix = {
      path = ../templates/gradle2nix;
      description = "gradle project built from gradle.lock";
    };
  };
}
