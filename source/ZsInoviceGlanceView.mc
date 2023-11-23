import Toybox.WatchUi;
import Toybox.Graphics;

(:glance)
class ZsInvoiceGlanceView extends WatchUi.GlanceView {
  var title = null;
  function initialize() {
    GlanceView.initialize();
    // https://forums.garmin.com/developer/connect-iq/f/discussion/231560/glances-any-example-in-sdk-strange-error-in-simulator
    title = WatchUi.loadResource(Rez.Strings.title);
    System.println("Text: " + title);
  }
  function onLayout(dc as Dc) as Void {
    System.println("Glance Width: " + dc.getWidth());
    System.println("Glance Height: " + dc.getHeight());
    // fenix7x Glance canvas size: 191x63
    // venu2 Glance canvas size: 288x133
    // vivoactive4 Glance canvas size: 260x260
  }
  function onUpdate(dc as Dc) as Void {
    GlanceView.onUpdate(dc);

    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    var textDimensions = dc.getTextDimensions(title, Graphics.FONT_SMALL);
    var top = (dc.getHeight() - textDimensions[1]) / 2;
    dc.drawText(0, top, Graphics.FONT_SMALL, title, Graphics.TEXT_JUSTIFY_LEFT);
  }
}
