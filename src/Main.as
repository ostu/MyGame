package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Leshka
	 */
	public class Main extends Sprite 
	{
		private var infoLoaderXML:URLLoader = new URLLoader;
		private var infoRequestXML:URLRequest;
		private var gameLoaderXML:URLLoader = new URLLoader;
		private var gameRequestXML:URLRequest;
		//private var fileRef:FileReference;
		private var myXML:XML;
		private var gameXML:XML;
		
		private var curRound:int = 0;
		private var maxRound:int;
		
		private var arrRounds:Array = new Array();
		private var arrThemes:Array = new Array();
		
		private var background:Background;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//fileRef = new FileReference(); 
            //fileRef.addEventListener(Event.SELECT, onFileSelected);
			//var textTypeFilter:FileFilter = new FileFilter("XML-files (*.xml)","*.xml"); 
            //fileRef.browse([textTypeFilter]);
			
			infoRequestXML = new URLRequest("info.xml");
			infoLoaderXML.addEventListener(Event.COMPLETE, infoXmlLoaded);
			infoLoaderXML.load(infoRequestXML);
		}
		
		private function infoXmlLoaded(e:Event):void 
		{
			myXML = new XML(infoLoaderXML.data);
			maxRound = myXML.@roundscount;
			
			for (var i:int = 0; i < maxRound; i++)
			{
				arrRounds[i] = myXML.round[i];
			}
			
			createNewGame();
		}
		
		private function createNewGame():void
		{
			//if (background) removeChild(background);
			gameRequestXML = new URLRequest(arrRounds[curRound]);
			gameLoaderXML.addEventListener(Event.COMPLETE, gameXmlLoaded);
			gameLoaderXML.load(gameRequestXML);
		}
		
		
		private function gameXmlLoaded(e:Event):void
		{	
			gameXML = new XML(gameLoaderXML.data);
			background = new Background();
			//var txt:TextField = new TextField();
			//txt.text = arrRounds[0];
			//addChild(txt);
			
			background.prev.addEventListener(MouseEvent.CLICK, onButtonPrevClick);
			background.next.addEventListener(MouseEvent.CLICK, onButtonNextClick);
			addChild(background);
			
			var card:Card;
			for (var i:int = 0; i < gameXML.@themescount; i++)
			{
				arrThemes[i] = new Theme();
				arrThemes[i].text.text = gameXML.theme[i].title;
				arrThemes[i].x = 20;
				arrThemes[i].y = 110 * i + 90;
				addChild(arrThemes[i]);
				for (var j:int = 0; j < gameXML.theme[i].@qcount; j++)
				{
					card = new Card(gameXML.theme[i].question[j], String((j+1) * 100));
					card.x = 280 + 130 * j;
					card.y = 110 * i + 90;
					addChild(card);
				}
			}
		}
		
		private function onButtonPrevClick(e:MouseEvent):void
		{
			if (curRound > 0)
			{
				curRound--;
				createNewGame();
			}
		}
		
		private function onButtonNextClick(e:MouseEvent):void
		{
			//var txt:TextField = new TextField();
			//txt.text = "AAAAA";
			//addChild(txt);
			
			if (curRound < maxRound-1)
			{
				curRound++;
				createNewGame();
			}
		}
	}
}