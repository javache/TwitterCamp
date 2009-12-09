package twittercamp.services.twitter
{
	
import mx.rpc.events.ResultEvent;

public class UpdateEvent extends ResultEvent
{
	public static const NEW_TWEETS:String = "new_tweets";
	
	public var newStatuses:Array;
	
	public function UpdateEvent(type:String, newStatuses:Array):void
	{
		super(type);
		
		this.newStatuses = newStatuses;
	}
	
}

}