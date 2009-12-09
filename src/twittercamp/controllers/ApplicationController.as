package twittercamp.controllers
{
	
import twittercamp.services.twitter.TwitterSearch;
import twittercamp.services.twitter.UpdateEvent;

public class ApplicationController
{
	private var query:String;
	private var refreshRate:int;	
	
	private var searchModel:TwitterSearch;
	private var tweetQueue:Array;

	public function ApplicationController(query:String, refreshRateSeconds:int)
    {
		this.query = query;
		this.refreshRate = refreshRateSeconds * 1000;
		
		tweetQueue = new Array();
		
		searchModel = new TwitterSearch(query, refreshRate);
		searchModel.addEventListener(UpdateEvent.NEW_TWEETS, fillQueue);
    }
	
	private function fillQueue(event:UpdateEvent):void
	{
		// add to queue
		tweetQueue = tweetQueue.concat(event.newStatuses);
	}
}

}