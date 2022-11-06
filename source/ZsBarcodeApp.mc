import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class ZsBarcodeApp extends Application.AppBase {
  var barcodeView;
  function initialize() {
    AppBase.initialize();
  }

  // onStart() is called on application start up
  function onStart(state as Dictionary?) as Void {}

  // onStop() is called when your application is exiting
  function onStop(state as Dictionary?) as Void {}

  // Return the initial view of your application here
  function getInitialView() as Array<Views or InputDelegates>? {
    return (
      [new ZsBarcodeView(), new ZsBarcodeDelegate()] as
      Array<Views or InputDelegates>
    );
  }

  function onSettingsChanged() {
    System.println("onSettingsChanged");
    WatchUi.requestUpdate(); // update the view to reflect changes
  }
}

function getApp() as ZsBarcodeApp {
  return Application.getApp() as ZsBarcodeApp;
}
