import Toybox.WatchUi;

class SetBarcodeTextPicker extends WatchUi.TextPicker {
    function initialize() {
        var initialText = Application.Properties.getValue("invoiceBarcode");
        TextPicker.initialize(initialText);
    }
}