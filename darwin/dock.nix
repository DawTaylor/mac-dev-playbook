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

    # persistent-others is set via activation script below because
    # nix-darwin doesn't properly apply displayas/arrangement attributes
    persistent-others = [ ];
  };

  # Manually configure dock folders since nix-darwin doesn't apply folder attributes correctly
  # displayas: 0 = stack, 1 = folder
  # showas: 0 = automatic, 1 = fan, 2 = grid, 3 = list
  # arrangement: 1 = name, 2 = date-added, 3 = date-modified, 4 = date-created, 5 = kind
  system.activationScripts.postActivation.text = ''
    echo "Configuring dock folders..."
    sudo -u ${username} /usr/bin/defaults write com.apple.dock persistent-others -array \
      '<dict>
        <key>tile-data</key>
        <dict>
          <key>file-data</key>
          <dict>
            <key>_CFURLString</key>
            <string>file:///Applications/</string>
            <key>_CFURLStringType</key>
            <integer>15</integer>
          </dict>
          <key>displayas</key>
          <integer>1</integer>
          <key>showas</key>
          <integer>2</integer>
          <key>arrangement</key>
          <integer>1</integer>
        </dict>
        <key>tile-type</key>
        <string>directory-tile</string>
      </dict>' \
      '<dict>
        <key>tile-data</key>
        <dict>
          <key>file-data</key>
          <dict>
            <key>_CFURLString</key>
            <string>file:///Users/${username}/Downloads/</string>
            <key>_CFURLStringType</key>
            <integer>15</integer>
          </dict>
          <key>displayas</key>
          <integer>0</integer>
          <key>showas</key>
          <integer>1</integer>
          <key>arrangement</key>
          <integer>2</integer>
        </dict>
        <key>tile-type</key>
        <string>directory-tile</string>
      </dict>'

    echo "Restarting Dock..."
    sudo -u ${username} /usr/bin/killall Dock || true
  '';
}
