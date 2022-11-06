import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class ZsBarcodeMenuDelegate extends WatchUi.MenuInputDelegate {
  function initialize() {
    MenuInputDelegate.initialize();
  }

  function onMenuItem(item as Symbol) as Void {
    if (item == :item_setting) {
      System.println("Setting Invoice Code");
      if (WatchUi has :TextPicker) {
        WatchUi.pushView(
          new SetBarcodeTextPicker(),
          new SetBarcodeTextPickerDelegate(),
          WatchUi.SLIDE_DOWN
        );
      }
    } else if (item == :item_about) {
      System.println("Show about");
      WatchUi.pushView(
        new AboutView(),
        new AboutDelegate(),
        WatchUi.SLIDE_DOWN
      );
    }
  }
}
