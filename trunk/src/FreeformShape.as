package  {
	import com.eflath.ripplestiltskin.BaseShape;
	import com.eflath.ripplestiltskin.ShapeRenderer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author eflath
	 */
	public class FreeformShape extends Sprite {
		//----------------------
		//
		// Constructor
		//
		//-----------------------
		public function FreeformShape() {
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			shapes = new Vector.<BaseShape>;
			renderers = new Vector.<ShapeRenderer>;
		}
		
		//----------------------
		//
		// Variables
		//
		//-----------------------
		
		private var shapes:Vector.<BaseShape>;
		private var renderers:Vector.<ShapeRenderer>;
		private var curShape:BaseShape;
		private var curRenderer:ShapeRenderer;
		private var count:int = 0;
		private var countInterval:int = 3;
		
		
		
		//----------------------
		//
		// Properties
		//
		//-----------------------
		
		//----------------------
		//
		// Methods
		//
		//-----------------------
		
		private function onMouseDown(e:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			curShape = new BaseShape();
			curShape.addPointXY(e.localX, e.localY);
			
			curRenderer = new ShapeRenderer();
			curRenderer.shape = curShape;
			addChild(curRenderer);
			
			
			count = 0;
		}
		
		private function onMouseMove(e:MouseEvent):void {
			if (++count % countInterval == 0) {
				curShape.addPointXY(e.localX, e.localY);
				curRenderer.clear();
				curRenderer.drawSmoothOutline(0, 1, 1, 0.4, false);
			}
		}
		
		private function onMouseUp(e:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			shapes.push(curShape);
			renderers.push(curRenderer);
			curShape = null;
			curRenderer = null;
		}
		
		private function onEnterFrame(e:Event):void {
			for each (var r:ShapeRenderer in renderers) {
				r.clear();
				r.drawSmoothOutline(0x333388, 2, 1, 0.2 + Math.random() * 0.7, false);
				r.drawOutline(0xFF0000, 1, 1, false);
			}
		}
		
		
	}
	
}