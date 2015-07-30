package initializers
{
	import flash.display.Stage;
	
	import AA.CameraButton_StateAA;
	import AA.Loading150709_kai_StateAA;
	import AA.Video_StateAA;
	
	import org.agony2d.Agony;
	import org.agony2d.core.Adapter;
	import org.agony2d.core.IInitializer;
	import org.agony2d.display.AACore;
	import org.agony2d.display.RootAA;
	import org.agony2d.events.AEvent;
	import org.agony2d.resource.ResMachine;
	import org.agony2d.resource.converters.AtlasAssetConvert;
	import org.agony2d.resource.converters.SwfClassAssetConverter;

	public class Initializer150709_Kai implements IInitializer
	{
		
		private var _adapter:Adapter;
		private var _rootAA:RootAA;
		
		public function onInit( stage:Stage ) : void {
			//stage.quality = StageQuality.LOW;
			//stage.quality = StageQuality.MEDIUM
			//stage.quality = StageQuality.HIGH;
			
			this._adapter = Agony.createAdapter(stage, true);
			this._adapter.getTouch().velocityEnabled = true;
			//this._adapter.getTouch().autoUnbindingWhenLeaving = true;
			
			ResMachine.activate(SwfClassAssetConverter);
			ResMachine.activate(AtlasAssetConvert);
			
			AACore.registerView("res",     Loading150709_kai_StateAA);
			AACore.registerView("camera",  CameraButton_StateAA);
			AACore.registerView("video",   Video_StateAA);
			_rootAA = AACore.createRoot(this._adapter, 0xFFFFFF);
			_rootAA.addEventListener(AEvent.START, onStart);
		}
		
		private function onStart(e:AEvent):void {	
			_rootAA.getView("res").activate([["video", "camera"]]);
		}
	}
}