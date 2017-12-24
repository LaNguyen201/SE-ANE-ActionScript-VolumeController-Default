package my.extension.volume
{
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import my.extension.volume.events.VolumeEvent;	

	public class VolumeController extends EventDispatcher
	{
		private static var _instance:VolumeController;
		private var _systemVolume:Number = 1;
		
		//Constructor
		public function VolumeController(enforcer:SingletonEnforcer)
		{
			super();
		}
		
		public function get systemVolume():Number
		{
			return _systemVolume;
		}
		
		public function set systemVolume(value:Number):void
		{
			if(_systemVolume == value)
				return;
			_systemVolume = value;
		}
		
		public static function get instance():VolumeController {
			if ( !_instance ) {
				_instance = new VolumeController( new SingletonEnforcer() );
				_instance.init();
			}
			
			return _instance;
		}
		
		public function dispose():void { 
		}
		private function init():void {
		}
		public function getCurrentVolume():Number{
			return 0;
		}
		
		
		private function onStatus(event:StatusEvent):void
		{
			systemVolume = Number(event.level);
			dispatchEvent(new VolumeEvent(VolumeEvent.VOLUME_CHANGED, systemVolume, false, false));
			
		}
		public function setVolume(newVolume:Number):void {
			if ( isNaN(newVolume) ) {
				newVolume = 1;
			}
			
			if ( newVolume < 0 ) {
				newVolume = 0;
			}
			
			if ( newVolume > 1 ) {
				newVolume = 1;
			}
			
			
			systemVolume = newVolume;
		}
	}	
}
class SingletonEnforcer {
	
}