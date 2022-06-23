package;

import openfl.events.Event;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

/**
 * Shader试验场
 */
class Main extends Sprite {
	public function new() {
		super();
		var img = new Bitmap();
		this.addChild(img);
		img.bitmapData = Assets.getBitmapData("assets/cb_jbt.png");
		img.scaleX = img.scaleY = 2;
		var s = new StatueShader();
		// 绑定偏移纹理
		s.u_movemask.input = Assets.getBitmapData("assets/cb_jbt1.png");
		img.shader = s;
		// 0.35
		this.addEventListener(Event.ENTER_FRAME, function(e) {
			if (s.u_offestY.value[0] < 0.35)
				s.u_offestY.value[0] += 0.0005;
			img.invalidate();
		});

		// 小龙人
		var img = new Bitmap();
		this.addChild(img);
		img.bitmapData = Assets.getBitmapData("assets/cb_zz1.png");
		var s = new Statue2Shader();
		// 绑定偏移纹理
		s.u_movebmd.input = Assets.getBitmapData("assets/cb_zz3.png");
		s.u_movemask.input = Assets.getBitmapData("assets/cb_zz4.png");
		s.u_closebmd.input = Assets.getBitmapData("assets/cb_zz2.png");
		img.shader = s;
		s.u_offestY.value[0] = 1;
		// 0.35
		this.addEventListener(Event.ENTER_FRAME, function(e) {
			if (s.u_offestY.value[0] < 1.095)
				s.u_offestY.value[0] += 0.005;
			// if (s.u_offestY.value[0] > 0)
				// s.u_offestY.value[0] -= 0.005;
			img.invalidate();
		});
		img.x = stage.stageWidth / 2 - img.width / 2;
		img.y = stage.stageHeight / 2 - img.height / 2;
	}
}
