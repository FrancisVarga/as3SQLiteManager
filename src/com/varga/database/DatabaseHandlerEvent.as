package com.varga.database{	
	//--------------------------------------------------------------------------
	//  imports
	//--------------------------------------------------------------------------
	import flash.events.Event;
	import flash.utils.getTimer;
	import com.varga.database.item.DatabaseItem;
	
	public class DatabaseHandlerEvent extends Event{
		
		//--------------------------------------------------------------------------
		//  Class constants
		//--------------------------------------------------------------------------
		private static const AUTHOR : String = "Francis Varga";
		private static const CLASSPATH : String = "package com.varga.database.DatabaseEvents";
		private static const VERBOSE : Boolean = true;		
		
		public static const FILE_LOADED : String = "fileloaded";
		public static const FILE_LOAD_ERROR : String = "fileError";
		//--------------------------------------------------------------------------
		//  Intern Private Variables
		//--------------------------------------------------------------------------
		private var debug : Function = nullFunction;
		
		//--------------------------------------------------------------------------
		//  Public Variables
		//--------------------------------------------------------------------------
		public var dbItem : DatabaseItem = null;
		
		//--------------------------------------------------------------------------
		//  Setter Getter Private Variables
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 * @Projekt:					Francis Varga - Projekt
		 * 
		 * @author:					Francis Varga</br>
		 *									Mauernstraße 10</br>
		 *									38100 Braunschweig</br>
		 *									Germany
		 *
		 * @date:						Oct 13, 2009
		 *
		 * @version:					1.0
		 *
		 * @contact:				<b>eMail:</b>fv(at)varga-multimedia.com<br \>
		 *									<b>icq:</b>313024737<br \>
		 *									<b>jabber:</b> littlebuddha87(at)jabber.ccc.de<br \>
		 *									<b>twitter:</b> http://twitter.com/LittleBuddha87/<br \>
		 *
		 * @homepage:			www.varga-multimedia.com
		 *
		 ***************************************************************************************************
		 * @license:
		 * Copyright (C) [2009-2010] [Francis Varga, Mauernstraße 10, 38100 Braunschweig, Germany] <br\>
		 *
		 * <p>This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version. <br\>
		 *
		 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. <br\>
		 *
		 * You should have received a copy of the GNU General Public License along with this program; if not, see <http://www.gnu.org/licenses/></p>. 
		 *
		 ***************************************************************************************************
		 *
		 * @Desc: This Class DatabaseEvents
		 * 
		 * @param:
		 * 	
		 **************************************************************************************************
		 *
		 * @history:
		 *		Francis Varga:
		 *		Oct 13, 2009 - Create Class
		 *
		 */
		public function DatabaseHandlerEvent(type:String, bubble:Boolean=false, cancelable:Boolean=false)
		{
			
			super(type, bubbles, cancelable);
			
			if( VERBOSE ) debug = debugger;
			
		}	
		
		//--------------------------------------------------------------------------
		//  Overridden methods: DatabaseEvents
		//--------------------------------------------------------------------------	
		
		//--------------------------------------------------------------------------
		//  Public methods
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//  Private and Protected methods
		//--------------------------------------------------------------------------
		/**
		 * @author:	Francis Varga
		 * @date: Oct 24, 2009
		 *
		 * @description this function will not replace trace but if u don't want traces than make it easier to turn off.
		 * @param message:*
		 * @return void
		 */
		private function debugger(message:*):void
		{
			trace("["+getTimer()+"].["+AUTHOR+"].["+CLASSPATH+"]: "+ String(message));
		}
		
		/**
		 * @author:	Francis Varga
		 * @date: Oct 24, 2009
		 *
		 * @description
		 * @param $value:*
		 * @return void
		 */
		private function nullFunction($value:*):void
		{
		}
		
		//--------------------------------------------------------------------------
		//  Event handlers
		//--------------------------------------------------------------------------
		
		
		
		//--------------------------------------------------------------------------
		//  Properties (getter, setter)
		//--------------------------------------------------------------------------
		
	}
}

internal class SingletonEnforcer{}