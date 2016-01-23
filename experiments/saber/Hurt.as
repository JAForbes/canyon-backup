package  {
	import flash.display.MovieClip;
	
	public class Hurt extends MovieClip
	{
		private var design:Hurt_design = new Hurt_design();
		public var sounds:Array = new Array();
		public function Hurt() {
			addChild(design);
			sounds.push(new pain1(),new pain2(),new pain3(),new pain4(),new pain5(),new pain6(),new pain7(),new pain8());
		}

	}
	
}
