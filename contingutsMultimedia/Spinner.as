package contingutsMultimedia{

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import contingutsMultimedia.Constants;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import flash.events.Event;
	import flash.filters.*;
	import com.gskinner.motion.GTween;
	import com.gskinner.motion.plugins.*;
	import com.gskinner.motion.easing.*;


	public class Spinner extends MovieClip {

		public static const FRUIT_SPACING_HEIGHT:Number = 20;
		public static const MAX_SPEED:Number = 25;
		public static const ACCELERATION:Number = 0.18;

		public var fruitsArray:Array;
		public var _speed:Number;
		public var _sizeX:Number;
		public var numfruits:Number;
		var blur:BlurFilter = new BlurFilter();

		public function Spinner(pos:Point,sizeX:Number,fruits:Number=3){
			MotionBlurPlugin.install();
			this.x = pos.x;
			this.y = pos.y - ((fruits)*(FRUIT_SPACING_HEIGHT+sizeX)) - 2*FRUIT_SPACING_HEIGHT;
			fruitsArray = new Array();
			_speed = 0;
			_sizeX = sizeX;
			numfruits = 15;
			blur = new BlurFilter(0,0,1);
			this.drawColumn();
			this.addEventListener(Event.ENTER_FRAME,frameUpdate);

			// Mask
			var mask:Sprite = new Sprite();
			mask.graphics.beginFill( 0x000000 );  
			mask.graphics.drawRect( 0 , FRUIT_SPACING_HEIGHT+sizeX , sizeX , fruits*(FRUIT_SPACING_HEIGHT+sizeX) );
			mask.x = 0;
			mask.y = 0;
			addChild(mask);
			this.mask = mask;
		}

		public function frameUpdate(e:Event){
			for(var i:uint=0; i < fruitsArray.length; i++){
				blur.blurY = 20*(_speed/MAX_SPEED);
				fruitsArray[i].filters = [blur];
				if(Math.abs(_speed) < MAX_SPEED){
					_speed += ACCELERATION;
				}
				fruitsArray[i].y = (fruitsArray[i].y + _speed) % ((numfruits)*(FRUIT_SPACING_HEIGHT+_sizeX)+FRUIT_SPACING_HEIGHT);
			}
		}

		public function drawColumn(){
			var fruits:Array = Constants.getFruits();
			for(var i:uint=0; i < numfruits; i++){
				var fruitIndex:Number = Math.floor(Math.random()*fruits.length);
				var fruit = fruits[fruitIndex];
				
				// Scaling
				var definedImplementation:Class = getDefinitionByName(fruits[fruitIndex].graphicsImplement) as Class;
				var fruitGraphic:MovieClip = new definedImplementation();
				this.resize(fruitGraphic,_sizeX,_sizeX);

				// Positioning
				var _align = _sizeX - fruitGraphic.height;
				fruitGraphic.y = (i * (_sizeX + FRUIT_SPACING_HEIGHT)) + _align;
				this.addChild(fruitGraphic);
				fruitsArray.push(fruitGraphic);
			}
		}

		public function resize(mc:MovieClip, maxW:Number, maxH:Number=0, constrainProportions:Boolean=true):void{
		    maxH = maxH == 0 ? maxW : maxH;
		    mc.width = maxW;
		    mc.height = maxH;
		    if (constrainProportions) {
		        mc.scaleX < mc.scaleY ? mc.scaleY = mc.scaleX : mc.scaleX = mc.scaleY;
		    }
		}

	}
}