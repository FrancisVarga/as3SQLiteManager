package com.varga.database{	
	//--------------------------------------------------------------------------
	//  imports
	//--------------------------------------------------------------------------
	import flash.events.EventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.utils.getTimer;
	
	import mx.managers.CursorManager;
	import com.varga.database.item.DatabaseItem;
	
	//--------------------------------------------------------------------------
	//  Metainformations
	//--------------------------------------------------------------------------		
	[Event(name="FILE_LOADED", type="com.varga.database.DatabaseHandlerEvent")]
	[Event(name="FILE_LOAD_ERROR", type="com.varga.database.DatabaseHandlerEvent")]
	public class DatabaseHandler extends EventDispatcher{
		
		//--------------------------------------------------------------------------
		//  Class constants
		//--------------------------------------------------------------------------
		private static const AUTHOR : String = "Francis Varga";
		private static const CLASSPATH : String = "package com.varga.database.DatabaseHandler";
		private static const VERBOSE : Boolean = true;		
		
		//--------------------------------------------------------------------------
		//  Intern Private Variables
		//--------------------------------------------------------------------------
		private var debug : Function = nullFunction;
		private var dbItem : DatabaseItem = null;
		
		//--------------------------------------------------------------------------
		//  Setter Getter Private Variables
		//--------------------------------------------------------------------------
		private static var _INSTANCE:DatabaseHandler = null;
	
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
		 * @Desc: This Class DatabaseHandler
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
		public function DatabaseHandler( $singelton : SingletonEnforcer )
		{
			
			if( VERBOSE ) debug = debugger;
			
		}	
		
		//--------------------------------------------------------------------------
		//  Overridden methods: DatabaseHandler
		//--------------------------------------------------------------------------	
		
		//--------------------------------------------------------------------------
		//  Public methods
		//--------------------------------------------------------------------------
		public function createDatabase( $url : String ):void
		{
			
			debug("Open DB File: " + $url);
			
			CursorManager.setBusyCursor();
			
			//create a dabaseitem where all variables included
			dbItem = null;
			dbItem = new DatabaseItem();
			dbItem.databaseURL = $url;
			
			//add event listener for the file
			dbItem.sqlConnection.addEventListener(SQLEvent.OPEN, openFileHandler);
			dbItem.sqlConnection.addEventListener(SQLErrorEvent.ERROR, errorFileHandler);
			
			debug("DB File: " + dbItem.databaseFile);
			debug("DB SQLConnection: " + dbItem.sqlConnection);
			debug("DB SQLStatement: " + dbItem.sqlStatement);
			
			//open db file async
			dbItem.sqlConnection.openAsync(dbItem.databaseFile);
		}		
		
		//--------------------------------------------------------------------------
		//  Private and Protected methods
		//--------------------------------------------------------------------------
		/**
		 * @author:	Francis Varga
		 * @date: Oct 23, 2009
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
		 * @date: Oct 23, 2009
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
		private function openFileHandler(event : SQLEvent):void
		{
			debug("Open DB File: ");
			var tempEvent : DatabaseHandlerEvent = new DatabaseHandlerEvent(DatabaseHandlerEvent.FILE_LOADED);
			tempEvent.dbItem = dbItem;
			CursorManager.removeBusyCursor();
			dispatchEvent(tempEvent);
		}
		
		private function errorFileHandler(event:SQLErrorEvent):void
		{
			debug("Error by open DB File: " + event.error.message);	
			CursorManager.removeBusyCursor();
			dispatchEvent(new DatabaseHandlerEvent(DatabaseHandlerEvent.FILE_LOAD_ERROR));
		}		
		
		//--------------------------------------------------------------------------
		//  Properties (getter, setter)
		//--------------------------------------------------------------------------
		public static function get INSTANCE():DatabaseHandler
		{
			if(_INSTANCE == null)
			{
				_INSTANCE = new DatabaseHandler(new SingletonEnforcer());
			}
			
			return _INSTANCE;
		}
	}
}

internal class SingletonEnforcer{}