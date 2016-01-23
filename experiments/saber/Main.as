package  {
	import flash.display.MovieClip;
	import flash.ui.Mouse;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	
	
	public class Main extends MovieClip{
		private var saber:Lightsaber = new Lightsaber();
		//private var laser:Laser = new Laser();
		private var lasers:Array = new Array();
		private var ctrl:Boolean = false;
		private var timer:Timer = new Timer(750, 1);
		private var trooper:Trooper = new Trooper();
		private var hurt:Hurt = new Hurt();
		
		public function Main() {
			addChild(trooper);
			trooper.x=stage.stageWidth/2;
			trooper.y=stage.stageHeight/2;
			
			trooper.z=1500;
			timer.addEventListener(TimerEvent.TIMER,timerListener);
			addEventListener(Event.ENTER_FRAME,loop);
			//addChild(laser);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUp);
			stage.addEventListener(MouseEvent.CLICK,click);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
			timer.start();
			addChild(saber);
			saber.x = stage.stageWidth/2;
			saber.y = 350;
			Mouse.hide();
			addChild(hurt);
			hurt.alpha = 0;
			this.addEventListener(MouseEvent.MOUSE_MOVE,saber.motionDetection);
		}
		
		public function timerListener(e:TimerEvent)
		{
			lasers.push(new Laser());
			lasers[lasers.length-1].x = stage.stageWidth/2;
			lasers[lasers.length-1].y = stage.stageHeight/2;
			//lasers[lasers.length-1].y = Math.random()*300+100;
			addChild(lasers[lasers.length-1]);
			timer.reset();
			timer.delay=Math.random()*1000+200;
			lasers[lasers.length-1].x+=Math.random()*20;
		}
		
		
		public function loop(e:Event)
		{
			saber.draw();
			
			for each(var l in lasers)
			{
				l.move();
				l.collision(saber);
				//hurt.alpha = 1;
				if(l.x>stage.stageWidth+lasers[0].width||l.x<0-lasers[0].width||l.y>stage.stageHeight+lasers[0].width||l.y<0-lasers[0].width||l.z>10000)
				{
					lasers.splice(lasers.indexOf(l),1);
					removeChildAt(getChildIndex(l));
					
				}
				if(!l.hitTestObject(hurt)&&!l.outField&&l.z<0)//if laser has passed the stage
				{
					hurt.alpha = 0.5;
					var mySound:Sound = hurt.sounds[(int)(Math.random()*hurt.sounds.length)];
					mySound.play();
					l.outField=true;
				}
				if(!saber.on)
				{
					timer.stop();
				}
				if(saber.on&&!timer.running)
				{
					timer.reset();
			timer.delay=Math.random()*1000+200;
					timer.start();
				}
				
			}
			if(hurt.alpha>0)
				{
					hurt.alpha-=0.1;
				}
			
			
			
			
		
			
			
			
			
		}
		
		public function mouseMove(e:MouseEvent)
		{	
			var denominator:int = 4;
			var zMax:int = 135;
			if(!ctrl)
			{
				saber.rotationZ = -1*zMax*Math.sin(Math.PI*(mouseX-stage.stageWidth/2)/(stage.stageWidth));	
				
			}
			
			
			
			//trace(saber.rotationZ);
			
			saber.x = mouseX;
			saber.y = mouseY;
		}
		
		public function click(e:MouseEvent)
		{
			//saber.toggle();
		}
		
		
		public function keyDown(e:KeyboardEvent)
		{
			switch(e.keyCode)
			{
				case Keyboard.CONTROL: ctrl = true;break;
				case Keyboard.SPACE: saber.toggle();
			}
			//saber.toggle();
			
		}
		
		public function keyUp(e:KeyboardEvent)
		{
			switch(e.keyCode)
			{
				case Keyboard.CONTROL: ctrl = false;break;
			}
		}

	}
	
}
