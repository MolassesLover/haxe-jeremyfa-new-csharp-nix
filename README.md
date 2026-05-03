# Haxe - Experimental C# Target
![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/MolassesLover/haxe-jeremyfa-new-csharp-nix/build.yml?style=for-the-badge&logo=nixos&color=84b9c9&logoColor=FFFFFF&labelColor=262a35&label=BUILD)

This is a Nix package for [@jeremyfa](https://github.com/jeremyfa)'s Haxe fork,
following the [`new_csharp`](https://github.com/jeremyfa/haxe/tree/new_csharp)
branch, implementing an experimental C# target.

Please see this 
[draft pull request](https://github.com/HaxeFoundation/haxe/pull/12575)
for additional information.

## State
This package does not currently build. Haxe v5.0's new OCaml dependencies are
still being packaged, and use of OCaml v5.0 results in a missing library error.
