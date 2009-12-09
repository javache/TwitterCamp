package twittercamp.utils
{
	
public class Random
{
	public static function randomRange( start:int, end:int ) : int
	{
	   return Math.floor( start + ( Math.random() * ( end + 1 - start ) ) );
	}
	
}

}