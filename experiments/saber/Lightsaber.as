package  {
	import flash.display.MovieClip;
	import flash.filters.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Lightsaber extends MovieClip{
		public var saber_design:Saber_design = new Saber_design();
		public var blade_design:Blade_design = new Blade_design();
		public var on:Boolean = false;
		private var glowLevel:int = 0;
		private var glowGrow:Boolean = true;
		private var idleChannel:SoundChannel = new SoundChannel();
		private var idleSound:Sound = new Sound();
		public var hitSounds:Array = new Array();
		public var swingSounds:Array = new Array();
		private var oldX:int = 0;
		private var oldY:int = 0;
		private var newX:int = 0;
		private var newY:int = 0;
		private var xSpeed:int = 0;
		private var ySpeed:int = 0;
		
		public function Lightsaber() {
			addChild(blade_design);
			addChild(saber_design);
			
			
			var myGlow:GlowFilter = new GlowFilter();
			myGlow.blurX = 10;
			myGlow.blurY = 10;
			blade_design.filters = [myGlow];
			
			blade_design.y-=saber_design.height-27;
			blade_design.x+=1;
			if(!on)
			{
				blade_design.scaleY=0;
			}
			
			if(on)
			{
				idleSound = new saberIdle();
				
				idleChannel = idleSound.play();
				idleChannel.addEventListener(Event.SOUND_COMPLETE, playIdle);
			}
			hitSounds.push(new saberHit0(),new saberHit1(),new saberHit2(),new saberHit3(),new saberHit4());
			swingSounds.push(new saberSwing0(),new saberSwing1(),new saberSwing2(),new saberSwing3(),new saberSwing3(),new saberSwing4(),new saberSwing5(),new saberSwing6(),new saberSwing7())
		}
		
		public function draw():void
		{
			
			drawBlade();
			var myGlow:GlowFilter = new GlowFilter();
			
			myGlow.blurX = glowLevel;
			myGlow.blurY = glowLevel;
			blade_design.filters = [myGlow];
			oscillateGlow();
			
			if(idleChannel.position>0)
			{
				if(!on)
				{
					idleChannel.stop();
				}
			}
		}
		
		public function motionDetection(e:MouseEvent)
		{
			newY = mouseY;
			ySpeed = newY - oldY;
			oldY = newY;
  			
			newX = mouseX;
			xSpeed = newX - oldX;
			oldX = newX;
			if((xSpeed>6||ySpeed>6)&&(on))
			{
				var mySound:Sound = swingSounds[(int)(Math.random()*swingSounds.length)]; 
				mySound.play();
			}
			
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
			if(on)
			{
				var mySound:Sound = new saberOn(); 
				mySound.play();
				idleSound = new saberIdle();
			
			idleChannel = idleSound.play();
			idleChannel.addEventListener(Event.SOUND_COMPLETE, playIdle);
			}
			else
			{
				mySound = new saberOff(); 
				mySound.play();
				idleChannel.stop();
			}
		}
		
		public function playIdle(e:Event)//doesn't loop perfectly
		{
			
			idleSound = new saberIdle();
			
			idleChannel = idleSound.play();
			idleChannel.addEventListener(Event.SOUND_COMPLETE, playIdle);
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
