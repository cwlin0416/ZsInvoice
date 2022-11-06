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
      Application.Properties.setValue("invoiceBarcode", text);
    }
  }

  function onCancel() {
    System.println("SetBarcodeTextPickerDelegate: Canceled");
  }
}
