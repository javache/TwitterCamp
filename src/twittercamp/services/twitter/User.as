package twittercamp.services.twitter
{
	
import flash.utils.Dictionary;

[Bindable]
public class User
{
	public var id:int;
	public var name:String;
	public var profileImg:String;
	
	public function User(id:int, name:String, profileImg:String)
	{
		this.id = id;
		this.name = name;
		this.profileImg = profileImg;
		
		// load image?
	}
	
	private static var cache:Dictionary = new Dictionary();
	public static function lookup(data:Object):User
	{
		var id:int = data.from_user_id;
		
		if(cache[id] == null) 
		{
			var user:User = new User(id, data.from_user, data.profile_image_url);
			cache[id] = user;
		}
		
		return cache[id];
	}
}

}