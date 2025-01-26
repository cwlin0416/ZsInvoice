import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Lang;

class ScreenSizeMap {
  var minWidth as Number;
  var maxWidth as Number;
  var barcodeWidth as Number;
  var wideLineWidth as Number;
  var narrowLineWidth as Number;

  function initialize(minWidth as Number, maxWidth as Number, barcodeWidth as Number, wideLineWidth as Number, narrowLineWidth as Number) {
    self.minWidth = minWidth;
    self.maxWidth = maxWidth;
    self.barcodeWidth = barcodeWidth;
    self.wideLineWidth = wideLineWidth;
    self.narrowLineWidth = narrowLineWidth;
  }
}
class CustomBarcodeDrawable extends WatchUi.Drawable {
  var barcode = "/ABC.123" as String;
  var maxLength = 8 as Number;
  var charMap as Dictionary<Char, String> = {
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
  var barcodes as Array<String> = new Array<String>[0];
  var paddingTop = 0 as Number;
  var screenSizes as Array<ScreenSizeMap> = new Array<ScreenSizeMap>[0];

  function initialize(params as Dictionary) {
    // You should always call the parent's initializer and
    // in this case you should pass the params along as size
    // and location values may be defined.
    Drawable.initialize(params);
    var paramPaddingTop = params.get(:paddingTop) as Number;
    if (paramPaddingTop != null) {
      self.paddingTop = paramPaddingTop;
    }
    self.screenSizes.add(new ScreenSizeMap(130, 159, 130, 2, 1));
    self.screenSizes.add(new ScreenSizeMap(160, 189, 160, 3, 1));
    self.screenSizes.add(new ScreenSizeMap(190, 259, 190, 4, 1));
    self.screenSizes.add(new ScreenSizeMap(260, 289, 260, 4, 2));
    self.screenSizes.add(new ScreenSizeMap(290, 319, 290, 5, 2));
    self.screenSizes.add(new ScreenSizeMap(320, 349, 320, 6, 2));
    self.screenSizes.add(new ScreenSizeMap(350, 379, 350, 7, 2));
    self.screenSizes.add(new ScreenSizeMap(380, 419, 380, 8, 2));
    self.screenSizes.add(new ScreenSizeMap(420, 449, 420, 7, 3));
    self.screenSizes.add(new ScreenSizeMap(450, 479, 450, 8, 3));
    self.screenSizes.add(new ScreenSizeMap(480, 509, 480, 9, 3));
    self.screenSizes.add(new ScreenSizeMap(510, 539, 510, 10, 3));
    self.screenSizes.add(new ScreenSizeMap(540, 569, 540, 11, 3));
    self.screenSizes.add(new ScreenSizeMap(570, 579, 570, 12, 3));
    self.screenSizes.add(new ScreenSizeMap(580, 609, 580, 10, 4));
    self.screenSizes.add(new ScreenSizeMap(610, 639, 610, 11, 4));
    self.screenSizes.add(new ScreenSizeMap(640, 669, 640, 12, 4));
    self.screenSizes.add(new ScreenSizeMap(670, 699, 670, 13, 4));
    self.screenSizes.add(new ScreenSizeMap(700, 729, 700, 14, 4));
    self.screenSizes.add(new ScreenSizeMap(730, 739, 730, 15, 4));
    self.screenSizes.add(new ScreenSizeMap(740, 759, 740, 13, 5));
    self.screenSizes.add(new ScreenSizeMap(760, 769, 760, 16, 4));
    self.screenSizes.add(new ScreenSizeMap(770, 799, 770, 14, 5));
    self.screenSizes.add(new ScreenSizeMap(800, 829, 800, 15, 5));
    self.screenSizes.add(new ScreenSizeMap(830, 859, 830, 16, 5));
    self.screenSizes.add(new ScreenSizeMap(860, 889, 860, 17, 5));
    self.screenSizes.add(new ScreenSizeMap(890, 899, 890, 18, 5));
    self.screenSizes.add(new ScreenSizeMap(900, 919, 900, 16, 6));
    self.screenSizes.add(new ScreenSizeMap(920, 929, 920, 19, 5));
    self.screenSizes.add(new ScreenSizeMap(930, 949, 930, 17, 6));
    self.screenSizes.add(new ScreenSizeMap(950, 959, 950, 20, 5));
    self.screenSizes.add(new ScreenSizeMap(960, 989, 960, 18, 6));
    self.screenSizes.add(new ScreenSizeMap(990, 1000, 990, 19, 6));
  }

  function refreshBarcode() as Void {
    self.barcode = "/ABC.124";
    try {
      self.barcode = Application.Properties.getValue("invoiceBarcode");
    } catch(ex) {
      System.println("Exception: " + ex.getErrorMessage());
    }
    var barcodeChars = self.barcode.toUpper().toCharArray() as Array<Char>;
    self.barcodes = new Array<String>[0]; // build you data array
    var startEndChar = self.charMap['*'];
    self.barcodes.add(startEndChar); // Code 39 barcodes start with a *
    for (var i = 0; i < barcodeChars.size(); i++) {
      var barcodeChar = barcodeChars[i];
      var result = self.charMap[barcodeChar] as String?; //<-- look up for each character
      // System.print(barcodeChar);
      // System.print(", ");
      // System.println(result);
      if (result != null && self.barcodes.size() < self.maxLength + 1) {
        self.barcodes.add(result);
      }
    }
    self.barcodes.add(startEndChar); // Code 39 barcodes end with a *
  }

  function calBarWidth(barUnitWidth, barcodeSize, wideLineWidth, extraGap) {
    var minGap = 1;
    var narrowLineWidth = 1;
    var charBarWidth = narrowLineWidth * 6 + wideLineWidth * 3;
    return barUnitWidth * barcodeSize * (charBarWidth + minGap + extraGap);
  }
  function getBarUnitWidth(screenWidth, barcodeSize, wideLineWidth, extraGap) {
    return screenWidth / self.calBarWidth(1, barcodeSize, wideLineWidth, extraGap);
  }
  function getSuggestWideLineWidth(screenWidth as Number) {
    if (self.screenSizes.size() <= 0) {
      return 2;
    }
    for(var i=0; i<self.screenSizes.size(); i++) {
      var screenSize = self.screenSizes[i] as ScreenSizeMap;
      if (screenWidth >= screenSize.minWidth && screenWidth <= screenSize.maxWidth) {
        System.println("Found width " + screenWidth + " between " + screenSize.minWidth + " and " + screenSize.maxWidth);
        System.println("Suggest wideLineWidth is " + screenSize.wideLineWidth / screenSize.narrowLineWidth);
        return screenSize.wideLineWidth / screenSize.narrowLineWidth;
      }
    }
    return 2;
  }

  function draw(dc as Dc) as Void {
    System.println("CustomBarcodeDrawable: draw()");
    System.println("Height: " + dc.getHeight());
    System.println("Weight: " + dc.getWidth());

    self.refreshBarcode();

    // Background Color
    //dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
    dc.clear();

    // Render barcode
    var barPadding = 14;
    var extraGap = 0;
    var narrowLineWidth = 1;
    var wideLineWidth = self.getSuggestWideLineWidth(dc.getWidth()-barPadding); // Default narrow line to wide line is 1:2

    var barUnitWidth = self.getBarUnitWidth(
      dc.getWidth() - barPadding,
      self.barcodes.size(),
      wideLineWidth,
      extraGap
    );
    var defaultBarWidth = self.calBarWidth(
      barUnitWidth,
      self.barcodes.size(),
      wideLineWidth,
      extraGap
    );
    var barWidth = defaultBarWidth;

    // // If screen size between 1 unit width 1:3 and 2 unit width 1:2 then use 1:3 to increase barcode accuracy.
    // var testWideLineWidth = 3;
    // var testExtraGap = 2;
    // var testBarWidth = self.calBarWidth(
    //   1,
    //   self.barcodes.size(),
    //   testWideLineWidth,
    //   testExtraGap
    // );
    // var testMinBarWidth =
    //   self.calBarWidth(1, self.barcodes.size(), wideLineWidth, extraGap) * 2;
    // System.println("defaultBarWidth: " + defaultBarWidth);
    // System.println("testBarWidth: " + testBarWidth);
    // if (
    //   dc.getWidth() >= testBarWidth + barPadding &&
    //   dc.getWidth() < testMinBarWidth + barPadding
    // ) {
    //   System.println("Use enchanced barcode");
    //   wideLineWidth = testWideLineWidth;
    //   extraGap = testExtraGap;
    //   barUnitWidth = self.getBarUnitWidth(
    //     dc.getWidth() - barPadding,
    //     self.barcodes.size(),
    //     wideLineWidth,
    //     extraGap
    //   );
    //   barWidth = self.calBarWidth(
    //     barUnitWidth,
    //     self.barcodes.size(),
    //     wideLineWidth,
    //     extraGap
    //   );
    // }

    var barHeight = Math.round(dc.getHeight() / 3.5);

    System.println("barUnitWidth: " + barUnitWidth);
    System.println("barWidth: " + barWidth);
    System.println("barcodes Size: " + self.barcodes.size());

    var top = (dc.getHeight() - barHeight) / 2 + self.paddingTop; // Vertical Center
    var left = (dc.getWidth() - barWidth) / 2; // Horizontal Center
    var shift = left;

    dc.drawText(
      dc.getWidth() / 2,
      top + barHeight + 10,
      Graphics.FONT_SYSTEM_XTINY,
      self.barcode.substring(0, self.maxLength),
      Graphics.TEXT_JUSTIFY_CENTER
    );

    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    dc.fillRoundedRectangle(
      left - barPadding / 4,
      top - barPadding / 4,
      barWidth + barPadding / 2,
      barHeight + barPadding / 2,
      5
    );
    if (dc has :setAntiAlias) {
      dc.setAntiAlias(false);
    }
    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
    System.println("Size: " + self.barcodes.size());
    for (var i = 0; i < self.barcodes.size(); i++) {
      // System.println(self.barcodes[i]);
      var lines = self.barcodes[i].toCharArray() as Array<Char>;
      for (var j = 0; j < lines.size(); j++) {
        var isBlank = lines[j] == '0';
        var isWideLine =
          j + 1 < lines.size() ? lines[j] == lines[j + 1] : false;
        if (isWideLine) {
          if (!isBlank) {
            dc.fillRectangle(
              shift,
              top,
              barUnitWidth * wideLineWidth,
              barHeight
            );
          }
          shift += barUnitWidth * wideLineWidth;
          j++; // If is wide line then skip next char.
        } else {
          if (!isBlank) {
            dc.fillRectangle(
              shift,
              top,
              barUnitWidth * narrowLineWidth,
              barHeight
            );
          }
          shift += barUnitWidth * narrowLineWidth;
        }
      }
      shift += barUnitWidth + extraGap;
    }
  }
}
