import Toybox.Graphics;
import Toybox.WatchUi;
using Toybox.Timer;

class ZsInvoiceView extends WatchUi.View {
  var myTimer = new Timer.Timer();
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
    try {
      Attention.backlight(1.0);
    } catch (ex instanceof Attention.BacklightOnTooLongException) {
      System.println(ex.getErrorMessage());
    }
    System.println("Backlight countdown on");
    isBackLightOn = true;
    myTimer.stop();
    myTimer.start(method(:tuneOffBacklight), 25000, false);
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
