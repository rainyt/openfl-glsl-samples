import openfl.display.ShaderParameter;
import openfl.events.MouseEvent;
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

		// 从这里更换GLSL目标
		bitmap.shader = new glsl.MouseGLSL();
		bitmap.addEventListener(Event.ENTER_FRAME, function(e) {
			bitmap.invalidate();
		});
		stage.addEventListener(MouseEvent.MOUSE_MOVE, function(e:MouseEvent) {
			if (Reflect.field(bitmap.shader, "u_mouse")) {
				Reflect.getProperty(bitmap.shader, "u_mouse").value = [bitmap.mouseX, bitmap.mouseY];
			}
		});
	}
}
