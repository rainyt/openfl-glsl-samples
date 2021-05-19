import openfl.text.TextFormat;
import openfl.text.TextField;
import glsl.CircleMaskGLSL;
import glsl.RoundMaskGLSL;
import glsl.VertexGLSL2;
import glsl.BitmapGLSL;
import glsl.BitmapGLSL2;
import glsl.BitmapGLSL3;
import glsl.BitmapGLSL4;
import glsl.BitmapGLSL5;
import glsl.BitmapGLSL6;
import glsl.Haxe2GLSL;
import glsl.VertexGLSL;
import glsl.LightEffect;
import glsl.LightPointRotation;
import openfl.events.MouseEvent;
import openfl.events.Event;
import openfl.utils.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

class Main extends Sprite {
	public function new() {
		super();

		var bitmap2 = new Bitmap();
		bitmap2.bitmapData = Assets.getBitmapData("assets/img.png");
		this.addChild(bitmap2);

		var spr:Sprite = new Sprite();
		var bitmap = new Bitmap();
		bitmap.bitmapData = Assets.getBitmapData("assets/adtest.png");
		spr.addChild(bitmap);
		this.addChild(spr);

		// 文本渲染
		var text:TextField = new TextField();
		this.addChild(text);
		text.text = "测试文案";
		text.x = 500;
		text.y = 300;
		text.setTextFormat(new TextFormat(null, 32));
		text.width = 300;
		text.height = 300;
		text.mouseEnabled = false;
		text.shader = new glsl.TextGLSL();

		// 从这里更换GLSL目标
		bitmap.shader = new glsl.CircleMaskGLSL();
		bitmap.addEventListener(Event.ENTER_FRAME, function(e) {
			bitmap.invalidate();
		});
		// 新增鼠标事件
		stage.addEventListener(MouseEvent.MOUSE_MOVE, function(e:MouseEvent) {
			if (Reflect.field(bitmap.shader, "u_mouse")) {
				Reflect.getProperty(bitmap.shader, "u_mouse").value = [bitmap.mouseX, bitmap.mouseY];
			}
		});

		spr.x = 300;
		spr.y = 300;

		// Haxe To GLSL
		trace(Haxe2GLSL.fragmentSource);
		trace(Haxe2GLSL.vertexSource);

		this.addEventListener(Event.ADDED_TO_STAGE, function(e) {
			stage.addEventListener(MouseEvent.MOUSE_DOWN, function(e) {
				spr.startDrag();
			});
			stage.addEventListener(MouseEvent.MOUSE_UP, function(e) {
				spr.stopDrag();
			});
		});
	}
}
