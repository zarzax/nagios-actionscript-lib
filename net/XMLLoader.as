/**
 * 	nagios.net.XMLLoader -- Extenstion of the GenericLoader class used specifically for loading
 * 							XML data. 		
 * 
 * 	ID:		$Id$
 * 
 * 	(c) 2008 Nagios Enterprises
 */
package nagios.net
{

	public class XMLLoader extends nagios.net.GenericLoader
	{
		
		/**
		 * Constructor, initialize the super class with arguments and set
		 * the content type as xml.
		 */ 	
		public function XMLLoader(url:String, variables:Object = null)
		{
			super(url, variables);
			super.requestContent = "text/xml"	
		}		

	}
}