import Toybox.Graphics;
import Toybox.WatchUi;
using Toybox.Timer;

class ZsInvoiceView extends WatchUi.View {
  var isBackLightOn = false;
  function initialize() {
    View.initialize();
  }

  // Load your resources here
  function onLayout(dc as Dc) as Void {
    setLayout(Rez.Layouts.MainLayout(dc));
  }

  function tuneOffBacklight() {
    System.println("Backlight off");
    Attention.backlight(false);
    isBackLightOn = false;
  }

  function tuneOnBacklight() {
    if (!isBackLightOn) {
      System.println("Backlight on");
      var myTimer = new Timer.Timer();
      isBackLightOn = true;
      myTimer.start(method(:tuneOffBacklight), 15000, false);
      Attention.backlight(1.0);
    }
  }

  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() as Void {
    tuneOnBacklight();
  }

  // Update the view
  function onUpdate(dc as Dc) as Void {
    // Call the parent onUpdate function to redraw the layout
    View.onUpdate(dc);
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {
    tuneOffBacklight();
  }
}
