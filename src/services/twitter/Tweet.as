package services.twitter
{
	
public class Tweet
{
	public var createdAt:Date;
	public var id:String;
	public var text:String;
	public var user:User;
	
	public function Tweet(data:Object)
	{
		trace(data);
	}
}

}