package twittercamp.services.twitter
{

import com.adobe.serialization.json.JSON;

import flash.events.TimerEvent;
import flash.utils.Timer;

import mx.rpc.events.ResultEvent;
import mx.rpc.http.HTTPService;

/* API for http://apiwiki.twitter.com/Twitter-Search-API-Method:-search */

[Event(name="new tweets", type="services.Twitter.UpdateEvent")]

public class TwitterSearch extends HTTPService
{
	private var lastSearchId:String = "";
	private var query:String = "";
	private var timer:Timer;
	
	// Constructor
	public function TwitterSearch(q:String, interval:int)
	{	
		super("http://search.twitter.com/");
		
		// setup http-request
		method = "GET";	url = "search.json";
		resultFormat = "text";
		query = q;
		
		addEventListener(ResultEvent.RESULT, requestSuccess);
		refresh(null);
		
		// setup timer
		timer = new Timer(interval);
		timer.addEventListener(TimerEvent.TIMER, refresh);
		timer.start();
	}
	
	private function refresh(event:TimerEvent):void
	{
		trace("TwitterSearch::refresh())");
		
		var params:Object = {'q': query};
		if(lastSearchId != "") params['since_id'] = lastSearchId;
		
		send(params);
	}
	
	private function requestSuccess(event:ResultEvent):void
	{
		trace("TwitterSearch::requestSuccess())");
		var newStatuses:Array = new Array();
		
		// decode the json
		var json:Object = JSON.decode(String(event.result));
		
		// update the lastSearchId
		lastSearchId = json.max_id;
		
		for each(var tweet:Object in json.results)
		{
			newStatuses.push(new Tweet(tweet));
		}
		
		// sort tweets
		newStatuses.sortOn("createdAt");
		
		// push event
		trace(newStatuses.length + " new tweets found");
		dispatchEvent(new UpdateEvent(UpdateEvent.NEW_TWEETS, newStatuses));
	}
}

}