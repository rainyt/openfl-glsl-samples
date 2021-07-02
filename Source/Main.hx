import openfl.geom.Matrix3D;
import openfl.geom.Matrix;
import glsl.GPUParticle;
import openfl.display.BlendMode;
import openfl.display.GraphicsShader;
import openfl.display.FPS;
import glsl.CircleCdGLSL;
import glsl.S9GLSL;
import glsl.TextGLSL;
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
import glsl.AttributesGLSL;
import glsl.Haxe2GLSL;
import glsl.VertexGLSL;
import glsl.LightEffect;
import glsl.LightPointRotation;
import glsl.MouseGLSL;
import glsl.TiledGLSL;
import openfl.events.MouseEvent;
import openfl.events.Event;
import openfl.utils.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.Vector;

class Main extends Sprite {
	public function new() {
		super();

		var mat4 =new Matrix();
		mat4.translate(100,100);
		trace(mat4);

		var d = Matrix3D;


		var bitmap2 = new Bitmap();
		bitmap2.bitmapData = Assets.getBitmapData("assets/3.png");
		this.addChild(bitmap2);
		bitmap2.shader = new glsl.TiledGLSL(stage.stageWidth, stage.stageHeight);
		bitmap2.width = stage.stageWidth;
		bitmap2.height = stage.stageHeight;

		var bitmap3 = new Bitmap();
		bitmap3.bitmapData = Assets.getBitmapData("assets/img.png");
		this.addChild(bitmap3);
		bitmap3.shader = new glsl.RoundMaskGLSL(10, 30, 50, 30);
		bitmap3.x = 700;
		bitmap3.y = 300;

		var slice = new Bitmap();
		slice.bitmapData = Assets.getBitmapData("assets/slice.png");
		this.addChild(slice);

		var spr:Sprite = new Sprite();
		var bitmap = new Bitmap();
		bitmap.bitmapData = Assets.getBitmapData("assets/img.png");
		spr.addChild(bitmap);
		this.addChild(spr);

		// 文本渲染
		// var text:TextField = new TextField();
		// this.addChild(text);
		// text.text = "测试文案";
		// text.x = 500;
		// text.y = 300;
		// text.setTextFormat(new TextFormat(null, 120, 0x9b3e00));
		// text.width = 600;
		// text.height = 300;
		// text.mouseEnabled = false;
		// text.shader = new glsl.TextGLSL(1, 0x9b3e00);

		// 从这里更换GLSL目标
		bitmap.width = 1200;
		bitmap.height = 1200;
		bitmap.shader = new GPUParticle(stage);
		// bitmap.blendMode = BlendMode.MULTIPLY;
		bitmap.addEventListener(Event.ENTER_FRAME, function(e) {
			bitmap.invalidate();
		});
		// 新增鼠标事件
		stage.addEventListener(MouseEvent.MOUSE_MOVE, function(e:MouseEvent) {
			if (Reflect.field(bitmap.shader, "u_mouse")) {
				Reflect.getProperty(bitmap.shader, "u_mouse").value = [bitmap.mouseX, bitmap.mouseY];
			}
		});

		var spr2:Sprite = new Sprite();
		this.addChild(spr2);
		var imgbitmap = Assets.getBitmapData("assets/img.png");
		var shader = new AttributesGLSL();
		@:privateAccess shader.bitmap.input = imgbitmap;
		spr2.graphics.beginShaderFill(shader);

		var v1:Array<Float> = [
			0,
			0,
			imgbitmap.width * 0.8,
			0,
			imgbitmap.width,
			imgbitmap.height,
			0,
			imgbitmap.height
		];
		var v2:Array<Int> = [0, 1, 2, 2, 3, 0];
		var v3:Array<Float> = [0, 0, 1, 0, 1, 1, 0, 1];
		spr2.graphics.drawTriangles(ofArray(v1), ofArray(v2), ofArray(v3));
		spr2.graphics.endFill();
		spr2.x = 500;
		spr2.y = 600;
		spr2.mouseChildren = false;
		spr2.mouseEnabled = false;

		// Haxe To GLSL
		// trace(Haxe2GLSL.fragmentSource);
		// trace(Haxe2GLSL.vertexSource);

		this.addEventListener(Event.ADDED_TO_STAGE, function(e) {
			stage.addEventListener(MouseEvent.MOUSE_DOWN, function(e) {
				spr.startDrag();
			});
			stage.addEventListener(MouseEvent.MOUSE_UP, function(e) {
				spr.stopDrag();
			});
		});

		var fps:FPS = new FPS();
		this.addChild(fps);

		stage.frameRate = 60;
	}

	@:generic public inline static function ofArray<T>(array:Array<T>):Vector<T> {
		var vector:Vector<T> = new Vector<T>();

		for (i in 0...array.length) {
			vector[i] = cast array[i];
		}

		return vector;
	}
}
