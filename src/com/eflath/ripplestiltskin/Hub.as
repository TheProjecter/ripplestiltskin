package com.eflath.ripplestiltskin {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author eflath
	 */
	public class Hub extends Sprite {
		//----------------------
		//
		// Constructor
		//
		//-----------------------
		public function Hub(baseShape:ICircleInscribedShape) {
			_baseShape = baseShape;
			addChild(_baseRenderer = new ShapeRenderer());
			_baseRenderer.shape = _baseShape as BaseShape;
			_rings = new Vector.<Ring>;
			drawBase();
			addMouseListeners();
		}
		
		//----------------------
		//
		// Variables
		//
		//-----------------------
		
		private var _baseShape:ICircleInscribedShape;
		private var _baseRenderer:ShapeRenderer;
		private var _rings:Vector.<Ring>;
		
		private var _mouseDownPoint:Point;
		private var _activeRing:Ring;
		
		//----------------------
		//
		// Properties
		//
		//-----------------------
		
		public function get baseShape():ICircleInscribedShape { return _baseShape; }
		
		//----------------------
		//
		// Methods
		//
		//-----------------------
		
		private function addMouseListeners():void {
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		/////////////////
		// MouseEvents
		/////////////////
		
		private function onMouseDown(e:MouseEvent):void {
			trace("MOUSE DOWN");
			_mouseDownPoint = new Point(mouseX, mouseY);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onInitialMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onInitialMouseMove(e:MouseEvent):void {
			// if you're further out than the radius, create a new shape
			if ((mouseX) * (mouseX) + (mouseY * mouseY) > (_baseShape.radius * _baseShape.radius)) {
				var r:Ring = createRing();
				r.radius = Math.sqrt((mouseX) * (mouseX) + (mouseY * mouseY));
				r.color = Math.random() * 255 * 255 * 255;
				r.isActiveRing = true;
				trace("create ring with radius " + r.radius);
				r.draw();
				_activeRing = r;
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onInitialMouseMove);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, activeRingMouseMove);
			}
		}
		
		private function activeRingMouseMove(e:MouseEvent):void {
			if ((mouseX) * (mouseX) + (mouseY * mouseY) > (_baseShape.radius * _baseShape.radius)) {
				_activeRing.radius = Math.sqrt((mouseX*mouseX) + (mouseY * mouseY));
				_activeRing.draw();
			}
		}
		
		private function onMouseUp(e:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onInitialMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, activeRingMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			if (_activeRing) {
				_activeRing.isActiveRing = false;
				_activeRing.draw();
				_activeRing = null;
			}
		}
		
		////////////////////
		// end MouseEvents
		////////////////////
		
		private function createRing():Ring {
			var r:Ring = new Ring(this);
			addChild(r);
			_rings.push(r);
			return r;
		}
		
		
		private function drawBase():void {
			var g:Graphics = _baseRenderer.graphics;
			g.beginFill(0xB2B2B2);
			_baseRenderer.drawPath();
			g.endFill();
		}
		
		
		
	}
	
}