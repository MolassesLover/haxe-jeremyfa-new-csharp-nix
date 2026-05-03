{
  lib,
  pkgs,
  fetchFromGitHub,
  fetchgit,
  ...
}:
let
  ocamlPackages = pkgs.ocaml-ng.ocamlPackages_5_0;
  #ocamlPackages = pkgs.ocamlPackages;

  dynamic_gc = (
    ocamlPackages.buildDunePackage (finalAttrs: {
      pname = "dynamic_gc";
      version = "0.1.0";

      minimalOCamlVersion = "4.08";

      src = fetchFromGitHub {
        owner = "semgrep";
        repo = "dynamic-gc";
        tag = finalAttrs.version;
        hash = "sha256-GhheKna7IYla0ssHu0nTqx7JO2HwBDqyM/XR/jw5EGE=";
      };

      doCheck = lib.versionAtLeast pkgs.ocaml.version "4.08";

      meta = {
        homepage = "https://github.com/semgrep/dynamic-gc";
        description = "Dynamic tuning for the OCaml garbage collector";
        license = lib.licenses.mit;
      };
    })
  );

  thread-local-storage = (
    ocamlPackages.buildDunePackage (finalAttrs: {
      pname = "thread-local-storage";
      version = "v0.2";

      minimalOCamlVersion = "4.08";

      src = fetchFromGitHub {
        owner = "c-cube";
        repo = "thread-local-storage";
        tag = finalAttrs.version;
        hash = "sha256-ijswqxFx4IsWpU+KJ+0xZJLvPisVXp+TWturBIidPBQ=";
      };

      doCheck = lib.versionAtLeast pkgs.ocaml.version "4.08";

      meta = {
        homepage = "https://github.com/semgrep/dynamic-gc";
        description = "Thread-local storage for OCaml";
        license = lib.licenses.mit;
      };
    })
  );
in

with ocamlPackages;
pkgs.haxe.overrideAttrs (previousAttrs: {
  pname = "haxe5-jeremyfa-new_csharp";
  version = "v0.0.1";

  src = fetchgit {
    rev = "45eb213567fc0d540ae2194838f582ae8deb1270";
    hash = "sha256-zXtiQVlEzcEdR955HY/9scFu1rgLzla3ygUy2GwRZss=";
    url = "https://github.com/jeremyfa/haxe.git";
  };

  buildInputs = pkgs.haxe.buildInputs ++ [
    thread-local-storage
    dynamic_gc
    ocamlPackages.saturn
    ocamlPackages.domainslib
  ];

  patches = [ ];
})
