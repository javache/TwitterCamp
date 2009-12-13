package twittercamp.utils
{
	
public class RelativeDate
{
	
	public static function relativize( d:Date, relativeTo:Date = null ):String
	{
		relativeTo ||= new Date();
		var delta:Number = Math.floor( ( relativeTo.time - d.time ) / 1000 );
		
		if( delta < 0 )
		{
			return 'in the future';
		}
		if( delta < 60 )
		{
			return 'less than a minute ago';
		}
		else if( delta < 120 )
		{
			return 'about a minute ago';
		}
		else if( delta < ( 45 * 60 ) )
		{
			return Math.floor(delta / 60) + ' minutes ago';
		}
		else if( delta < ( 90 * 60 ) )
		{
			return 'about an hour ago';
		}
		else if( delta < ( 24 * 60 * 60 ) )
		{
			return 'about ' + Math.floor(delta / 3600) + ' hours ago';
		}
		else if(delta < (48*60*60) )
		{
			return '1 day ago';
		}
		else if( delta >= (48*60*60) )
		{
			return Math.floor(delta / 86400) + ' days ago';
		}
		return null;
	}
	
}

}