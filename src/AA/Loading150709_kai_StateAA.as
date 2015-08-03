package AA {
	import org.agony2d.display.StateAA;
	import org.agony2d.events.AEvent;
	import org.agony2d.resource.FilesBundle;
	import org.agony2d.resource.ResMachine;
	import org.agony2d.resource.handlers.TextureAA_BundleHandler;
	
	public class Loading150709_kai_StateAA extends StateAA {
		
		override public function onEnter() : void {
			this.resA = new ResMachine("common/");
			
			
			// btn...A
//			this.resA.addBundle(new FilesBundle("ui/btnScale9/B/up.png", "iconA.png"), new TextureAA_BundleHandler);
			this.resA.addBundle(new FilesBundle("bgB.png", "btnA.png", "iconB.png"), new TextureAA_BundleHandler);
			
			this.resA.addEventListener(AEvent.COMPLETE, onComplete);
		}
		
		public var resA:ResMachine;
		
		private function onComplete(e:AEvent):void {
			var AY:Array;
			var i:int;
			var l:int;
			
			this.resA.removeAllListeners();
			this.getFusion().kill();
			
			AY = this.getArg(0);
			l = AY.length;
			while (i < l) {
				this.getRoot().getView(AY[i++]).activate();
			}
		}
	}
}