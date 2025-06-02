let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/archive/a59eb7800787c926045d51b70982ae285faa2346.tar.gz";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
    zig
  ];
}
