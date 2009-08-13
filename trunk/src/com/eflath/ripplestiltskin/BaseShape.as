package com.eflath.ripplestiltskin {
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author eflath
	 */
	public class BaseShape {
		//----------------------
		//
		// Constructor
		//
		//-----------------------
		public function BaseShape() {
			_points = new Vector.<Point>;
		}
		
		//----------------------
		//
		// Variables
		//
		//-----------------------
		
		private var _points:Vector.<Point>;
		
		//----------------------
		//
		// Properties
		//
		//-----------------------
		
		public function get points():Vector.<Point> {
			return _points;
		}
		
		//----------------------
		//
		// Methods
		//
		//-----------------------
		
		/**
		 * return the point at the given index
		 * we take care of wrapping here to make code more readable elsewhere
		 * (in other words, with a 5 point shape, you can get the point at index 7 and not get an error)
		 * @param	i
		 * @return
		 */
		public function getPointAtIndex(i:int):Point {
			if (i < 0)
				i = _points.length + i;
			if (i > (_points.length - 1))
				i = i % _points.length;
			return _points[i];
		}
		
		public function addPoint(pt:Point):void {
			_points.push(pt);
		}
		
		public function addPointXY(x:Number, y:Number):void {
			addPoint( new Point(x, y) );
		}
		
		public function addPoints(vect:Vector.<Point>):void {
			while (vect.length > 0) {
				_points.push( vect.shift() );
			}
		}
		
		public function debug_tracePoints():void {
			trace("Points: ");
			for each (var pt:Point in _points) {
				trace("\t"+pt.x, pt.y)
			}
			trace("----");
		}
	}
	
}