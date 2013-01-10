package {

	import flash.display.MovieClip;
	import contingutsMultimedia.Constants;
	import contingutsMultimedia.Spinner;
	import flash.geom.Point;

	public class Main extends MovieClip {

		public static const FRUIT_SPACING_WIDTH:Number = 40;
		public static const GAME_ROWS:Number = 3;

		public function Main() {
			trace("Starting game!");

			// Game screen for spinners
			var sandboxSizeX = 300;
			var sandboxOffset = new Point((stage.stageWidth/2)-sandboxSizeX/2);

			// Draw Spinners
			for(var i:uint = 0; i < GAME_ROWS; i++){
				var _position = new Point(((sandboxSizeX/GAME_ROWS)*i + FRUIT_SPACING_WIDTH/2) + sandboxOffset.x, stage.stageWidth/2);
				var _sizeX = (sandboxSizeX/GAME_ROWS) - FRUIT_SPACING_WIDTH;

				// Create Spinner
				var spinner = new Spinner(_position,_sizeX);
				this.addChild(spinner);
			}
		}

	}
}