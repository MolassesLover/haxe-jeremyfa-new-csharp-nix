{
  description = "Jérémy Faivre fork of Haxe, following their experimental C# back-end";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      supportedSystems = [ "x86_64-linux" ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = (
            import nixpkgs {
              inherit system;
              config.permittedInsecurePackages = [ "mbedtls-2.28.10" ];
            }
          );

          haxe5-jeremyfa-new_csharp = pkgs.callPackage ./package.nix {
          };
        in
        {
          inherit haxe5-jeremyfa-new_csharp;
          default = haxe5-jeremyfa-new_csharp;
          devShell = pkgs.mkShell { inputsFrom = [ haxe5-jeremyfa-new_csharp ]; };
        }
      );
    };
}
