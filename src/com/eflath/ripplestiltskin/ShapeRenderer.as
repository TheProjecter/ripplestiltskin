package com.eflath.ripplestiltskin {
	import com.eflath.ripplestiltskin.customsingularity.FastBezier;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author eflath
	 */
	public class ShapeRenderer extends Sprite {
		//----------------------
		//
		// Constructor
		//
		//-----------------------
		public function ShapeRenderer() { }
		
		//----------------------
		//
		// Variables
		//
		//-----------------------
		
		private var _shape:BaseShape;
		
		//----------------------
		//
		// Properties
		//
		//-----------------------
		
		public function set shape(val:BaseShape):void {
			if (_shape) {
				graphics.clear();
			}
			_shape = val;
		}
		
		public function get shape():BaseShape {
			return _shape;
		}
		
		//----------------------
		//
		// Methods
		//
		//-----------------------
		
		//----------------------
		//
		// Drawing
		//
		//-----------------------
		
		public function clear():void {
			graphics.clear();
		}
		
		/**
		 * debug draw method that will give us a solid, filled shape (assumes closed polygon)
		 * @param	s
		 */
		public function debugDrawShape():void {
			var g:Graphics = graphics;
			g.clear();
			g.beginFill(0x000000, 0.2);
			drawPath();
			g.endFill();
		}
		
		public function drawOutline(color:uint, thickness:uint, alpha:Number):void {
			var g:Graphics = graphics;
			g.lineStyle(thickness, color, alpha, true);
			drawPath();
		}
		
		/**
		 * draw an outline using a bezier spline interpolation (smoothing all the points)
		 * @param	color
		 * @param	thickness
		 * @param	alpha
		 * @param	smoothCoef
		 */
		public function drawSmoothOutline(color:uint, thickness:uint, alpha:Number, smoothCoef:Number=0.5):void {
			var bez:Vector.<FastBezier> = Utils.smoothToBezierCollection(_shape);
			bez[0].draw( graphics, thickness, color, alpha, false);
			for (var i:int = 1; i < bez.length-1; i++) {
				bez[i].draw( graphics, thickness, color, alpha, true);
			}
			bez[bez.length - 1].draw( graphics, thickness, color, alpha, false);
		}
		
		
		public function drawRoughOutline(color:uint, thickness:uint, alpha:Number, smoothCoef:Number = 0.4, subdivisions:int=4):void {
			var smoothshape:BaseShape = Utils.smooth( _shape, smoothCoef, subdivisions);
			var cacheShape:BaseShape = _shape;
			_shape = smoothshape;
			drawOutline(color, thickness, alpha);
			_shape = cacheShape;
		}
		
		/**
		 * just the moveTo / lineTo commands to draw a shape (no fills or linestyle)
		 */
		public function drawPath():void {
			var g:Graphics = graphics;
			var pt:Point = _shape.points[0];
			g.moveTo(pt.x, pt.y);
			var i:int = 0;
			var l:int = _shape.points.length;
			while (++i < l) {
				pt = _shape.points[i];
				g.lineTo(pt.x, pt.y);
			}
			pt = _shape.points[0];
			g.lineTo(pt.x, pt.y);
		}
		
		public function drawPathPortion(startT:Number, endT:Number):void {
			var g:Graphics = graphics;
			g.lineStyle(1, 0xFF0000, 1);
			var pt:Point = _shape.points[0];
			g.moveTo(pt.x, pt.y);
			var i:int = int(startT*_shape.points.length);
			var l:int = _shape.points.length*endT;
			while (++i < l) {
				pt = _shape.points[i];
				g.lineTo(pt.x, pt.y);
			}
		}
		
	}
	
}