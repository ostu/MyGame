package 
{
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Leshka
	 */
	public class Card extends CardVoid 
	{
		public var question:String;
		
		public function Card(q:String, score:String):void
		{
			question = q;
			this.score.text = score;
			this.addEventListener(MouseEvent.CLICK, onCardClick);
		}
		
		public function onCardClick(e:MouseEvent):void
		{
			if (this.alpha == 1)
			{
				this.alpha = 0.1;
				var windowQ:WindowQ = new WindowQ(question);
				this.parent.addChild(windowQ);
			}
			else
			{
				this.alpha = 1;
			}
		}
	}
	
}