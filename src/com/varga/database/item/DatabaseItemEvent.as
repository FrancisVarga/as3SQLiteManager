package com.varga.database.item{	
	//--------------------------------------------------------------------------
	//  imports
	//--------------------------------------------------------------------------
	import flash.data.SQLResult;
	import flash.data.SQLSchemaResult;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	//--------------------------------------------------------------------------
	//  Metainformations
	//  example: [Event(name="Name_of_Event", type="Classpath_to_Event")]
	//--------------------------------------------------------------------------
	public class DatabaseItemEvent extends Event{
		
		//--------------------------------------------------------------------------
		//  Class constants
		//--------------------------------------------------------------------------
		private static const AUTHOR : String = "Francis Varga";
		private static const CLASSPATH : String = "package com.varga.database.DatabaseItemEvent";
		private static const VERBOSE : Boolean = true;		
		
		public static const STATEMENT_RESULT : String = "result";
		public static const STATEMENT_ERROR : String = "error";
		
		public static const SQLCONNECTION_SHEMARESULT : String = "shema_result";
		public static const SQLCONNECTION_DELETED : String = "connection_deleted";
		public static const SQLCONNECTION_INSERTED : String = "connection_inserted";
		public static const SQLCONNECTION_UPDATED : String = "connection_updated";
		
		//--------------------------------------------------------------------------
		//  Intern Private Variables
		//--------------------------------------------------------------------------
		private var debug : Function = nullFunction;
		
		//--------------------------------------------------------------------------
		//  Setter Getter Private Variables
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//  Public Variables
		//--------------------------------------------------------------------------
		public var databaseShema : SQLSchemaResult = null;
		public var databaseResult : SQLResult = null;
		
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
		 * @version:				1.0
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
		 * @Desc: This Class DatabaseItemEvent
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
		public function DatabaseItemEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			
			super(type, bubbles, cancelable);
			
			if( VERBOSE ) debug = debugger;
			
		}	
		
		//--------------------------------------------------------------------------
		//  Overridden methods: DatabaseItemEvent
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