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
			return 'in de toekomst';
		}
		if( delta < 60 )
		{
			return 'minder dan een minuut geleden';
		}
		else if( delta < 120 )
		{
			return 'ongeveer een minuut geleden';
		}
		else if( delta < ( 45 * 60 ) )
		{
			return Math.floor(delta / 60) + ' minuten geleden';
		}
		else if( delta < ( 90 * 60 ) || Math.floor(delta / 3600) <= 1)
		{
			return 'ongeveer een uur geleden';
		}
		else if( delta < ( 24 * 60 * 60 ) )
		{
			return 'ongeveer ' + Math.floor(delta / 3600) + ' uren geleden';
		}
		else if(delta < (48*60*60) )
		{
			return '1 dag geleden';
		}
		else if( delta >= (48*60*60) )
		{
			return Math.floor(delta / 86400) + ' dagen geleden';
		}
		return null;
	}
	
}

}