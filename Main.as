/*
Project: SlotMachine 
Authors: Marc Pomar
Contact: boyander@gmail.com
Description:
	Main game class
*/

package {

	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.display.Sprite;
	import flash.display.Shape;
	import contingutsMultimedia.Constants;
	import contingutsMultimedia.Spinner;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class Main extends MovieClip {

		public static const FRUIT_SPACING_HEIGHT:Number = 20;
		public static const FRUIT_SPACING_WIDTH:Number = 40;
		public static const GAME_SPINNERS:Number = 3;
		public static var spinners:Array;
		public static var stopButton:MovieClip;

		// Scores
		public var score:Number;
		public var scoreText:TextField;

		public var spinnerCount:Number;

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
			var _sizeX = (sandboxSizeX/GAME_SPINNERS) - FRUIT_SPACING_WIDTH;

			spinnerCount = 0;

			// Draw Spinners
			for(var i:uint = 0; i < GAME_SPINNERS; i++){
				// Create Spinner
				var _position = new Point(((sandboxSizeX/GAME_SPINNERS)*i + FRUIT_SPACING_WIDTH/2) + sandboxOffset.x,sandboxOffset.y);
				var spinner = new Spinner(_position, _sizeX, String(i));
				spinner.addEventListener("SpinnerStop", processSpinners);
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

		public function processSpinners(e:Event){
			if(spinnerCount == GAME_SPINNERS-1){
				// Check price
				var price:Boolean = true;
				for(var i:uint = 0; i < GAME_SPINNERS; i++){
					spinnerCount = 0;
					trace(spinners[i].getWinner().name);
					if(i > 0){
						if (spinners[i-1].getWinner().name != spinners[i].getWinner().name){
							price = false;
						}
					}
				}

				// Upgrade Score
				if(price){
					upgradeScore(spinners[0].getWinner().score);
					trace("You win " + spinners[0].getWinner().score + "!");
				}else{
					trace("Oh sorry, better next time!");
					upgradeScore(-5);
				}

				// Nextplay timer
				var timer:Timer = new Timer(2000,1);
				timer.addEventListener(TimerEvent.TIMER, function (e:TimerEvent){
					trace("Go for next play!");
					stopButton.addEventListener(MouseEvent.CLICK, stopSpinners);
					for(var i:uint = 0; i < GAME_SPINNERS; i++){
						spinners[i].reset();
					}
				});
				timer.start();

			}else{
				spinnerCount++;
			}
		}

		public function upgradeScore(s:Number){
			score += s;
			scoreText.text = "Score: " + String(score);
		}

		public function stopSpinners(e:Event){
			// Remove button listener
			stopButton.removeEventListener(MouseEvent.CLICK, stopSpinners);

			// Make spinners spin
			for( var i:uint=0; i< spinners.length; i++){
				spinners[i].toggleSpin(false);
			}

		}

	}
}