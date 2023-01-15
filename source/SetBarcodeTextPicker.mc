import Toybox.WatchUi;

class SetBarcodeTextPicker extends WatchUi.TextPicker {
    function initialize() {
        var initialText;
        if (Application has :Properties) {
            initialText = Application.Properties.getValue("invoiceBarcode");
            } else {
            var app = Application.getApp();
            initialText = app.getProperty("invoiceBarcode");
        }
        TextPicker.initialize(initialText);
    }
}