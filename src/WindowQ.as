package 
{
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Leshka
	 */
	public class WindowQ extends WindowQVoid 
	{
		public function WindowQ(t:String):void
		{
			this.text.text = t;
			this.back.title.addEventListener(MouseEvent.CLICK, onTitleClick);
		}
		
		private function onTitleClick(e:MouseEvent):void
		{
			this.parent.removeChild(this);
		}
	}	
}