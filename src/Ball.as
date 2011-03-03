package  
{
	import flash.display.Shape;
	/**
	 * The Ball class creates a randomly colored circle of a specified radius.
	 * @author Zach
	 */
	public class Ball extends Shape
	{
		private var color:uint;
		private var _radius:Number;
		public function Ball(radius:Number = 20) 
		{
			color = Math.random() * 0xFFFFFF;
			this.radius = radius;
		}
		
		public function get radius():Number { return _radius; }
		
		public function set radius(value:Number):void 
		{
			_radius = value;
			this.graphics.beginFill(color, 1);
			this.graphics.drawCircle(0, 0, _radius);

		}
		
	}

}