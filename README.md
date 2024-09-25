# Dotfiles

This is to describe the barebones development system I use. Supports Silicon Macs.

Featuring:

## Install Nix

On OSX: [Determinate Systems Installer](https://github.com/DeterminateSystems/nix-installer).

## Bootstrap

> [!WARNING]
> I haven't tested bootstrapping this yet, especially on an "unknown" host.

### Darwin/Linux

`nix run nix-darwin -- switch --flake github:rochana/dotfiles`

## Update

### Darwin

`darwin-rebuild switch --flake /dotfiles`

## Home Manager

You could use something like this to import my home-manager standalone.

```nix
{ config, pkgs, ... }: {
  home-manager.users.evan = import ./home-manager/home.nix;
}
```
