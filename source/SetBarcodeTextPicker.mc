import Toybox.WatchUi;

class SetBarcodeTextPicker extends WatchUi.TextPicker {
    function initialize() {
        var initialText = "ABC.123";
        try {
            initialText = Application.Properties.getValue("invoiceBarcode");
        } catch (ex) {
            initialText = "ABC.124";
            System.println("Exception: " + ex.getErrorMessage());
        }
        TextPicker.initialize(initialText);
    }
}