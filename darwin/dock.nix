{ pkgs, username, ... }:

{
  system.defaults.dock = {
    # Keep dock size consistent (don't magnify on hover)
    magnification = false;
    tilesize = 59;
    largesize = 59;

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
    # Note: nix-darwin persistent-others only accepts paths
    # Display style is set via activation script below
    persistent-others = [
      "/Applications"
      "/Users/${username}/Downloads"
    ];
  };

  # Configure dock folders to display as folders (not stacks)
  # displayas: 0 = stack, 1 = folder
  # showas: 0 = automatic, 1 = fan, 2 = grid, 3 = list
  system.activationScripts.postActivation.text = ''
    echo "Configuring dock folder display settings..."
    /usr/bin/defaults write com.apple.dock persistent-others -array-add '<dict>
      <key>tile-data</key>
      <dict>
        <key>displayas</key>
        <integer>1</integer>
        <key>showas</key>
        <integer>2</integer>
      </dict>
    </dict>' 2>/dev/null || true
  '';
}
