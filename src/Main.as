package {
	import flash.display.Sprite;
	import flash.ui.Multitouch;
	
	import initializers.Initializer150709_Kai;
	
	import org.agony2d.Agony;
	import org.agony2d.core.DesktopPlatform;
	import org.agony2d.core.MobilePlatform;
	import org.agony2d.logging.FlashTextLogger;
	
	[SWF(width = "450", height = "800", backgroundColor = "0x0", frameRate = "30")]
	public class Main extends Sprite {
		
		public function Main() {
			var logger:FlashTextLogger;
			
//			stage.addChild(new Stats(stage.stageWidth - 80, 50));
			
			logger = new FlashTextLogger(stage, true, 300, 330, 330, true);
			Agony.getLog().logger = logger;
			logger.visible = true;
			
			if(Multitouch.maxTouchPoints == 0){
				
				
//				Agony.startup(1024, 768, new DesktopPlatform, stage, Initializer150709_Kai);
				Agony.startup(768, 1024, new DesktopPlatform, stage, Initializer150709_Kai);
				//			Security.allowDomain("*");
			}
			else{
//				Agony.startup(768, 1024, new MobilePlatform(true), stage, Initializer150709_Kai);
				Agony.startup(768, 1024, new MobilePlatform(false), stage, Initializer150709_Kai);
			}
		}
	}
}