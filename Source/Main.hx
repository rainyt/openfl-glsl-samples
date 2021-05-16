import openfl.events.Event;
import openfl.utils.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

class Main extends Sprite {
	public function new() {
		super();
		var bitmap = new Bitmap();
		bitmap.bitmapData = Assets.getBitmapData("assets/img.png");
		this.addChild(bitmap);

		bitmap.shader = new glsl.BitmapGLSL();
		bitmap.addEventListener(Event.ENTER_FRAME, function(e) {
			bitmap.invalidate();
		});
	}
}
