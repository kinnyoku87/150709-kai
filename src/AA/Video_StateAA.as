package AA 
{
	import flash.display3D.Context3D;
	import flash.media.Camera;
	
	import org.agony2d.Agony;
	import org.agony2d.core.inside.agony_internal;
	import org.agony2d.display.AAFacade;
	import org.agony2d.display.ImageAA;
	import org.agony2d.display.StateAA;
	import org.agony2d.display.textures.VideoTextureAA;
	import org.agony2d.events.ATouchEvent;
	import org.agony2d.logging.LogMachine;
	
	use namespace agony_internal;
	
public class Video_StateAA extends StateAA
{
	public var camera_A:Camera;
	public var videoTEX:VideoTextureAA;
	public var img_A:ImageAA;
	
	override public function onEnter() : void
	{
		
		Agony.getLog().simplify("supportsVideoTexture: " + Context3D.supportsVideoTexture);	
		Agony.getLog().simplify("supportsCamera: " + Camera.isSupported);	
		
		if (Context3D.supportsVideoTexture) {
			if(Camera.isSupported){
				
				
				camera_A = Camera.getCamera();
				
				if(camera_A){
					
					LogMachine.g_instance.simplify("{0} | {1}", camera_A.width, camera_A.height);
					
					
					
//					camera_A.setMode(1080, 1920, 15);
//					camera_A.setMode(this.getRoot().getAdapter().rootWidth, this.getRoot().getAdapter().rootHeight, 15);
					camera_A.setMode(this.getRoot().getAdapter().rootHeight, this.getRoot().getAdapter().rootWidth, 15);
					
					LogMachine.g_instance.simplify("{0} | {1}", this.getRoot().getAdapter().rootHeight, this.getRoot().getAdapter().rootWidth);
					
					LogMachine.g_instance.simplify("{0} | {1}", camera_A.height, camera_A.width );
					
					camera_A.setQuality(0, 100);
					
					videoTEX = new VideoTextureAA(camera_A, onVideo);
					
				}
				
			}
		}
		
//		this.getFusion().addEventListener(ATouchEvent.CLICK, onClick);
	}
	
	override public function onExit() : void {
		AAFacade.unregisterAsset("videoA");
	}
	
	private function onClick(e:ATouchEvent):void {
		if (img_A) {
			if (img_A.scaleX == 1.0) {
				img_A.scaleX = img_A.scaleY = 1.15;
				img_A.alpha = 0.5
			}
			else {
				img_A.scaleX = img_A.scaleY = img_A.alpha = 1.0;
				
			}
		}
	}
	
	private function onVideo():void{
		AAFacade.registerAsset("videoA", videoTEX, "videoA");
		
		img_A = new ImageAA;
		img_A.textureId = "videoA";
		img_A.rotation = 90;
		img_A.x = img_A.sourceHeight;
		
		this.getFusion().addNode(img_A);
		
		LogMachine.g_instance.simplify("{0} | {1}", img_A.sourceWidth, img_A.sourceHeight);
	}
	
}
}