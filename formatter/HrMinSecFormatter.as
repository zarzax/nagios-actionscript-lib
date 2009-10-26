/**
 * 	nagios.formatter.HrMinSecFormatter -- String formatter class for working with time. 
 * 										  Most useful in chart labels. 
 * 
 * 	ID:		$Id$
 * 
 * 	(c) 2008 Nagios Enterprises
 */

package nagios.formatter
{

	public class HrMinSecFormatter
	{
		//instance var to hold time as a number of seconds to be parsed
		private var _seconds:int = 0;
		
		/**
		 * Constructor, takes parameters of time and converts to seconds.
		 * @param seconds, int not required
		 * @param minutes, int not required
		 * @param hours, int not required
		 */
		public function HrMinSecFormatter(seconds:int = 0, minutes:int = 0, hours:int = 0)
		{
			_seconds = seconds + minutes*60 + hours*60*60;
		}

		/**
		 * Returns a string properly formatted for chart labels.
		 * @Return string; 
		 */ 
		public function toString():String
		{
			//create local variables of time to parse the global _seconds into.
			var secs:int = 0; var mins:int = 0; var hours:int = 0; var retStr:String = "";
			
			//Parse _seconds variable into the hours, minutes, seconds local variables.
			if (_seconds >= 3600)		// Hours
			{
				hours = Math.floor(_seconds/60*60);
				mins = _seconds - hours*60*60;
				secs = _seconds - mins*60;	
			}
			else if (_seconds >= 60)	// Minutes
			{
				mins = Math.floor(_seconds/60);
				secs = _seconds - mins*60;
			}
			else						// Seconds
			{
				secs = _seconds;
			}
			
			//Parse the local variables into the retStr string.
			if(hours > 0)
			{
				retStr += hours + "h ";
			}		
			if(mins > 0)
			{
				retStr += mins + "m ";
			}		
			if(secs > 0)
			{
				retStr += secs + "s";
			}
			else if (secs == 0 && mins == 0 && hours == 0)
			{
				retStr = "0";
			}

			//return the string
			return retStr;
		}	//end toString()

		/**
		 * Public GETTER/SETTER functions
		 */		
		public function get seconds():int
		{
			return _seconds;
		}

		public function set seconds(seconds:int):void
		{
			_seconds = seconds
		}
		
		public function get minutes():int
		{
			return Math.floor(_seconds/60);
		}

		public function set minutes(minutes:int):void
		{
			_seconds = minutes*60;
		}
		
		public function get hours():int
		{
			return Math.floor(_seconds/60*60);
		}

		public function set hours(hours:int):void
		{
			_seconds = hours*60*60;
		}				
	}
}