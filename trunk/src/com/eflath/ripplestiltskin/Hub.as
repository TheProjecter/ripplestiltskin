package com.eflath.ripplestiltskin {
	import flash.display.Sprite;
	
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
		}
		
		//----------------------
		//
		// Variables
		//
		//-----------------------
		
		private var _baseShape:ICircleInscribedShape;
		
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
		
	}
	
}