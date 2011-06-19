package twittercamp.controllers
{
	
import flash.events.TimerEvent;
import flash.utils.Timer;

import spark.components.WindowedApplication;

import twittercamp.services.twitter.TwitterSearch;
import twittercamp.services.twitter.UpdateEvent;
import twittercamp.views.BubbleGrid;

public class ApplicationController
{
	private var query:String;
	private var refreshRate:int;	
	
	private var appWindow:WindowedApplication;
	private var bubbleGrid:BubbleGrid;
	
	private var searchModel:TwitterSearch;
	private var tweetQueue:Array;
	private var viewTimer:Timer;
	
	public function ApplicationController()
	{
		/*query = "#bcg4";
		refreshRate = refreshRateSeconds * 1000;
		
		tweetQueue = new Array();
		bubbleGrid = view.bubbleGrid;
		
		// create searchModel
		searchModel = new TwitterSearch(query, refreshRate);
		searchModel.addEventListener(UpdateEvent.NEW_TWEETS, fillQueue);
		/*searchModel.addEventListener(FaultEvent.FAULT, function(event:FaultEvent):void
		{
			Alert.show(event.fault.faultString, "An error occured.");
		});
		
		// create timer to update view
		viewTimer = new Timer(0);
		viewTimer.addEventListener(TimerEvent.TIMER, updateView);*/
	}
	
	private static var instance:ApplicationController;
	public static function getInstance():ApplicationController
	{
		if(!instance) instance = new ApplicationController();
		return instance;
	}

	public function init(view:TwitterCamp):void
    {
		// set view 
		appWindow = view;
		bubbleGrid = view.bubbleGrid;
    }
	
	private function fillQueue(event:UpdateEvent):void
	{
		// add to queue
		tweetQueue = tweetQueue.concat(event.newStatuses);
		
		// modify viewTimer timeout
		if(tweetQueue.length > 0)
		{
			viewTimer.delay = refreshRate * 3 / tweetQueue.length;
			viewTimer.start();
			updateView(null);
		}
		else viewTimer.stop();
	}
	
	private var inited:Boolean = true;
	private function updateView(event:TimerEvent):void
	{		
		if(tweetQueue.length == 0)
		{
			viewTimer.stop(); return;
		}

		bubbleGrid.showTweet(tweetQueue.shift());
	}
}	
	
}