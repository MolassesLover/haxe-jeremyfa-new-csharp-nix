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

  ppx_parser = (
    ocamlPackages.buildDunePackage (finalAttrs: {
      pname = "ppx_parser";
      version = "0.2.0";

      minimalOCamlVersion = "4.8";

      src = fetchFromGitHub {
        owner = "NielsMommen";
        repo = "ppx_parser";
        tag = "0.2.0";
        hash = "sha256-+TvpBzo42UC29XYQZGEQfs4I4PFosJvCdpL1zSdQymg=";
      };

      buildInputs = [
        ocamlPackages.ppxlib
        ocamlPackages.alcotest
        ocamlPackages.camlp-streams
        ocamlPackages.ppx_deriving
      ];

      doCheck = lib.versionAtLeast pkgs.ocaml.version "4.8";

      meta = {
        homepage = "https://github.com/NielsMommen/ppx_parser";
        description = "Write stream parser in OCaml using ppx extensions";
        license = lib.licenses.isc;
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

  buildInputs = [
    pkgs.dune
    pkgs.neko
    pkgs.zlib

    ocamlPackages.camlp5
    ocamlPackages.domainslib
    ocamlPackages.extlib
    ocamlPackages.findlib
    ocamlPackages.luv
    ocamlPackages.ocaml
    ocamlPackages.ptmap
    ocamlPackages.saturn
    ocamlPackages.sedlex
    ocamlPackages.sha
    ocamlPackages.xml-light
    ocamlPackages.terminal_size
    ocamlPackages.ipaddr

    dynamic_gc
    thread-local-storage
    ppx_parser
  ];

  patches = [ ];
})
