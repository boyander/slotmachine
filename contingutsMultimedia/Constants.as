package contingutsMultimedia{

	import flash.display.MovieClip;

	public class Constants{

		// Fruits definition and graphicClip for each one
		public static const FRUIT_APPLE:String = "Apple";
		public static const FRUIT_BANANA:String = "Banana";
		public static const FRUIT_BROCCOLI:String = "Broccoli";
		public static const FRUIT_CABAGGE:String = "Cabbage";
		public static const FRUIT_CHERRY:String = "Cherry2";
		public static const FRUIT_CORN:String = "Corn";
		public static const FRUIT_GARLIC:String = "Garlic";
		public static const FRUIT_GRAPES:String = "Grapes";
		public static const FRUIT_NICEFRUIT:String = "Nicefruit";
		public static const FRUIT_ORANGE:String = "Orange";
		public static const FRUIT_PEAR:String = "Pear";
		public static const FRUIT_PINEAPPLE:String = "Pineapple";
		public static const FRUIT_RADISH:String = "Radish";
		public static const FRUIT_STRAWBERRY:String = "Strawberry";
		public static const FRUIT_STRAWBERRYCHEESE:String = "StrawberryCheese";
		public static const FRUIT_SUNFRUIT:String = "Sunfruit";
		public static const FRUIT_SUPERFRUIT:String = "Superfruit";

		// Returns fruits scores, graphics and probabilities
		public static function getFruits(){
			var fruits:Array = [{
					name: "Apple",
					graphicsImplement:FRUIT_APPLE,
					score: 200.0
				},{
					name: "Banana",
					graphicsImplement:FRUIT_BANANA,
					score: 100.0
				},{
					name: "Orange",
					graphicsImplement:FRUIT_ORANGE,
					score: 50.0
				},{
					name: "Strawberry",
					graphicsImplement:FRUIT_STRAWBERRY,
					score: 25.0
				},{
					name: "Superfruit",
					graphicsImplement:FRUIT_SUPERFRUIT,
					score: 25.0
				},{
					name: "Corn",
					graphicsImplement:FRUIT_CORN,
					score: 25.0
				}];
			return fruits;
		}
	}
}