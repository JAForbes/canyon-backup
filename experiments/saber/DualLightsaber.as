package  {
	import flash.display.MovieClip;
	import flash.filters.*;
	
	public class DualLightsaber extends MovieClip{
		public var saber_design:Saber_design = new Saber_design();
		public var blade_design:Blade_design = new Blade_design();
		public var blade_design2:Blade_design = new Blade_design();
		public var on:Boolean = false;
		private var glowLevel:int = 0;
		private var glowGrow:Boolean = true;
		
		public function DualLightsaber() {
			addChild(blade_design);
			addChild(blade_design2);
			addChild(saber_design);
			
			

			var myGlow:GlowFilter = new GlowFilter();
			myGlow.blurX = 10;
			myGlow.blurY = 10;
			blade_design.filters = [myGlow];
			
			blade_design.y-=saber_design.height-20;
			blade_design.x+=1;
			blade_design2.y+=20;
			blade_design2.x+=2;
			blade_design2.rotation+=180;
			if(!on)
			{
				blade_design.scaleY=0;
			}

			

			
			
			
		}
		
		public function draw():void
		{
			drawBlade();
			blade_design2.scaleY=blade_design.scaleY;
			var myGlow:GlowFilter = new GlowFilter();
			
			myGlow.blurX = glowLevel;
			myGlow.blurY = glowLevel;
			blade_design.filters = [myGlow];
			blade_design2.filters = [myGlow];
			oscillateGlow();
		}
		
		public function oscillateGlow()
		{
			
			if(glowLevel>15)
			{
				glowGrow=false;
			}
			else if(glowLevel<0)
			{
				glowGrow=true;
			}
			if(glowGrow)
			{
				glowLevel+=1;
			}
			else
			{
				glowLevel-=1;
			}
		}
		
		public function turnOn():void
		{
			on = true;
		}
		
		public function turnOff():void
		{
			on = false;
		}
		
		public function toggle():void
		{
			on = !on;
		}
		
		public function drawBlade()
		{
			if(on&&blade_design.scaleY<1)
			{
				blade_design.scaleY+=0.2;
			}
			if(!on&&blade_design.scaleY>0)
			{
				blade_design.scaleY-=0.2;
			}
			if(blade_design.scaleY<0)
			{
				blade_design.scaleY=0;
			}
			if(blade_design.scaleY>1)
			{
				blade_design.scaleY=1;
			}
		}

	}
	
}
