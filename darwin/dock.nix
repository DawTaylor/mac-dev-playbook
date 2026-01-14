{ pkgs, ... }:

{
  # Dock configuration using dockutil
  # Note: dockutil is installed via Homebrew in homebrew.nix

  system.defaults.dock = {
    # Items to show in dock (persistent apps)
    persistent-apps = [
      "/Applications/Vivaldi.app"
      "/Applications/Firefox.app"
      "/Applications/Slack.app"
      "/Applications/Notion.app"
      "/Applications/Ghostty.app"
      "/Applications/Visual Studio Code.app"
      "/System/Applications/System Settings.app"
    ];

    # Persistent folders in dock (right side)
    persistent-others = [
      "/Applications"
      "/Users/daw/Downloads"
    ];
  };
}
