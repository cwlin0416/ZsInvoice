import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.Timer;

class ZsBarcodeDelegate extends WatchUi.BehaviorDelegate {
  var isBackLightOn = false;
  function initialize() {
    BehaviorDelegate.initialize();
  }

  function onMenu() as Boolean {
    System.println("onMenu");
    WatchUi.pushView(
      new Rez.Menus.MainMenu(),
      new ZsBarcodeMenuDelegate(),
      WatchUi.SLIDE_UP
    );
    return true;
  }

  function tuneOffBacklight() {
    System.println("Backlight off");
    Attention.backlight(false);
    isBackLightOn = false;
  }

  // Detect Menu button input
  function onKey(keyEvent) {
    if (keyEvent.getKey() == KEY_ENTER) {
      if (!isBackLightOn) {
        System.println("Backlight on");
        var myTimer = new Timer.Timer();
        isBackLightOn = true;
        myTimer.start(method(:tuneOffBacklight), 10000, false);
        Attention.backlight(1.0);
      }

      return true;
    }

    // if (keyEvent.getKey() == KEY_ESC) {
    //   Attention.backlight(false);
    //   return true;
    // }
    System.println("onKey: " + keyEvent.getKey()); // e.g. KEY_MENU = 7
    return false;
  }
}
