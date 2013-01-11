package contingutsMultimedia{

	import flash.display.MovieClip;
	import flash.display.Sprite;

	import contingutsMultimedia.Constants;
	import contingutsMultimedia.Fruit;

	import flash.geom.Point;
	import flash.events.Event;
	import flash.filters.*;

	public class Spinner extends Sprite {

		public static const FRUIT_SPACING_HEIGHT:Number = 20;
		public static const MAX_SPEED:Number = 25;
		public static const ACCELERATION:Number = 0.18;

		public var fruitsArray:Array;
		public var _speed:Number;
		public var _sizeX:Number;
		public var numfruits:Number;
		var blur:BlurFilter = new BlurFilter();
		public var _acceleration:Number;
		public var _isSpinning:Boolean;
		public var _spinnername:String;

		public function Spinner(pos:Point,sizeX:Number,nameS:String,fruits:Number=3){
			this.x = pos.x;
			this.y = pos.y - fruits * (FRUIT_SPACING_HEIGHT+sizeX) + FRUIT_SPACING_HEIGHT +sizeX/2;
			fruitsArray = new Array();
			_speed = 0;
			_sizeX = sizeX;
			numfruits = 25;
			blur = new BlurFilter(0,0,1);
			this.addEventListener(Event.ENTER_FRAME,frameUpdate);
			_acceleration = ACCELERATION;
			_isSpinning = true;
			_spinnername = nameS;

			// Mask
			var mask:Sprite = new Sprite();
			mask.graphics.beginFill( 0x000000 );  
			mask.graphics.drawRect( 0 , sizeX , sizeX , fruits*(FRUIT_SPACING_HEIGHT+sizeX) + FRUIT_SPACING_HEIGHT );
			mask.x = 0;
			mask.y = 0;
			addChild(mask);
			this.mask = mask;

			this.drawColumn();
		}

		public function toggleSpin(b:Boolean){
			if(b){
				_isSpinning = true;
				_acceleration = ACCELERATION;
			}else{
				_isSpinning = false;
				_acceleration = -1 * ACCELERATION/3;
			}
		}

		public function frameUpdate(e:Event){
			for(var i:uint=0; i < fruitsArray.length; i++){
				var fruitClip:MovieClip = fruitsArray[i].graphic;

				blur.blurY = 20*(_speed/MAX_SPEED);
				fruitClip.filters = [blur];

				_speed += _acceleration;

				if(_speed > MAX_SPEED && _isSpinning){
					_speed = MAX_SPEED;
				}

				if(_speed < 5 && !_isSpinning){
					_acceleration = 0;
					if(fruitClip.y - _sizeX <= ((2*(FRUIT_SPACING_HEIGHT+_sizeX)) - FRUIT_SPACING_HEIGHT - _sizeX/2 + 2) 
						&& fruitClip.y - _sizeX >= ((2*(FRUIT_SPACING_HEIGHT+_sizeX)) - FRUIT_SPACING_HEIGHT - _sizeX/2 - 2)){
						_speed = 0;
						trace("[Spinner " + this._spinnername + "] -> " + fruitsArray[i].name);
						_isSpinning = true;
					}
				}

				fruitClip.y = (fruitClip.y + _speed) % ((numfruits)*(FRUIT_SPACING_HEIGHT+_sizeX)+FRUIT_SPACING_HEIGHT);
			}
		}

		public function drawColumn(){
			var fruits:Array = Constants.getFruits();
			for(var i:uint=0; i < numfruits; i++){
				var fruitIndex:Number = Math.floor(Math.random()*fruits.length);
				var fr:Fruit = new Fruit(fruits[fruitIndex],_sizeX);
				
				// Positioning
				var _align = _sizeX - fr.graphic.height;
				fr.graphic.y = (i * (_sizeX + FRUIT_SPACING_HEIGHT)) + _align;
				this.addChild(fr.graphic);
				fruitsArray.push(fr);
			}
		}

	}
}