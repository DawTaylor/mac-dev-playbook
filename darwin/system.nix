{ pkgs, ... }:

{
  # macOS system preferences
  system.defaults = {
    # Dock settings
    dock = {
      autohide = false;
      show-recents = false;
      launchanim = true;
      orientation = "bottom";
      tilesize = 48;
      minimize-to-application = true;
      mru-spaces = false;
    };

    # Finder settings
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      ShowStatusBar = true;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";
    };

    # Global settings
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      ApplePressAndHoldEnabled = false;
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
    };

    # Trackpad settings
    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
    };

    # Login window
    loginwindow = {
      GuestEnabled = false;
    };
  };
}
