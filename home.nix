{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in

{
  home.username = "tjt";
  home.homeDirectory = "/Users/tjt";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # Packages
  home.packages = with pkgs; [
    # CLI tools
    fzf # Fast search
    jq  # JSON on the command line
    neovim # Better vim
    nerd-fonts.hack # Monospace fonts
  ];
  fonts.fontconfig.enable = true;
  home.sessionVariables.EDITOR = "nvim";

  # ZSH
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    autocd = true; # Type a directory name to cd into it
    setOptions = [
      "AUTO_PUSHD"        # Push every visited directory onto the stack
      "PUSHD_IGNORE_DUPS" # Keep the stack free of duplicates
      "PUSHD_MINUS"       # cd -1 is the most recent directory
    ];
    initContent = ''
      bindkey '^f' autosuggest-accept
    '';
    shellAliases = {
      "-" = "cd -";
      vim = "nvim";
      gst = "git status";
      add = "git add .";
      push = "git push";
      pull = "git pull";
      main = "git switch main";
    };
  };

  # Starship
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$directory$git_branch$git_status$cmd_duration$line_break$character";
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
      };
      cmd_duration.format = "[$duration]($style) ";
    };
  };

  # tmux
  programs.tmux = {
    enable = true;
    mouse = true;    # Enable mouse support
    baseIndex = 1;   # Number windows and panes from 1

    plugins = with pkgs.tmuxPlugins; [
      sensible
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore on
          set -g @continuum-save-interval '10'
        '';
      }
    ];

    extraConfig = ''
      set -as terminal-features ",*:hyperlinks"

      # Pass modified keys (like Shift+Enter) through to programs that ask for them
      set -s extended-keys on

      #  Status bar
      set -g status-position bottom

      # Intuitive split keys
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # Keep current path for new windows
      bind c new-window -c "#{pane_current_path}"

      # Close gaps in window numbers when a window is closed
      set -g renumber-windows on
    '';
  };

  # Edit-in-place: the real file stays in my repo, ~/.config just points at it.
  home.file.".claude/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.claude/settings.json";
  home.file.".config/herdr".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/herdr";
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/nvim";
  home.file.".config/wezterm".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/wezterm";

  # Global agent instructions
  home.file.".claude/CLAUDE.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
}
