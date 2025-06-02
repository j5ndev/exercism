# exercism

Exercises completed for the http://exercism.org website

## Nix

This project uses [nix](https://nix.dev/install-nix) to manage dependencies.

Once Nix is installed, execute the following command from inside a language folder
to start a shell with the needed dependencies:

```
cd zig
nix-shell
```
In this case, `exercism/zig/shell.nix` was referenced to provide the necessary dependencies.

## Run tests for a specific exercise

```
cd raindrops
zig test test_raindrops.zig
```
