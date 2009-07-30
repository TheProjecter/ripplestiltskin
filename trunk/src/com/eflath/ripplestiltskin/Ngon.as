package com.eflath.ripplestiltskin {
	import flash.geom.Point;
	
	/**
	 * A regular Polygon with n-sides inscribed in a circle of given radius
	 * @author eflath
	 */
	public class Ngon extends BaseShape implements ICircleInscribedShape {
		//----------------------
		//
		// Constructor
		//
		//-----------------------
		public function Ngon(n:int, radius:Number) {
			_n = n;
			_r = radius;
			buildPoints();
		}
		
		//----------------------
		//
		// Variables
		//
		//-----------------------
		
		private var _r:Number;
		private var _n:Number;
		
		//----------------------
		//
		// Properties
		//
		//-----------------------
		
		public function get radius():Number { return _r }
		
		//----------------------
		//
		// Methods
		//
		//-----------------------
		
		public function cloneWithNewRadius(r:Number):ICircleInscribedShape {
			return new Ngon(_n, r);
		}
		
		private function buildPoints():void {
			var PI:Number = Math.PI;
			var theta:Number = 2 * PI / _n;
			for (var i:int = 0; i < _n; i++) {
				addPointXY( _r*Math.cos(theta * i), _r*Math.sin(theta * i) );
			}
		}
		
	}
	
}