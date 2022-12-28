import Toybox.Lang;
import Toybox.WatchUi;

class AboutDelegate extends WatchUi.BehaviorDelegate {
  function initialize() {
    BehaviorDelegate.initialize();
  }
  function onKey(keyEvent) {
    System.println("AboutDelegate: onKey: " + keyEvent.getKey()); // e.g. KEY_MENU = 7
    return true;
  }
}
