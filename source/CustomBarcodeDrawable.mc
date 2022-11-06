import Toybox.WatchUi;
import Toybox.Graphics;

class CustomBarcodeDrawable extends WatchUi.Drawable {
  var barcode = "/ABC.123";
  var maxLength = 8;
  var charMap = {
    // map each character to it's pattern
    ' ' => "100110101101",
    '$' => "100100100101",
    '%' => "101001001001",
    '*' => "100101101101",
    '+' => "100101001001",
    '-' => "100101011011",
    '/' => "100100101001",
    '.' => "110010101101",
    '0' => "101001101101",
    '1' => "110100101011",
    '2' => "101100101011",
    '3' => "110110010101",
    '4' => "101001101011",
    '5' => "110100110101",
    '6' => "101100110101",
    '7' => "101001011011",
    '8' => "110100101101",
    '9' => "101100101101",
    'A' => "110101001011",
    'B' => "101101001011",
    'C' => "110110100101",
    'D' => "101011001011",
    'E' => "110101100101",
    'F' => "101101100101",
    'G' => "101010011011",
    'H' => "110101001101",
    'I' => "101101001101",
    'J' => "101011001101",
    'K' => "110101010011",
    'L' => "101101010011",
    'M' => "110110101001",
    'N' => "101011010011",
    'O' => "110101101001",
    'P' => "101101101001",
    'Q' => "101010110011",
    'R' => "110101011001",
    'S' => "101101011001",
    'T' => "101011011001",
    'U' => "110010101011",
    'V' => "100110101011",
    'W' => "110011010101",
    'X' => "100101101011",
    'Y' => "110010110101",
    'Z' => "100110110101",
  };
  var barcodes = new [0];
  var paddingTop = 0;

  function initialize(params as Dictionary) {
    // You should always call the parent's initializer and
    // in this case you should pass the params along as size
    // and location values may be defined.
    Drawable.initialize(params);
    paddingTop = params.get(:paddingTop) ? params.get(:paddingTop) : 0;
  }

  function refreshBarcode() as Void {
    barcode = Application.Properties.getValue("invoiceBarcode");
    var barcodeChars = barcode.toUpper().toCharArray();
    barcodes = new [0]; // build you data array
    barcodes.add("100101101101"); // Code 39 barcodes start with a *
    for (var i = 0; i < barcodeChars.size(); i++) {
      var result = charMap[barcodeChars[i]]; //<-- look up for each character
      // System.print(barcodeChars[i]);
      // System.print(", ");
      // System.println(result);
      if (result != null && barcodes.size() < maxLength + 1) {
        barcodes.add(result);
      }
    }
    barcodes.add("100101101101"); // Code 39 barcodes end with a *
  }

  function draw(dc as Dc) as Void {
    System.println("CustomBarcodeDrawable: draw()");
    System.println("Height: " + dc.getHeight());
    System.println("Weight: " + dc.getWidth());

    refreshBarcode();

    // Render barcode
    var barUnitWidth = (dc.getWidth() - 20) / barcodes.size() / 13; // 1.5
    System.println("barUnitWidth: " + barUnitWidth);
    var barHeight = Math.round(dc.getHeight() / 4);
    var barWidth = barUnitWidth * barcodes.size() * 13;
    var top = (dc.getHeight() - barHeight) / 2 + paddingTop; // Vertical Center
    var left = (dc.getWidth() - barWidth) / 2; // Horizontal Center
    var shift = left;

    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    dc.fillRoundedRectangle(
      left - 5,
      top - 5,
      barWidth + 10,
      barHeight + 10,
      5
    );
    dc.drawText(
      dc.getWidth() / 2,
      top + barHeight + 10,
      Graphics.FONT_SYSTEM_XTINY,
      barcode.substring(0, maxLength),
      Graphics.TEXT_JUSTIFY_CENTER
    );

    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
    System.println("Size: " + barcodes.size());
    for (var i = 0; i < barcodes.size(); i++) {
      // System.println(barcodes[i]);
      var lines = barcodes[i].toCharArray();
      for (var j = 0; j < lines.size(); j++) {
        var isBlank = lines[j] == '0';
        if (!isBlank) {
          dc.fillRectangle(shift, top, barUnitWidth, barHeight);
        }
        shift += barUnitWidth;
      }
      shift += barUnitWidth;
    }
  }
}
