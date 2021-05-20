import glsl.S9GLSL;
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
import glsl.TiledGLSL;
import openfl.events.MouseEvent;
import openfl.events.Event;
import openfl.utils.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

class Main extends Sprite {
	public function new() {
		super();

		var bitmap2 = new Bitmap();
		bitmap2.bitmapData = Assets.getBitmapData("assets/3.png");
		this.addChild(bitmap2);
		bitmap2.shader = new glsl.TiledGLSL(stage.stageWidth, stage.stageHeight);
		bitmap2.width = stage.stageWidth;
		bitmap2.height = stage.stageHeight;

		var bitmap3 = new Bitmap();
		bitmap3.bitmapData = Assets.getBitmapData("assets/img.png");
		this.addChild(bitmap3);
		bitmap3.shader = new glsl.RoundMaskGLSL(10,30,50,30);
		bitmap3.x = 700;
		bitmap3.y = 300;

		var slice = new Bitmap();
		slice.bitmapData = Assets.getBitmapData("assets/slice.png");
		this.addChild(slice);

		var spr:Sprite = new Sprite();
		var bitmap = new Bitmap();
		bitmap.bitmapData = Assets.getBitmapData("assets/slice.png");
		spr.addChild(bitmap);
		this.addChild(spr);

		// 文本渲染
		var text:TextField = new TextField();
		this.addChild(text);
		text.text = "测试文案";
		text.x = 500;
		text.y = 300;
		text.setTextFormat(new TextFormat(null, 120));
		text.width = 600;
		text.height = 300;
		text.mouseEnabled = false;
		text.shader = new glsl.TextGLSL(2, 0xff00ff);

		

		// 从这里更换GLSL目标
		bitmap.scaleX = 10;
		bitmap.scaleY = 10;
		bitmap.shader = new glsl.S9GLSL(52, 53, 73, 52, bitmap.width, bitmap.height);
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
