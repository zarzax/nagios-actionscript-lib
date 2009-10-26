/**
 * 	nagios.preloader.GenericPreloader -- A class to preload logos, throbers before 
 * 										 the main application can finish loading. 
 * 
 *  note -- ideas taken from http://www.onflex.org/ted/2006/07/flex-2-custom-preloaders.php
 * 
 * 	ID:		$Id$
 * 
 */
package nagios.preloader
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import mx.events.*;
    import mx.preloaders.Preloader;
    import mx.preloaders.DownloadProgressBar;
    import nagios.preloader.WelcomeScreen;


	public class GenericPreloader extends DownloadProgressBar
	{
		
		public var wcs:WelcomeScreen;
		
		public function GenericPreloader()
		{
            super(); 
            wcs = new WelcomeScreen();
            this.addChild(wcs)  
		}

        override public function set preloader( preloader:Sprite ):void 
        {                   
            preloader.addEventListener( ProgressEvent.PROGRESS , SWFDownloadProgress );    
            preloader.addEventListener( Event.COMPLETE , SWFDownloadComplete );
            preloader.addEventListener( FlexEvent.INIT_PROGRESS , FlexInitProgress );
            preloader.addEventListener( FlexEvent.INIT_COMPLETE , FlexInitComplete );
        }
    
        private function SWFDownloadProgress( event:ProgressEvent ):void {}
    
        private function SWFDownloadComplete( event:Event ):void {}
    
        private function FlexInitProgress( event:Event ):void {}
    
        private function FlexInitComplete( event:Event ):void 
        {      
            wcs.ready = true;      
            dispatchEvent( new Event( Event.COMPLETE ) );
        }
		
	}
}