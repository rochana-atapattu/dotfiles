{ pkgs, lib, ... }:

{

  home = {
    stateVersion = "24.05"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = [
      pkgs.amber
      pkgs.devenv
      pkgs.markdown-oxide
      pkgs.nixd
      pkgs.ripgrep
      pkgs.hello
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      ".zshrc".source = ../zsh/zshrc.symlink;
      ".zshenv".source = ../zsh/zshenv.symlink;
      ".zprofile".source = ../zsh/zprofile.symlink;
    };

    sessionVariables = {
    };

    sessionPath = [
    "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
    ];
  };

  programs = {
    home-manager.enable = true;
    
    zsh = {
      enable = true;
      initExtra = ''
        # Add any additional configurations here
        export PATH=/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH
        if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
          . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        fi
      '';
    };
  };

}
