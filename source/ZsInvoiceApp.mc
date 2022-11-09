import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class ZsInvoiceApp extends Application.AppBase {
  var barcodeView;
  function initialize() {
    AppBase.initialize();
  }

  // onStart() is called on application start up
  function onStart(state as Dictionary?) as Void {}

  // onStop() is called when your application is exiting
  function onStop(state as Dictionary?) as Void {}

  function onSettingsChanged() {
    System.println("onSettingsChanged");
    WatchUi.requestUpdate(); // update the view to reflect changes
  }

  // Return the initial view of your application here
  function getInitialView() as Array<Views or InputDelegates>? {
    var view = new ZsInvoiceView();
    var delegate = new ZsInvoiceDelegate(view); 
    return (
      [view, delegate] as
      Array<Views or InputDelegates>
    );
  }

  function getGlanceView() {
    return (
      [new ZsInvoiceGlanceView(), new ZsInvoiceGlanceViewDelegate()] as
      Array<GlanceView or GlanceViewDelegate>
    );
  }
}

function getApp() as ZsInvoiceApp {
  return Application.getApp() as ZsInvoiceApp;
}
