package  {
	import flash.display.MovieClip
	public class Trooper extends MovieClip{
		
		private var design:TrooperLarge = new TrooperLarge();
		public function Trooper() {
			addChild(design);
		}

	}
	
}
