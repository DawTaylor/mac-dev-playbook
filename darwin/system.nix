{ pkgs, ... }:

{
  # macOS system preferences
  system.defaults = {
    # Dock settings (apps configured in dock.nix)
    dock = {
      autohide = true;
      show-recents = false;
      launchanim = true;
      orientation = "bottom";
      minimize-to-application = false;
      mru-spaces = false;
    };

    # Finder settings
    finder = {
      AppleShowAllExtensions = false;
      ShowPathbar = false;
      ShowStatusBar = false;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";
    };

    # Global settings
    NSGlobalDomain = {
      AppleShowAllExtensions = false;
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
      Clicking = false;
      TrackpadRightClick = true;
    };

    # Login window
    loginwindow = {
      GuestEnabled = false;
    };
  };
}
