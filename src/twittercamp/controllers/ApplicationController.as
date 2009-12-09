package twittercamp.controllers
{
	
import mx.controls.Alert;
import mx.rpc.events.FaultEvent;

import twittercamp.services.twitter.TwitterSearch;
import twittercamp.services.twitter.UpdateEvent;
import twittercamp.views.BubbleGrid;

public class ApplicationController
{
	private var query:String;
	private var refreshRate:int;	
	
	private var bubbleGrid:BubbleGrid;
	private var searchModel:TwitterSearch;
	public var tweetQueue:Array;

	public function ApplicationController(view:TwitterCamp, query:String, refreshRateSeconds:int)
    {
		this.query = query;
		this.refreshRate = refreshRateSeconds * 1000;
		
		tweetQueue = new Array();
		bubbleGrid = view.bubbleGrid;
		
		searchModel = new TwitterSearch(query, refreshRate);
		searchModel.addEventListener(UpdateEvent.NEW_TWEETS, fillQueue);
		searchModel.addEventListener(FaultEvent.FAULT, function(event:FaultEvent):void
		{
			Alert.show(event.fault.faultString, "An error occured.");
		});
    }
	
	private function fillQueue(event:UpdateEvent):void
	{
		// add to queue
		tweetQueue = tweetQueue.concat(event.newStatuses);
	}
}

}