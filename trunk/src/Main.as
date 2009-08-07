package {
	import com.eflath.ripplestiltskin.BaseShape;
	import com.eflath.ripplestiltskin.Hub;
	import com.eflath.ripplestiltskin.ICircleInscribedShape;
	import com.eflath.ripplestiltskin.Ngon;
	import com.eflath.ripplestiltskin.NStar;
	import com.eflath.ripplestiltskin.ShapeRenderer;
	import com.eflath.ripplestiltskin.Utils;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import com.eflath.ripplestiltskin.customsingularity.FastBezier;
	
	/**
	 * ...
	 * @author eflath
	 */
	public class Main extends Sprite {
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var s:NStar = new NStar(9, 80, 0.4);
			
			/*
			var r:ShapeRenderer = new ShapeRenderer();
			r.shape = s;
			addChild( r);
			r.debugDrawShape();
			//r.drawOutline(0xcccccc, 2, 1);
			r.x = 100;	r.y = 100;
			*/
			
			/*
			// would be cool to use this technique for when distortion is applied
			
			var smooth:BaseShape = Utils.smooth( s, 0.9, 4 );
			//smooth.debug_tracePoints();
			var r2:ShapeRenderer = new ShapeRenderer();
			r2.shape = smooth;
			r2.x = r.x;	r2.y = r.y;
			r2.drawOutline(0xff0000, 2, 1);
			addChild(r2);
			
			
			var timer:Timer = new Timer(40);
			timer.addEventListener(TimerEvent.TIMER, function(e:Event):void {
					r2.graphics.clear();
					smooth = Utils.smooth( s, 0.9, Math.random() * 7 + 3);
					r2.shape = smooth;
					r2.drawOutline(0xff0000, 2, 1);
				});
			timer.start();
			
			//*/
			
			/* this is pretty efficient
			var bez:Vector.<FastBezier> = Utils.smoothToBezierCollection(s);
			var outline:Shape = new Shape();
			outline.x = r.x;	outline.y = r.y;
			addChild(outline);
			for each (var b:FastBezier in bez) {
				b.draw( outline.graphics, 2, 0xFF0000, false);
			}
			
			
			var r2:ShapeRenderer = new ShapeRenderer();
			r2.shape = s.cloneWithNewRadius(s.radius + 10) as BaseShape;
			r2.x = r.x;			r2.y = r.y;
			r2.drawRoughOutline(0xFF0000, 2, 1, 0.4, 4);
			addChild(r2);
			//*
			var timer:Timer = new Timer(100);
			timer.addEventListener(TimerEvent.TIMER, function(e:Event):void {
					r2.clear();
					r2.drawRoughOutline(0xff0000, 2, 1, Math.random(), Math.random()*4+3);
				});
			timer.start();
			//*/
			
			var h:Hub = new Hub( new NStar(3, 30) );
			h.x = 200;
			h.y = 200;
			addChild(h);
			
		}
		
		
		
	}
	
}