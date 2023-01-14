import glsl.GLSL;
import openfl.text.TextFormat;
import openfl.text.TextField;
import glsl.GLSL.texture2D;
import VectorMath;
import glsl.OpenFLShader;
import openfl.display.Bitmap;
import openfl.Assets;
import openfl.display.Sprite;

class Main extends Sprite {
	public function new() {
		super();

		var bitmap = new Bitmap(Assets.getBitmapData("assets/img.png"));
		this.addChild(bitmap);
		bitmap.x = (stage.stageWidth - bitmap.width) / 2;
		bitmap.y = (stage.stageHeight - bitmap.height) / 2;
		var outline = new OutlineShader();
		outline.u_quality.value = [2];
		outline.u_outlineColor.value = [1, 1, 0, 1];
		outline.u_outlineSize.value = [3];
		bitmap.shader = outline;

		var bitmap = new Bitmap(Assets.getBitmapData("assets/me1250.png"));
		this.addChild(bitmap);
		bitmap.x = (stage.stageWidth - bitmap.width) / 2 - 200;
		bitmap.y = (stage.stageHeight - bitmap.height) / 2 + 200;

		var bitmap = new Bitmap(Assets.getBitmapData("assets/me1250.png"));
		this.addChild(bitmap);
		bitmap.x = (stage.stageWidth - bitmap.width) / 2;
		bitmap.y = (stage.stageHeight - bitmap.height) / 2 + 200;
		var outline = new OutlineShader();
		outline.u_quality.value = [2];
		outline.u_outlineColor.value = [1, 1, 0, 1];
		outline.u_outlineSize.value = [3];
		outline.u_showout.value = [true];
		bitmap.shader = outline;

		var bitmap = new Bitmap(Assets.getBitmapData("assets/me1250.png"));
		this.addChild(bitmap);
		bitmap.x = (stage.stageWidth - bitmap.width) / 2 + 200;
		bitmap.y = (stage.stageHeight - bitmap.height) / 2 + 200;
		var outline = new OutlineShader();
		outline.u_quality.value = [2];
		outline.u_hdrStrength.value = [0.3];
		outline.u_outlineColor.value = [1, 1, 0, 1];
		outline.u_outlineSize.value = [3];
		outline.u_showout.value = [false];
		bitmap.shader = outline;

		var bitmap = new Bitmap(Assets.getBitmapData("assets/me1250.png"));
		this.addChild(bitmap);
		bitmap.x = (stage.stageWidth - bitmap.width) / 2 + 200;
		bitmap.y = (stage.stageHeight - bitmap.height) / 2 - 100;
		var outline = new OutlineShader();
		outline.u_quality.value = [10];
		outline.u_hdrStrength.value = [0.3];
		outline.u_outlineColor.value = [1, 1, 0, 1];
		outline.u_outlineSize.value = [0];
		outline.u_showout.value = [false];
		bitmap.shader = outline;

		var bitmap = new Bitmap(Assets.getBitmapData("assets/me1250.png"));
		this.addChild(bitmap);
		bitmap.scaleX = bitmap.scaleY = 1;
		bitmap.x = (stage.stageWidth - bitmap.width) / 2 - 200;
		bitmap.y = (stage.stageHeight - bitmap.height) / 2 - 100;
		var outline = new OutlineShader();
		outline.u_quality.value = [90];
		outline.u_hdrStrength.value = [0.];
		outline.u_outlineColor.value = [1, 1, 0, 1];
		outline.u_outlineSize.value = [13];
		outline.u_showout.value = [false];
		bitmap.shader = outline;

		stage.color = 0x0;

		var text = new TextField();
		this.addChild(text);
		text.width = 800;
		text.height = 264;
		text.text = "测试文字 TEST";
		text.setTextFormat(new TextFormat(null, 64, 0xff0000));
		var outline = new OutlineShader();
		outline.u_quality.value = [10];
		outline.u_outlineColor.value = [1, 1, 0, 1];
		outline.u_outlineSize.value = [3];
		outline.u_showout.value = [false];
		text.shader = outline;

		var text = new TextField();
		this.addChild(text);
		text.width = 800;
		text.height = 264;
		text.y = 100;
		text.text = "测试文字 TEST";
		text.setTextFormat(new TextFormat(null, 64, 0xff0000));
		var outline = new OutlineShader();
		outline.u_quality.value = [10];
		outline.u_outlineColor.value = [1, 1, 0, 1];
		outline.u_outlineSize.value = [3];
		outline.u_showout.value = [true];
		text.shader = outline;
	}
}

