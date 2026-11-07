{ ... }:

{
  # Determinate already manages the Nix daemon, so nix-darwin shouldn't.
  nix.enable = false;

  # Allow installation of programs from Nix that aren't free.
  nixpkgs.config.allowUnfree = true;

  # Architecture of the system.
  nixpkgs.hostPlatform = "aarch64-darwin"; # Apple Silicon

  # System settings
  system.primaryUser = "tjt";
  users.users.tjt = {
    home = "/Users/tjt";
  };
  system.stateVersion = 6;
  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      KeyRepeat = 2;          # Fast key repeat
      InitialKeyRepeat = 15;  # Short delay before repeat
      _HIHideMenuBar = false; # Always show the menu bar
      AppleShowAllExtensions = true;
    };
    dock.autohide = true;                 # Auto-hide the dock
    finder.FXPreferredViewStyle = "Nlsv"; # List view by default
    finder.CreateDesktop = false;         # Clean desktop
    trackpad.Clicking = true;             # Tap to click
  };

  # Homebrew
  nix-homebrew = {
    enable = true;
    user = "tjt";
  };
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap"; # Remove anything not listed here
    onActivation.autoUpdate = true;
    onActivation.extraFlags = [ "--force" ];
    brews = [
      "herdr"
    ];
    casks = [
      "claude"
      "claude-code"
      "obsidian"
      "rectangle"
      "spotify"
      "tailscale-app"
      "wezterm"
      "wispr-flow"
    ];
  };
}
