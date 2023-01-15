import Toybox.WatchUi;

class SetBarcodeTextPickerDelegate extends WatchUi.TextPickerDelegate {
  function initialize() {
    TextPickerDelegate.initialize();
  }

  function onTextEntered(text, changed) {
    System.println(
      "SetBarcodeTextPickerDelegate: " + text + "\n" + "Changed: " + changed
    );

    if (changed) {
      if (Application has :Properties) {
        Application.Properties.setValue("invoiceBarcode", text);
      } else {
        var app = Application.getApp();
        app.setProperty("invoiceBarcode", text);
      }
    }
    return true;
  }

  function onCancel() {
    System.println("SetBarcodeTextPickerDelegate: Canceled");
    return true;
  }
}
