/**
 * 	nagios.net.GenericVariables -- A different implementation of URLVariables used
 * 							with GenericLoader.  Has the ability to parse objects 
 * 							and URI strings to update variables passed in HTTP requests.
 * 
 * 	ID:		$Id$
 * 
 * 	(c) 2008 Nagios Enterprises
 */

package nagios.net
{
	import flash.net.URLVariables;
	
	public class GenericVariables
	{

		//instance of the URLVariables to build the request with.
		private var _params:URLVariables = new URLVariables();


		/**
		 * Constructor, parses objects and url strings for variables.
		 * @param variables, Object with key value pairs of &key=value
		 */
		public function GenericVariables(variables:Object = null, url:String = null)
		{
			parseVarObj( variables );	
			parseVarUrl( url );
		}



		// - - - Public Fuctions - - - //
		
		/**
		 * Updates the variables with extended options over the getter/setter methods.
		 * @param variable, Object to parse, 
		 * @param url, String to parse,
		 * @param clear, Used to reset the existing parameters before parsing.
		 */  
 		public function setVars( variables:Object = null, url:String = null, clear:Boolean = false ):void
		{
			//if we want to clear the current vars.. 	
			if(clear)
			{
				_params = new URLVariables();
			}
			
			//parse both..
			parseVarObj( variables );	
			parseVarUrl( url );		
		} 
		
		/**
		 * Parses an Object with key value pairs relating to the URLvariables wished to pass.
		 * @param variables, the Object to parse, checks for null.		 * 
		 */ 	
		private function parseVarObj( variables:Object ):void
		{
			if ( variables == null )
			{
				return;
			}
			else
			{
				for (var key:Object in variables)
				{
					_params[key] = variables[key];
				}	
			}	
		}
		
		/**
		 * Parses a URL string for the URLVariable creation.
		 * @param url, string to check
		 */ 			
		private function parseVarUrl( url:String ):void
		{
			if(url == null)
			{
				return;
			}
			else
			{
				var url_parts:Array = url.split("?");
				
				if(url_parts.length == 2)
				{
					_params.decode(url_parts[1]);
				}
			}
			
		}

		// - - - Public Getter/Setter functions - - - //	
		 
		public function get variables():URLVariables
		{
			return _params;
		}
		
		public function set variables(vars:URLVariables):void
		{
			_params = vars;
		}
	}
}