/**
 * 	nagios.net.GenericLoader -- HTTP Loader generic class that combines the URLRequest with
 * 						the URLVariables (privided from GenericVariables).  Simplifies the
 * 						call to webservices.  Defaults to GET requests.
 * 
 * 	ID:		$Id$
 * 
 * 	(c) 2008 Nagios Enterprises
 */

package nagios.net
{
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	public class GenericLoader extends URLLoader
	{
	
		// - - - Instance Variables - - - //
		
		private var _request:URLRequest = new URLRequest();
		private var _params:GenericVariables = new GenericVariables();
		
		
		
		/**
		 * Constructor, initializes the superclass, sets up the request and variables, 
		 * and parses any object or sting passes for variables.
		 * @param url, parses string for request location and URI variables contained.
		 * @param variables, parses the object for variables
		 */
		public function GenericLoader(url:String = null, variables:Object = null)
		{
			super();
			
			//Initialize the new instance variables
			_request = new URLRequest();
			_params = new GenericVariables(variables, url);
			
			//split up the url to check for vars
			var url_split:Array = new Array();
			
			if( url.search("?") != -1)
			{
				url_split = url.split("?");
			}
			else
			{
				url_split.push(url);
			}	
			
			//setup the connection
			_request.url = url_split[0] + encodeURI("?");
			_request.data = this._params.variables;
			_request.method = URLRequestMethod.GET;
			super.dataFormat = URLLoaderDataFormat.TEXT;	
		}
		
		
		// - - - Public Functions - - - //

		/**
		 * Overloaded load function to load the URLRequest. Requests should be given
		 * as null.
		 * @param new_request, a URLRequest could be given but not required normally null.
		 */  		
		override public function load(new_request:URLRequest):void
		{
			if(new_request == null)
			{
				super.load(_request);
			}
			else
			{
				super.load(new_request);
			}
			
		}	
		

		/**
		 * GenericLoaders call to the setVars() function in GenericVariables.
		 * @param variable, Object to parse, 
		 * @param url, String to parse,
		 * @param clear, Used to reset the existing parameters before parsing.
		 */
		public function setVars(variables:Object = null, url:String = null, clear:Boolean = false):void
		{
			this._params.setVars(variables, url, clear);
			this._request.data = this._params.variables;
		}

		// - - - Public Getter/Setter Functions - - - //
		 
		public function set requestType(type:String):void
		{
			_request.method = type;
		}	
		
		public function get requestType():String
		{
			return _request.method;
		}		

		public function set requestContent(type:String):void
		{
			_request.contentType = type;
		}
		
		public function get requestContent():String
		{
			return _request.contentType;
		}				
		
 		public function set variables(variables:Object):void
		{
			//passes one parameter to the GenericVariables setVars function. 
			this._params.setVars( variables );
			this._request.data = this._params.variables;
		}
		
		public function get variables():Object
		{
			return this._params.variables;
		}
		
		public function set url(url:String):void
		{
			_request.url = url;
		}
		
		public function get url():String
		{
			return _request.url;
		}				
		
	}
}