{ lib, ... }:
{
  # Import all *.nix files in dir except default.nix
  imports =
    with builtins;
    with lib;
    map (fn: ./${fn}) (
      filter (fn: (fn != "default.nix" && !hasSuffix ".md" "${fn}")) (attrNames (readDir ./.))
    );
}
