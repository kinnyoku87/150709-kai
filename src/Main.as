package {
	import flash.display.Sprite;
	import flash.ui.Multitouch;
	
	import initializers.Initializer150709_Kai;
	
	import org.agony2d.Agony;
	import org.agony2d.core.DesktopPlatform;
	import org.agony2d.core.MobilePlatform;
	import org.agony2d.logging.FlashTextLogger;
	import org.agony2d.utils.Stats;
	
	[SWF(width = "450", height = "800", backgroundColor = "0x0", frameRate = "30")]
	public class Main extends Sprite {
		
		public function Main() {
			var logger:FlashTextLogger;
			
//			stage.addChild(new Stats(10, 300));
			
//			logger = new FlashTextLogger(stage, true, 300, 330, 330, true);
//			Agony.getLog().logger = logger;
//			logger.visible = true;
			
			if(Multitouch.maxTouchPoints == 0){
				
				
//				Agony.startup(768, 1024, new DesktopPlatform, stage, Initializer150709_Kai);
				Agony.startup(1080, 1920, new DesktopPlatform, stage, Initializer150709_Kai);
				//			Security.allowDomain("*");
			}
			else{
//				Agony.startup(768, 1024, new MobilePlatform(false), stage, Initializer150709_Kai);
				Agony.startup(1080, 1920, new MobilePlatform(false), stage, Initializer150709_Kai);
			}
		}
	}
}