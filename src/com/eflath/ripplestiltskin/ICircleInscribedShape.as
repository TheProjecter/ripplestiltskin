package com.eflath.ripplestiltskin {
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author eflath
	 */
	public interface ICircleInscribedShape {
		
		function get radius():Number;
		function get points():Vector.<Point>;
		function getPointAtIndex(i:int):Point;
		function cloneWithNewRadius(r:Number):ICircleInscribedShape;
		
	}
	
}