/**
 * Outline支持
 */
@:debug
class OutlineShader extends OpenFLShader {
	/**
	 * 边缘颜色
	 */
	@:uniform
	public var outlineColor:Vec4;

	/**
	 * 边缘大小
	 */
	@:uniform
	public var outlineSize:Float;

	/**
	 * 质量，有效值在1-90
	 */
	@:uniform
	public var quality:Float;

	/**
	 * 是否只显示外框，0为显示全部，1为挖空显示
	 */
	@:uniform
	public var showout:Bool;

	/**
	 * HDR光效，有效值0-1
	 */
	@:uniform
	public var hdrStrength:Float;

	@:glsl
	public function texColor(color1:Vec4, color2:Vec4):Vec4 {
		return outlineColor * max(0, (color1.a - color2.a));
	}

	override function fragment() {
		super.fragment();
		var uv:Vec2 = 1 / gl_openfl_TextureSize;
		var times:Int = int(quality * 4.);
		var setp:Float = 6.28 / float(times);
		var outcolor:Vec4 = color;
		var light:Float = 0.;
		for (i in 0...360) {
			if (i > times) {
				break;
			}
			var r:Float = setp * float(i);
			var offestCenter:Vec2 = vec2(uv.x * outlineSize * sin(r), uv.y * outlineSize * cos(r));
			var copy:Vec4 = texture2D(gl_openfl_Texture, gl_openfl_TextureCoordv + offestCenter);
			// 这里可能还可以细节一些？
			outcolor += texColor(copy, color) * (1 - color.a) * (1 - color.a) * (1 - color.a);
			// 光亮效果
			light += (copy.r + copy.g + copy.b) / 3.;
		}
		// 这是挖空实现
		if (showout) {
			this.gl_FragColor = outcolor * (1 - color.a);
		} else {
			outcolor += color * (light / (float(times) / 8)) * hdrStrength;
			this.gl_FragColor = outcolor;
		}
		// this.gl_FragColor = color + color * light * 0.3;
	}
}

// var offestX:Vec2 = vec2(uv.x * outlineSize, 0);
// var offestY:Vec2 = vec2(0, uv.y * outlineSize);
// var offestCenter:Vec2 = vec2(uv.x * outlineSize, uv.y * outlineSize);
// var copy1:Vec4 = texture2D(gl_openfl_Texture, gl_openfl_TextureCoordv + offestX);
// var copy2:Vec4 = texture2D(gl_openfl_Texture, gl_openfl_TextureCoordv - offestX);
// var copy3:Vec4 = texture2D(gl_openfl_Texture, gl_openfl_TextureCoordv + offestY);
// var copy4:Vec4 = texture2D(gl_openfl_Texture, gl_openfl_TextureCoordv - offestY);
// var copy5:Vec4 = texture2D(gl_openfl_Texture, gl_openfl_TextureCoordv + vec2(-offestCenter.x, -offestCenter.y));
// var copy6:Vec4 = texture2D(gl_openfl_Texture, gl_openfl_TextureCoordv + vec2(offestCenter.x, -offestCenter.y));
// var copy7:Vec4 = texture2D(gl_openfl_Texture, gl_openfl_TextureCoordv + vec2(offestCenter.x, offestCenter.y));
// var copy8:Vec4 = texture2D(gl_openfl_Texture, gl_openfl_TextureCoordv + vec2(-offestCenter.x, offestCenter.y));
// this.gl_FragColor = color + texColor(copy1, color) + texColor(copy2, color) + texColor(copy3, color) + texColor(copy4, color)
// + texColor(copy5, color) + texColor(copy6, color) + texColor(copy7, color) + texColor(copy8, color);
