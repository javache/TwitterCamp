package services.twitter
{

import com.adobe.serialization.json.JSON;

import flash.events.TimerEvent;
import flash.utils.Timer;

import mx.rpc.events.ResultEvent;
import mx.rpc.http.HTTPService;


/* API for http://apiwiki.twitter.com/Twitter-Search-API-Method:-search */

public class TwitterSearch extends HTTPService
{
	private var lastSearchId:int = 0;
	private var query:String = "";
	private var timer:Timer;
	
	// Constructor
	public function TwitterSearch(q:String, interval:int)
	{	
		super("http://search.twitter.com/");
		
		query = escape(q);
		
		// setup http-request
		method = "GET";	url = "search.json";
		resultFormat = "text";
		
		addEventListener(ResultEvent.RESULT, requestSuccess);
		
		// setup timer
		timer = new Timer(interval);
		timer.addEventListener(TimerEvent.TIMER, refresh);
		timer.start();
	}
	
	private function refresh(event:TimerEvent):void
	{
		trace("TwitterSearch::refresh())");
		
		var params:Object = {'q': query};
		if(lastSearchId > 0) params['since_id'] = lastSearchId;
		
		send(params);
	}
	
	private function requestSuccess(event:ResultEvent):void
	{
		trace("TwitterSearch::requestSuccess())");
		var newStatuses:Vector.<Tweet> = new Vector.<Tweet>();
		
		// decode the json
		var json:Object = JSON.decode(String(event.result));
		
		// update the lastSearchId
		lastSearchId = json.max_id;
		
		for each(var tweet:Object in json.results)
		{
			newStatuses.push(new Tweet(tweet));
		}
	}
}

}