package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Vector3D;
	
	/**
	 * A very simple and efficient method of detecting collision 
	 * uses the pythagorean theorum to determine if two circles overlap
	 * 
	 * @author Zach
	 */
	public class CircleCircleCollisionDetection extends Sprite 
	{
		private var movingBall:Ball;
		private var stationaryBall:Ball;
		private var redGlow:Array;
		private var noGlow:Array;
		private var separationVector:Vector3D;
		
		public function CircleCircleCollisionDetection():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//Create two balls to test collision detection and reaction.
			movingBall = new Ball();
			stationaryBall = new Ball(50);	
			stationaryBall.x = stage.stageWidth / 2;
			stationaryBall.y = stage.stageHeight / 2;
			addChild(movingBall);
			addChild(stationaryBall);
			
			// create two arrays of filters for showing the collision
			redGlow = [new GlowFilter(0xFF0000, 1, 8, 8, 2, 3)];
			noGlow = [];
			
			//create a vector3D object to use to separate overlapping objects;
			separationVector = new Vector3D(0, 0);
			
			// Add a listener to move one fo the balls.
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			// Do our collision detection here.
				
				//removed updating ball position 
				
			//Simple collision detection
			// using pyhagorean theorum
			// (a*a) + (b*b) = (c*c);
			var distanceX:Number = stage.mouseX - stationaryBall.x; //Note - uses stage.mouseX now.			
			var distanceY:Number = stage.mouseY - stationaryBall.y; //Note - uses stage.mouseY now.
			var distance:Number = Math.sqrt( (distanceX * distanceX) + (distanceY * distanceY));
			
			if (distance < movingBall.radius + stationaryBall.radius) {
				// the balls overlap
				stationaryBall.filters = redGlow;
				
				//now a better reaction
				
				// point our vector the correct separation direction
				separationVector.x = distanceX;
				separationVector.y = distanceY;
				//scale the vector length to be the sum of the two ball radii
				
				if (separationVector.length > 0) {
					//Protect the operation from a divide by zero error when separationVector.length is zero.
					var scaleFactor:Number = (movingBall.radius + stationaryBall.radius) / separationVector.length;
					separationVector.scaleBy(scaleFactor);				
				}
				// position the moving ball at the separation vector and offset the vector by the stationary ball's position
				movingBall.x = separationVector.x +stationaryBall.x;
				movingBall.y = separationVector.y +stationaryBall.y;
				
			} else {
				// the balls do not overlap
				stationaryBall.filters = noGlow;
				movingBall.x = mouseX;
				movingBall.y = mouseY;
			}
		}
		
	}
	
}