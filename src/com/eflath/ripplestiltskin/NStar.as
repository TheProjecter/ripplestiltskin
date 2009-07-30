package com.eflath.ripplestiltskin {
	
	/**
	 * A Star with n points inscribed in a circle of given radius
	 * @author eflath
	 */
	public class NStar extends BaseShape implements ICircleInscribedShape {
		//----------------------
		//
		// Constructor
		//
		//-----------------------
		/**
		 * 
		 * @param	n - number of star arms
		 * @param	raidus - radius of circle in which star is inscribed
		 * @param	pointRatio - between 0 and 1 (length of arm relative to radius)
		 */
		public function NStar(n:int, raidus:Number, pointRatio:Number=0.4) {
			_n = n;
			_r = raidus;
			_ratio = pointRatio;
			buildPoints();
		}
		
		//----------------------
		//
		// Variables
		//
		//-----------------------
		
		private var _n:int;
		private var _r:Number;
		private var _ratio:Number;
		
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
		
		private function buildPoints():void {
			var PI:Number = Math.PI;
			var theta:Number = 2 * PI / _n;
			for (var i:Number = 0; i < _n; i++) {
				addPointXY( _r * _ratio * Math.cos(theta * i), _r * _ratio * Math.sin(theta * i));
				addPointXY( _r * Math.cos(theta * i+theta/2), _r * Math.sin(theta * i+theta/2));
			}
		}
		
		/* INTERFACE com.eflath.ripplestiltskin.ICircleInscribedShape */
		
		public function get radius():Number{
			return _r;
		}
		
		public function cloneWithNewRadius(r:Number):ICircleInscribedShape{
			return new NStar(_n, r, _ratio);
		}
		
	}
	
}