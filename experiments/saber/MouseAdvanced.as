package  {
	
	public class MouseAdvanced {
		public static var prevX:int = 0;
		public static var prevY:int = 0;
		public static var curX:int = 0;
		public static var curY:int = 0;
		public function MouseAdvanced() {
			
		}
		
		public static function directionHorizontal():int
		{
			var dirX:int = 0;
			
			 
			if (prevX > curX) {
			dirX = -1;
			} else if (prevX < curX) {
			dirX = +1;
			} else {
			dirX = 0;
			}
			 
			return dirX;
		}
		
		public static function directionVertical():int
		{
			var dirY:int = 0;
			 
			if (prevY > curY) {
			dirY = -1;
			} else if (prevY < curY) {
			dirY = +1;
			} else {
			dirY = 0;
			}
			 
			return dirY;
		}
			
		

	}
	
}
