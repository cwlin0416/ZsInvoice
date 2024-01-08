import Toybox.Graphics;
import Toybox.WatchUi;
using Toybox.Timer;

class ZsInvoiceView extends WatchUi.View {
  var maxDuration = 25000;
  var interval = 25000;
  var currentDuration = 0;
  var myTimer = new Timer.Timer();
  var isBackLightOn = false;
  function initialize() { View.initialize(); }

  // Load your resources here
  function onLayout(dc as Dc) as Void { setLayout(Rez.Layouts.MainLayout(dc)); }

  function tuneOffBacklight() {
    System.println("Backlight off");
    try {
      Attention.backlight(false);
    } catch (ex) {
      System.println(ex.getErrorMessage());
    }
    self.isBackLightOn = false;
    self.currentDuration = 0;
  }

  function tuneOnBacklight() {
    System.println("Backlight countdown on");
    self.isBackLightOn = true;
    self.myTimer.stop();
    self.currentDuration = 0;
    turnOnLoop();
  }
  function turnOnLoop() {
    System.println("currentDuration sec: " + currentDuration);
    if (self.isBackLightOn && self.currentDuration < self.maxDuration) {
      try {
        Attention.backlight(1.0);
        self.myTimer.start(method(:turnOnLoop), self.interval, false);
      } catch (ex) {
        tuneOffBacklight();
        System.println(ex.getErrorMessage());
      }
    } else {
      tuneOffBacklight();
    }
    self.currentDuration += self.interval;
  }

  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() as Void { tuneOnBacklight(); }

  // Update the view
  function onUpdate(dc as Dc) as Void {
    // Call the parent onUpdate function to redraw the layout
    View.onUpdate(dc);
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void { tuneOffBacklight(); }
}
