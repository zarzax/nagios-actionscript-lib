/**
 * 	nagios.utils.bucketUtils -- Utility class to work with backend timedEventQueue XML
 * 
 * 	ID:		$Id$
 * 
 * 	(c) 2008 Nagios Enterprises
 */

package nagios.utils
{
	import mx.collections.ArrayCollection;
	
	public class bucketUtls
	{
		//hold XML data. 		
		private var _data:XML;
	
		/**
		 * Constructor, takes XML timed event queue data
		 * @param data, timed event queue data
		 */ 	
		public function bucketUtls(data:XML = null)
		{
			_data = new XML(data);
		} 

		// - - - Public Functions - - - //
		
		/**
		 * Returns an ArrayCollection useful in FLEX charting components.
		 * @param typeArray, takes an array of ints that corrispond to check types
		 * @return ArrayCollection
		 */ 
		public function toArrayCollection(typeArray:Array = null):ArrayCollection
		{
			// returned ArrayCollection
			var rAC:ArrayCollection = new ArrayCollection();
			
			//default check types of hosts and services
			if( typeArray == null)
			{
				typeArray = new Array([0], [12]);
			}
			
			//loop through each of the buckets in the XML structure
			for each (var xml_part:XML in _data.bucket)
			{
				var subObj:Object = new Object();
				
				//look for each check type passed in typeArray
				for (var i:int = 0; i < typeArray.length; i++)
				{
					//create the a sting to be used as a key for the object
					var typeStr:String = "type" + typeArray[i].toString();
					//set object to the value found
					subObj[typeStr] = xml_part.eventtotals.(@type == typeArray[i].toString());
				}
				
				//add the object the the array collection
				rAC.addItem(subObj);
			}
			
			return rAC;
		}		//end toArrayCollection()
		
	
		// - - - Public Getter / Setter Functions - - - //
		public function get xml():XML
		{
			return _data;	
		}
		
		public function set xml(data:XML):void
		{
			_data = new XML(data);
		}
		
		public function get max():int
		{
			var max:int = int(_data.maxbucketitems);

			if(max > 0)
			{
				return max;
			}
			else
			{	
				max = 0;
				return max;
			}
		}
		
		public function get recordcount():int
		{
			return int(_data.recordcount);
		}

	}
}