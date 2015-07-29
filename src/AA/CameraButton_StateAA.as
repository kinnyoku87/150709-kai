package AA
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Cubic;
	
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import org.agony2d.Agony;
	import org.agony2d.display.DragFusionAA;
	import org.agony2d.display.ImageAA;
	import org.agony2d.display.StateAA;
	import org.agony2d.display.core.NodeAA;
	import org.agony2d.events.AEvent;
	import org.agony2d.events.ATouchEvent;
	import org.agony2d.events.DragEvent;
	import org.agony2d.input.Touch;
	import org.agony2d.utils.AMath;
	
	public class CameraButton_StateAA extends StateAA
	{
		
		override public function onEnter() : void
		{
			_dragFusion = new DragFusionAA();
			this.getFusion().addNode(_dragFusion);
			
			_imgA = new ImageAA;
//			_imgA.alpha = 0.5;
			_imgA.textureId = "ui/btnScale9/B/up.png";
			
			INIT_W = _imgA.sourceWidth;
			INIT_H = this.getRoot().getAdapter().rootHeight / 6.5;
			
			_startX = -28;
			_startY = 200;
			_endX = this.getRoot().getAdapter().rootWidth + 28;
			_endY = this.getRoot().getAdapter().rootHeight - 200;
			
			_imgA.pivotX = _imgA.sourceWidth / 2;
			_imgA.pivotY = _imgA.sourceHeight / 2;
			_imgA.addEventListener(ATouchEvent.PRESS, onTouch);
			_imgA.addEventListener(ATouchEvent.UNBINDING, onUnbinding);
			_imgA.addEventListener(ATouchEvent.CLICK, onClick);
			_imgA.setCollisionMethod(____onCollisionA);
			
			_dragFusion.addNode(_imgA);
			
			_imgB = new ImageAA;
			_imgB.textureId = "iconA.png";
			_imgB.touchable = false;
			_imgB.pivotX = _imgB.sourceWidth / 2;
			_imgB.pivotY = _imgB.sourceHeight / 2;
			_dragFusion.addNode(_imgB);
			
			_dragFusion.x = _startX;
			_dragFusion.y = _startY;
		}
		
		private function ____onCollisionA(x:Number,y:Number,node:NodeAA):Boolean{
			if(AMath.distance(x, y, node.x + node.pivotX, node.y + node.pivotY) < this.getRoot().getAdapter().rootWidth / 7.5){
				return true;
			}
			return false;
		}
		
		override public function onExit() : void {
			
		}
		
		private function onTouch(e:ATouchEvent):void {
			TweenLite.killTweensOf(_dragFusion);
			
			_timerA = new Timer(_delayTime, 1);
			_timerA.addEventListener(TimerEvent.TIMER_COMPLETE, onTimer);
			_timerA.start();
			
			_pressedTouch = e.touch;
			_pressedTouch.addEventListener(AEvent.CHANGE, onTouchChange);
			_moveCount = 0;
		}
		
		private function onUnbinding(e:ATouchEvent):void{
			if(_timerA){
				_timerA.removeEventListener(TimerEvent.TIMER, onTimer);
				_timerA.stop();
				_timerA = null;
			}
		}
		
		private function onClick(e:ATouchEvent):void{
//			Agony.getLog().simplify(e.type);
			
//			this.getRoot().getAdapter().getTouch().touchEnabled = false;
			
//			TweenLite.to(this.getFusion().displayObject, 0.2, {tint:0xdddddd, ease:Linear.easeNone, onComplete:function():void{
//				getFusion().displayObject.transform.colorTransform = new ColorTransform;
//				
//				getRoot().getAdapter().getTouch().touchEnabled = true;
//			}});
		}
		
		private function onTimer(e:TimerEvent):void{
			_timerA.removeEventListener(TimerEvent.TIMER, onTimer);
			_timerA = null;
			
			if(_moveCount < 11){
				_imgA.touchable = false;
				_pressedTouch.unbinding();
				
				TweenLite.to(_dragFusion, 0.3, { scaleX:1.2, scaleY:1.2, ease:Cubic.easeIn } );
				
				_dragFusion.startDrag(_pressedTouch, new Rectangle(_startX, _startY, _endX - _startX, _endY - _startY), 0, 0, true);
				_dragFusion.addEventListener(DragEvent.STOP_DRAG, onStopDrag);
			}
			else {
				
			}
		}
		
		private function onTouchChange(e:AEvent):void{
			_moveCount++;
		}
		
		private function onStopDrag(e:DragEvent):void{
			_dragFusion.removeEventListener(DragEvent.STOP_DRAG, onStopDrag);
			
			_imgA.touchable = true;
			
			Agony.getLog().simplify(e.touch.velocityX);
			if(e.touch.velocityX <= -2){
				TweenLite.to(_dragFusion, 0.3, { x:_startX, scaleX:1.0, scaleY:1.0, ease:Cubic.easeIn } );
			}
			else if(e.touch.velocityX >= 2){
				TweenLite.to(_dragFusion, 0.3, { x:_endX, scaleX:1.0, scaleY:1.0, ease:Cubic.easeIn } );
			}
			else {
				if(_dragFusion.x < this.getRoot().getAdapter().rootWidth * .5){
					TweenLite.to(_dragFusion, 0.3, { x:_startX, scaleX:1.0, scaleY:1.0, ease:Cubic.easeIn } );
				}
				else{
					TweenLite.to(_dragFusion, 0.3, { x:_endX, scaleX:1.0, scaleY:1.0, ease:Cubic.easeIn } );
				}
			}
		}
		
		
		private var INIT_W:int
		private var INIT_H:int;
		
		private var _delayTime:int = 400;
		
		
		private var _startX:Number;
		private var _startY:Number;
		
		private var _endX:Number;
		private var _endY:Number;
		
		private var _timerA:Timer;
		
		private var _moveCount:int;
		
		private var _imgA:ImageAA;
		private var _imgB:ImageAA;
		
		private var _dragFusion:DragFusionAA;
		
		private var _iconA:ImageAA;
		
		private var _pressedTouch:Touch;
	}
}