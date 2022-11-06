import Toybox.Graphics;
import Toybox.WatchUi;

class AboutView extends WatchUi.View {
  function initialize() {
    View.initialize();
  }
  // Load your resources here
  function onLayout(dc as Dc) as Void {
    setLayout(Rez.Layouts.AboutLayout(dc));
  }

  function onUpdate(dc as Dc) as Void {
    View.onUpdate(dc);

    var icon = WatchUi.loadResource(Rez.Drawables.LauncherIcon);
    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    dc.drawText(
      dc.getWidth() / 2,
      dc.getHeight() / 2 + 20,
      Graphics.FONT_SMALL,
      Application.Properties.getValue("appVersion"),
      Graphics.TEXT_JUSTIFY_CENTER
    );
    dc.drawBitmap(
      (dc.getWidth() - icon.getWidth()) / 2,
      (dc.getHeight() - icon.getHeight()) / 2 - dc.getHeight()*0.4 + 10,
      icon
    );
  }
}
