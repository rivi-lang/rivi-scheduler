{
  inputs = {
    juuso.url = "github:jhvst/nix-config";
  };
  outputs =
    { self
    , nixpkgs
    , flake-utils
    , juuso
    , ...
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      overlays = [ ];
      pkgs = import nixpkgs { inherit system overlays; };
    in
    {
      devShells.default = pkgs.mkShell {
        buildInputs = [
        ];
        packages = with pkgs; [
          juuso.packages.${system}.savilerow
        ];
      };
      # Executed by `nix run . -- <args?>`
      # Example: nix run . -- models/reduce.eprime vk-instances/m1.param -run-solver
      apps.default = {
        type = "app";
        program = "${juuso.packages.${system}.savilerow}/bin/savilerow";
      };
    });
}
