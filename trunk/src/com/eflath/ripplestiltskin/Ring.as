package com.eflath.ripplestiltskin {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	
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
			_color = value;
		}		
		
		public function get isActiveRing():Boolean { return _isActiveRing; }
		
		public function set isActiveRing(value:Boolean):void {
			_isActiveRing = value;
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
			if (isActiveRing) {
				_renderer.drawRoughOutline(_color, 2, 1, Math.random()*0.4+0.6, Math.random()*5+5);
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