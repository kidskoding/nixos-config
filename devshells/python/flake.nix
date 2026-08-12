{
  description = "python dev shell (interpreter + prepackaged libraries + uv & ruff)";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          (python314.withPackages (ps: with ps; [
            httpx
            matplotlib
            numpy
            pandas
            pillow
            polars
            pydantic
            pytest
            python-dotenv
            pyyaml
            requests
            scikit-learn
            setuptools
            seaborn
            wheel
          ]))

          uv
          ruff
        ];

        env = {
          UV_PYTHON_DOWNLOADS = "never";
          UV_PYTHON_PREFERENCE = "only-system";
        };
      };
    };
}
