package services.twitter.search
{

import com.adobe.serialization.json.JSONDecoder;

import mx.rpc.AsyncToken;
import mx.rpc.events.ResultEvent;
import mx.rpc.http.HTTPService;

public class TwitterSearch extends HTTPService
{
	private var lastSearchId:int
	
	// Constructor
	public function TwitterSearch()
	{	
		super("http://search.twitter.com/");
		method = "GET";
		url = "search.json";
		resultFormat = "text";
				
		addEventListener(ResultEvent.RESULT, handle_requestSuccess);
	}
	
	public function search(q:String, since_id:int = 0):AsyncToken
	{
		trace("TwitterSearch::search()) called");
		
		return send({'q': q});
	}
	
	private function handle_requestSuccess(event:ResultEvent):void
	{
		trace("TwitterSearch::handle_requestSuccess()) called");
		
		var decoder:JSONDecoder = new JSONDecoder(event.result.toString());
		
		for each(var tweet:Object in decoder.getValue().results)
		{
			trace(tweet.text);
		}
	}
}

}