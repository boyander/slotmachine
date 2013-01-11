package contingutsMultimedia{
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;


	public class Fruit{

		public var graphic:MovieClip;
		public var score:Number;
		public var name:String

		public function Fruit(_fruitConstant:Object,_sizeX:Number){
				var definedImplementation:Class = getDefinitionByName(_fruitConstant.graphicsImplement) as Class;
				graphic = new definedImplementation();
				resize(graphic,_sizeX,_sizeX);

				name = _fruitConstant.name;
				score = _fruitConstant.score;
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