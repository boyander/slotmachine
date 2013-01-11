package {

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Shape;
	import contingutsMultimedia.Constants;
	import contingutsMultimedia.Spinner;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class Main extends MovieClip {

		public static const FRUIT_SPACING_HEIGHT:Number = 20;
		public static const FRUIT_SPACING_WIDTH:Number = 40;
		public static const GAME_ROWS:Number = 3;
		public static var spinners:Array;
		public static var stopButton:MovieClip;

		// Scores
		public var score:Number;
		public var scoreText:TextField;

		public function Main() {

			// Draw margin boxes for style only
			var b:Sprite = new Sprite();
			b.graphics.beginFill( 0x000000 );  
			b.graphics.drawRect( 0 , 0 , stage.stageWidth , 35);
			addChild(b);
			var b1:Sprite = new Sprite();
			b1.graphics.beginFill( 0x000000 );  
			b1.graphics.drawRect( 0 , stage.stageHeight-135 , stage.stageWidth , stage.stageHeight);
			addChild(b1);
			var b2:Sprite = new Sprite();
			b2.graphics.beginFill( 0x000000 );  
			b2.graphics.drawRect( 0 , 0 , 50 , stage.stageHeight);
			addChild(b2);
			var b3:Sprite = new Sprite();
			b3.graphics.beginFill( 0x000000 );  
			b3.graphics.drawRect( stage.stageWidth - 50 , 0, stage.stageWidth , stage.stageHeight);
			addChild(b3);

			// Set score
			score = 0;
			scoreText = new TextField();
			scoreText.mouseEnabled = false;
			scoreText.autoSize = TextFieldAutoSize.CENTER;
			scoreText.x = stage.stageWidth/2 - scoreText.width/2;
			scoreText.y = 5;
			// Score & Level text format
			var myformat:TextFormat = new TextFormat();
			myformat.color = 0xFFFFFF;
			myformat.size = 30;
			myformat.font = new ScoreFont().fontName;
			scoreText.defaultTextFormat = myformat;
			scoreText.text = "Score: " + String(score);
			this.addChild(scoreText);

			// Stop Button
			stopButton = new pacmanButton();
			stopButton.addEventListener(MouseEvent.CLICK, stopSpinners);
			stopButton.scaleX = stopButton.scaleY = 0.6;
			stopButton.x = stage.stageWidth/2 - stopButton.width/2;
			stopButton.y = stage.stageHeight- stopButton.height-30;
			this.addChild(stopButton)

			// Game screen for spinners
			var sandboxSizeX = 300;
			var sandboxOffset = new Point((stage.stageWidth/2)-sandboxSizeX/2,(stage.stageHeight/2)-50);

			spinners = new Array();
			var _sizeX = (sandboxSizeX/GAME_ROWS) - FRUIT_SPACING_WIDTH;

			// Draw Spinners
			for(var i:uint = 0; i < GAME_ROWS; i++){
				// Create Spinner
				var _position = new Point(((sandboxSizeX/GAME_ROWS)*i + FRUIT_SPACING_WIDTH/2) + sandboxOffset.x,sandboxOffset.y);
				var spinner = new Spinner(_position, _sizeX, String(i));
				spinners.push(spinner);
				this.addChild(spinner);
			}

			// Draw price line
			var line:Shape = new Shape();
			line.graphics.lineStyle(5, 0x336699 ,0.5);
			line.graphics.moveTo(sandboxOffset.x, sandboxOffset.y); 
			line.graphics.lineTo(sandboxOffset.x + sandboxSizeX, sandboxOffset.y);
			this.addChild(line);
		}

		public function ugradeScore(s:Number){
			score += s;
			scoreText.text = "Score: " + String(score);
		}

		public function stopSpinners(e:Event){
			trace("ToggleSpinn");
			for( var i:uint=0; i< spinners.length; i++){
				spinners[i].toggleSpin(false);
			}
		}

	}
}