import Toybox.WatchUi;
import Toybox.Graphics;

class ZsInvoiceGlanceView extends WatchUi.GlanceView {
  function initialize() {
    GlanceView.initialize();
  }
  function onLayout(dc as Dc) as Void {}
  function onUpdate(dc as Dc) as Void {
    GlanceView.onUpdate(dc);
    // fenix7x Glance canvas size: 191x63
    // venu2 Glance canvas size: 288x133
    // vivoactive4 Glance canvas size: 260x260
    System.println("Glance Width: " + dc.getWidth());
    System.println("Glance Height: " + dc.getHeight());

    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    //dc.clear();

    var title = WatchUi.loadResource(Rez.Strings.title);
    System.println("Text: " + title);
    var textDimensions = dc.getTextDimensions(title, Graphics.FONT_SMALL);
    var top = (dc.getHeight() - textDimensions[1]) / 2;
    dc.drawText(0, top, Graphics.FONT_SMALL, title, Graphics.TEXT_JUSTIFY_LEFT);
  }
}
