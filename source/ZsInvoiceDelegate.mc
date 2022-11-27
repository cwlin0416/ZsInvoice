import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.Timer;

class ZsInvoiceDelegate extends WatchUi.BehaviorDelegate {
  var isBackLightOn = false;
  var ziView = null;
  function initialize(view as ZsInvoiceView) {
    BehaviorDelegate.initialize();
    ziView = view;
  }

  function onMenu() as Boolean {
    System.println("onMenu");
    WatchUi.pushView(
      new Rez.Menus.MainMenu(),
      new ZsInvoiceMenuDelegate(),
      WatchUi.SLIDE_UP
    );
    return true;
  }

  // Detect Menu button input
  function onKey(keyEvent as KeyEvent) {
    if (keyEvent.getKey() == KEY_ENTER) {
      ziView.tuneOnBacklight();
      return true;
    }
    System.println("onKey: " + keyEvent.getKey()); // e.g. KEY_MENU = 7
    return false;
  }

  function onTap(clickEvent as ClickEvent) {
    System.println("onTap");
    // System.println(clickEvent.getCoordinates());
    // System.println(clickEvent.getType());
    ziView.tuneOnBacklight();
    return true;
  }
}
