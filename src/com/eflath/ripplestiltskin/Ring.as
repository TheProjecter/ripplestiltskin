package com.eflath.ripplestiltskin {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	
	/**
	 * ...
	 * @author eflath
	 */
	public class Ring extends Sprite {
		//----------------------
		//
		// Constructor
		//
		//-----------------------
		public function Ring(owner:Hub) {
			_owner = owner;
			addChild(_renderer = new ShapeRenderer());
			_glow = new GlowFilter( 0xFFFFFF, 0.8, 4, 4, 1, 2);
			filters = [_glow];
		}
		
		//----------------------
		//
		// Variables
		//
		//-----------------------
		
		private var _owner:Hub;
		private var _radius:Number;
		private var _color:uint=0xFF0000;
		private var _shape:ICircleInscribedShape;
		private var _renderer:ShapeRenderer;
		private var _isActiveRing:Boolean = false;
		private var _animate:Boolean = false;
		private var _scribbleMultiplier:Number = 0;
		
		private var _glow:GlowFilter;
		
		//----------------------
		//
		// Properties
		//
		//-----------------------
		public function get radius():Number { return _radius; }
		
		public function set radius(value:Number):void {
			_radius = value;
			_shape = _owner.baseShape.cloneWithNewRadius(_radius);
			_renderer.shape = _shape as BaseShape;
		}
		
		public function get color():uint { return _color; }
		
		public function set color(value:uint):void {
			_glow.color = value;
			_color = value;
		}		
		
		public function get isActiveRing():Boolean { return _isActiveRing; }
		
		public function set isActiveRing(value:Boolean):void {
			_isActiveRing = value;
			if (value) {
				//beginShakyCycle();
				_glow.blurX = _glow.blurY = 8;
				_glow.alpha = 1;
				filters = [_glow];
			} else {
				//endShakyCycle();
				_glow.blurX = _glow.blurY = 4;
				_glow.alpha = 0.8;
				filters = [_glow];
			}
		}
		
		public function get animate():Boolean { return _animate; }
		
		public function set animate(value:Boolean):void {
			_animate = value;
			if (value) {
				beginShakyCycle();
			} else {
				endShakyCycle();
			}
		}
		
		//----------------------
		//
		// Methods
		//
		//-----------------------
		
		public function draw():void {
			_renderer.clear();
			if (_animate) {
				_scribbleMultiplier += 0.2;
				_renderer.drawRoughOutline(_color, 2, 1, 0.2+Math.abs(0.5*Math.sin(_scribbleMultiplier)), 8);
			} else {
				_renderer.drawSmoothOutline(_color, 2, 1);
			}
			
		}
		
		private function drawOnEnterFrame(e:Event):void {
			draw();
		}
		
		public function beginShakyCycle():void {
			addEventListener(Event.ENTER_FRAME, drawOnEnterFrame);
		}
		
		public function endShakyCycle():void {
			removeEventListener(Event.ENTER_FRAME, drawOnEnterFrame);
		}
		
	}
	
}