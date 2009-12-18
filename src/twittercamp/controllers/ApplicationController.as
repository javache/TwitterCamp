package twittercamp.controllers
{
	
import flash.events.TimerEvent;
import flash.utils.Timer;

import mx.controls.Alert;
import mx.rpc.events.FaultEvent;

import twittercamp.services.twitter.TwitterSearch;
import twittercamp.services.twitter.UpdateEvent;
import twittercamp.views.BubbleGrid;

public class ApplicationController
{
	private var query:String;
	private var refreshRate:int;	
	
	private var bubbleGrid:BubbleGrid;
	private var searchModel:TwitterSearch;
	private var tweetQueue:Array;
	private var viewTimer:Timer;

	public function ApplicationController(view:TwitterCamp, query:String, refreshRateSeconds:int)
    {
		this.query = query;
		this.refreshRate = refreshRateSeconds * 1000;
		
		tweetQueue = new Array();
		bubbleGrid = view.bubbleGrid;
		
		// create searchModel
		searchModel = new TwitterSearch(query, refreshRate);
		searchModel.addEventListener(UpdateEvent.NEW_TWEETS, fillQueue);
		searchModel.addEventListener(FaultEvent.FAULT, function(event:FaultEvent):void
		{
			Alert.show(event.fault.faultString, "An error occured.");
		});
		
		// create timer to update view
		viewTimer = new Timer(0);
		viewTimer.addEventListener(TimerEvent.TIMER, updateView);
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