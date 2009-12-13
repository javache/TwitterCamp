package twittercamp.services.twitter
{
	
import com.adobe.utils.DateUtil;

import flash.xml.XMLDocument;

import twittercamp.utils.RelativeDate;

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
		content = new XMLDocument(data.text).firstChild.nodeValue;
		
		// find user
		user = User.lookup(data);
	}
	
	public function get relativeCreatedAt():String
	{
		return RelativeDate.relativize(createdAt);
	}

}

}