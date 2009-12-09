package twittercamp.services.twitter
{
	
import com.adobe.utils.DateUtil;

[Bindable]
public class Tweet
{
	public var createdAt:Date;
	public var id:String;
	public var content:String;
	public var user:User;
	
	public function Tweet(data:Object)
	{
		// set basic properties
		createdAt = DateUtil.parseRFC822(data.created_at);		
		id = data.id;
		content = data.text;
		
		// find user
		user = User.lookup(data);
	}

}

}