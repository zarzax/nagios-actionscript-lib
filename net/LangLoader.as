/**
 * 	nagios.net.LangLoader -- Extenstion of the GenericLoader class used specifically with the
 * 					ajaxhelper.php backend in order to load language strings.
 * 
 * 					When finished it sends an event 'FinishedLoadingLanguageStrings' for the 
 * 					initiating program to listen for.
 * 		
 * 
 * 	ID:		$Id$
 * 
 * 	(c) 2008 Nagios Enterprises
 */

package nagios.net
{
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class LangLoader extends nagios.net.GenericLoader
	{
		
		// - - - Instance Variables - - - //
		
		//instance of an array of language string requests
		private var _langList:Array;
		
		//instance of the current language string request sent
		private var _currentLangVar:String;
		
		//instance of the end result array, key value pairs
		private var _resultObj:Object;
		
		//bool, sends all string requests at once, false sends one at a time.
		private var _useBulk:Boolean;
		
		/**
		 * Constructor, initializes the GenericLoader super class with an url string.  
		 * @param url, the url for the request.
		 * @param langList, an arrays with all the language string request keys.
		 * @param useBulk, flag for querying the langList at once or one at a time.
		 */ 	
		public function LangLoader(url:String, langList:Array, useBulk:Boolean = false)
		{
			//init superclass with url for request
			super(url);
			
			//set content as text
			super.requestContent = "text"
			
			//init the instance variables
			this._langList = langList;
			this._resultObj = new Object();
			this._useBulk = useBulk;
			
			//set the event listeners according to type.
			if (this._useBulk)
			{
				addEventListener(Event.COMPLETE, cmpListenerBulk, false, 0, true);
			}
			else
			{
				addEventListener(Event.COMPLETE, cmpListenerSingle, false, 0, true);
			}
		}
		
	
		/**
		 * Overloaded load method.  To load the request.
		 * @param new_request, normally should be called with null can be 
		 * overridded with a new request.   
		 */ 
		override public function load(new_request:URLRequest):void
		{
			switch (_useBulk)
			{
				case true:
					super.setVars(getBulkVars(), null, true);
					super.load(new_request);
					break;
				
				case false:
					super.setVars(getSingleVars(), null, true);
					super.load(new_request);
					break;	
			}
		}
		
	

		/**
		 * Returns an object for use by the load method when useBulk = false
		 * while the langArray shifts reducing the number of calls left.
		 * @return object to use as URLVariable
		 */ 
		private function getSingleVars():Object
		{
			//create the simple object from the string
			var newVars:Object = new Object();
			newVars["cmd"] = "getlangstring";
			this._currentLangVar = this._langList.shift();
			newVars["str"] = this._currentLangVar;
			
			return newVars;
		}
		
		/**
		 * Returns an object for use by the load method when useBulk = true. Makes
		 * one big URLVariable for the request.
		 * @return object containing all the langArray
		 */ 
		private function getBulkVars():Object
		{
			var newVars:Object = new Object();
			var languageStr:String = "";
			
			//take the language string list array and make one big CSV string.
			for (var i:int = 0; i < _langList.length; i++)
			{
				languageStr += _langList[i] + ",";
			}
			
			//cut the extra','
			languageStr = languageStr.substr(0, languageStr.length - 1);
			
			//create the simple object from the string
			newVars["cmd"] = "getlangstring";
			//set the decoded string.
			newVars["str"] = decodeURI( languageStr );
			
			//set the currentLangVar instance
			_currentLangVar = decodeURI( languageStr );
			
			return newVars;
		}
	
	
		// - - - Event Listeners - - - //
					
		/**
		 * EventListener for use with bulk mode disabled
		 * @param event,
		 */ 	
		private function cmpListenerSingle(event:Event):void
		{
			//set the _resultObj to the data of the event.
			_resultObj[event.currentTarget.currentLangVar] = event.currentTarget.data;
			
			//check to see if there are more language strings to send otherwise dispatch event
			if (event.currentTarget.langListLength > 0)
			{
				this.load(null);
			}
			else
			{
				dispatchEvent(new Event("FinishedLoadingLanguageStrings")); 
			}

		}
		
		/**
		 * EventListener for use with bulk mode enabled
		 * @param event,
		 */ 			
		private function cmpListenerBulk(event:Event):void
		{
			//parse the string for newlines
			var splitData:Array = event.currentTarget.data.split('\n');
			
			//there is always one extra newline at the end so it is length -1
			for (var i:int = 0; i < splitData.length - 1 ; i++)
			{
				_resultObj[ _langList[i] ] = splitData[i];
			}

			dispatchEvent(new Event("FinishedLoadingLanguageStrings"));
		}
		

		// - - - Public Getter/Setter Functions - - - //	
		 
		//current language string being loaded. 
		public function get currentLanguageVar():String
		{
			return this._currentLangVar; 
		}

		//current number of strings to load
		public function get languageListLength():int
		{
			return this._langList.length; 
		}	

		public function get completeLanguageObject():Object
		{
			return this._resultObj;	
		}
	}
}