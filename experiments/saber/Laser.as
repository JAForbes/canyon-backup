package  {
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	public class Laser extends MovieClip{
		private var design:Laser_design = new Laser_design();
		private var vx:Number,vy:Number,vz:Number;
		public var deflected:Boolean = false;
		public var outField:Boolean = false;
		private var sounds:Array = new Array();
		
		/*
		Trajectory is reversed by light saber deflection
		saber vx,vy,vz and laser blast vx,vy,vz
		vector addition
		
		deflection only occurs of the saber collides with the blast tip not the tail.
		
		*/
		public function Laser() {
			addChild(design);
			sounds.push(new laser1(), new laser2(), new laser3());
			var mySound:Sound = sounds[(int)(Math.random()*sounds.length)];
			var myChannel:SoundChannel = mySound.play();
			
			var myTransform = new SoundTransform();
			myTransform.volume = Math.random();
			myChannel.soundTransform = myTransform;
			vx=Math.random()*10*even();
			vy=Math.random()*10;
			vz=-105;
			//x=0;
			//y=0;
			z=2000;
			
		}
		
		public function collision(saber:Lightsaber)
		{
			
			if(this.hitTestObject(saber.blade_design))
			{
				if(z<-100)
				{
					if(vz<0&&!deflected)
					{
						/*vz= -vz*Math.random()*3;
						vy= -vy*Math.random()*3;
						vx= -vx*Math.random()*3;*/
						vz= -vz*1;
						vy= -vy*1*even();
						vx= -vx*1*even();
						deflected=true;
						var mySound:Sound = saber.hitSounds[(int)(Math.random()*saber.hitSounds.length)]; 
						mySound.play();
					}
				}
			}
		}
		
		public function even():int
		{
			var even:Number = Math.random();
			if(even>0.5)
			{
				even=-1;
			}
			else
			{
				even=1;
			}
			return even;
		}
		
		public function move()
		{
			
				x+=vx;
				y+=vy;
				z+=vz;
			
			
			//x+=2;
			//y+=2;
			//z-=vz;
			//rotationZ=-45;
			//trace(z);
			//rotationX++;
			//rotation=Math.sin(vx/(Math.PI/180));
			//rotation=Math.sin(vy/(Math.PI/180));
			/*atan2(y,x) = φ  yaw (φ) 
			asin(z) = θ  pitch (θ)*/
			//rotationX = 0;
			//rotationY = 0;
			//rotationZ = -40;
			//rotationZ = Math.atan2(-vy,vx)*(180/Math.PI);
			//rotationX = Math.asin(vz)*(180/Math.PI);
			//trace(Math.asin(vz)*(180/Math.PI));
			//rotationZ = Math.asin(vz);
			//trace(Math.atan2(-1,-1)*(180/Math.PI));
			
		}

	}
	
}
