package com.eflath.ripplestiltskin {
	import flash.geom.Point;
	import com.eflath.ripplestiltskin.customsingularity.FastBezier;
	
	/**
	 * ...
	 * @author eflath
	 */
	public class Utils {
		//----------------------
		//
		// Constructor
		//
		//-----------------------
		public function Utils() {
			
		}
		
		//----------------------
		//
		// Variables
		//
		//-----------------------
		
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
		
		
		/**
		 * smoothly interpolate the shape with bezier curves
		 * @param	s
		 * @param	smoothCoef - smoothness coeficient
		 * @param	subdiv - number of subdivisions for each curve
		 * @return
		 */
		public static function smooth(s:BaseShape, smoothCoef:Number=0.5, subdiv:int=4):BaseShape {
			var newShape:BaseShape = new BaseShape();
			var bez:Vector.<FastBezier> = smoothToBezierCollection(s, smoothCoef);
			while (bez.length > 0) {
				newShape.addPoints( getPointsFromBezier(bez.shift(), subdiv));
			}
			return newShape;
		}
		
		public static function smoothToBezierCollection(s:BaseShape, smoothCoef:Number = 0.5):Vector.<FastBezier> {
			var i:int = -1;
			var l:int = s.points.length;
			var pt0:Point;
			var pt1:Point;
			var pt2:Point;
			var pt3:Point;
			var pc1:Point;
			var pc2:Point;
			var pc3:Point;
			var len1:Number;
			var len2:Number;
			var len3:Number;
			var k1:Number;
			var k2:Number;
			var pm1:Point;
			var pm2:Point;
			var ctrl1:Point;
			var ctrl2:Point;
			var bez:Vector.<FastBezier> = new Vector.<FastBezier>;
			
			while (++i < l) {
				pt0 = s.getPointAtIndex(i);
				pt1 = s.getPointAtIndex(i + 1);
				pt2 = s.getPointAtIndex(i +2);
				pt3 = s.getPointAtIndex(i + 3);
				pc1 = midpoint(pt0, pt1);
				pc2 = midpoint(pt1, pt2);
				pc3 = midpoint(pt2, pt3);
				len1 = distance(pt0, pt1);
				len2 = distance(pt1, pt2);
				len3 = distance(pt2, pt3);
				k1 = len1 / (len1 + len2);
				k2 = len2 / (len2 + len3);
				pm1 = new Point( 
						pc1.x + (pc2.x - pc1.x) * k1, 
						pc1.y + (pc2.y - pc1.y) * k1
					);
				pm2 = new Point( 
						pc2.x + (pc3.x - pc2.x) * k2, 
						pc2.y + (pc3.y - pc2.y) * k2
					);		
				ctrl1 = new Point (
						pm1.x + (pc2.x - pm1.x) * smoothCoef + pt1.x - pm1.x,
						pm1.y + (pc2.y - pm1.y) * smoothCoef + pt1.y - pm1.y
					);
				ctrl2 = new Point (
						pm2.x + (pc2.x - pm2.x) * smoothCoef + pt2.x - pm2.x,
						pm2.y + (pc2.y - pm2.y) * smoothCoef + pt2.y - pm2.y
					);
				bez.push(getBezier(pt1, ctrl1, ctrl2, pt2));
			}
			return bez;
		}
		
		public static function getBezier(p0:Point, p1:Point, p2:Point, p3:Point):FastBezier {
			var fb:FastBezier = new FastBezier();
			fb.addControlPoint(p0.x, p0.y);
			fb.addControlPoint(p1.x, p1.y);
			fb.addControlPoint(p2.x, p2.y);
			fb.addControlPoint(p3.x, p3.y);
			return fb;
		}
		
		public static function midpoint(p1:Point, p2:Point):Point {
			return new Point( (p1.x + p2.x) / 2, (p1.y + p2.y) / 2);
		}
		
		public static function distance(p1:Point, p2:Point):Number {
			return Math.sqrt( p1.x * p1.x + p2.x * p2.x );
		}
		
		public static function getPointsFromBezier(bez:FastBezier, subdiv:int):Vector.<Point> {
			var vect:Vector.<Point> = new Vector.<Point>;
			var step:Number = 1 / subdiv;
			var t:Number = 0;
			while ( t <= 1) {
				vect.push( new Point(bez.getX(t), bez.getY(t)) );
				t += step;
			}
			return vect;
		}
	}
	
}