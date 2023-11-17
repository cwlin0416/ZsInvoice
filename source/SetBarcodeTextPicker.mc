import Toybox.WatchUi;

class SetBarcodeTextPicker extends WatchUi.TextPicker {
    function initialize() {
        var initialText = "ABC.123";
        try {
            if (Application has :Properties) {
                initialText = Application.Properties.getValue("invoiceBarcode");
            } else {
                var app = Application.getApp();
                initialText = app.getProperty("invoiceBarcode");
            }
        } catch (ex) {
            initialText = "ABC.124";
            System.println("Exception: " + ex.getErrorMessage());
        }
        TextPicker.initialize(initialText);
    }
}