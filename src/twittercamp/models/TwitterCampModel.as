package be.thinkjavache.twittercamp.models
{
	import flash.events.Event;
	
	[Bindable]
	public class TwitterCampModel
	{
		private static var twitterCampModel:TwitterCampModel;
		
		public static function getInstance() : TwitterCampModel
		{
			if ( twitterCampModel == null )
				twitterCampModel = new TwitterCampModel();
				
			return twitterCampModel;
		}
		
	   public var twitter:Twitter;
	   public var config:XML;
	   
	   public function TwitterCampModel()
	   {
	   		twitter = new Twitter();
	   }
	}
}