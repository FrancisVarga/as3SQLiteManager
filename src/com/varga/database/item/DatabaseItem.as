package com.varga.database.item{	
	//--------------------------------------------------------------------------
	//  imports
	//--------------------------------------------------------------------------
	import com.varga.database.query.DatabaseQuery;
	
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.EventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.events.SQLUpdateEvent;
	import flash.filesystem.File;
	import flash.utils.getTimer;
	
	import mx.managers.CursorManager;
	
	//--------------------------------------------------------------------------
	//  Metainformations
	//  example: [Event(name="Name_of_Event", type="Classpath_to_Event")]
	//--------------------------------------------------------------------------
	[Event(name="STATEMENT_RESULT", type="com.varga.database.item.DatabaseItemEvent")]
	[Event(name="STATEMENT_ERROR", type="com.varga.database.item.DatabaseItemEvent")]
	[Event(name="SQLCONNECTION_SHEMARESULT", type="com.varga.database.item.DatabaseItemEvent")]
	[Event(name="SQLCONNECTION_DELETED", type="com.varga.database.item.DatabaseItemEvent")]
	public class DatabaseItem extends EventDispatcher{
		
		//--------------------------------------------------------------------------
		//  Class constants
		//--------------------------------------------------------------------------
		private static const AUTHOR : String = "Francis Varga";
		private static const CLASSPATH : String = "package com.varga.database.DatabaseItem";
		private static const VERBOSE : Boolean = true;		
		
		//--------------------------------------------------------------------------
		//  Intern Private Variables
		//--------------------------------------------------------------------------
		private var debug : Function = nullFunction;
		
		//--------------------------------------------------------------------------
		//  Setter Getter Private Variables
		//--------------------------------------------------------------------------
		private var _sqlConnection : SQLConnection;
		private var _databaseFile : File;	
		private var _databaseURL : String;
		private var _sqlStatement : SQLStatement;
		
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
		 * @Desc: This Class DatabaseItem
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
		public function DatabaseItem()
		{
			
			if( VERBOSE ) debug = debugger;
			
			_sqlConnection = new SQLConnection();
			this.registrySQLConnectionEvents(_sqlConnection);
			
			_sqlStatement = new SQLStatement();
			this.registrySQLStatementEvents(_sqlStatement);
			
			_sqlStatement.sqlConnection = _sqlConnection;
			_databaseFile = new File();
		}	
		
		//--------------------------------------------------------------------------
		//  Overridden methods: DatabaseItem
		//--------------------------------------------------------------------------	
		
		//--------------------------------------------------------------------------
		//  Public methods
		//--------------------------------------------------------------------------
		public function executeStatement(statementText : String):void
		{
			CursorManager.setBusyCursor();
			_sqlStatement.text = statementText;
			_sqlStatement.execute();
		}
		
		public function loadShema():void
		{
			CursorManager.setBusyCursor();
			_sqlConnection.loadSchema();
		}
		
		public function createQuery():DatabaseQuery
		{
			var query : DatabaseQuery = new DatabaseQuery();
			
			query.sqlConnection = this._sqlConnection;
			query.sqlStatement = this._sqlStatement;
			query.dbFile = this._databaseFile;
			
			return query;
		}
		
		//--------------------------------------------------------------------------
		//  Private and Protected methods
		//--------------------------------------------------------------------------		
		private function registrySQLStatementEvents( sqlStatement : SQLStatement):void
		{
			sqlStatement.addEventListener(SQLErrorEvent.ERROR, statementSQLErrorHandler);
			sqlStatement.addEventListener(SQLEvent.RESULT, statementSQLResultHandler);
		}
		
		private function registrySQLConnectionEvents( sqlConnection : SQLConnection):void
		{
			sqlConnection.addEventListener(SQLEvent.SCHEMA,sqlConnectionShemaHandler);
			sqlConnection.addEventListener(SQLEvent.ANALYZE, sqlConnectionAnalyzeHandler);
			
			sqlConnection.addEventListener(SQLUpdateEvent.DELETE, sqlConnection_DELETE_Handler);
			sqlConnection.addEventListener(SQLUpdateEvent.INSERT, sqlConnection_INSERT_Handler);
			sqlConnection.addEventListener(SQLUpdateEvent.UPDATE, sqlConnection_UPDATE_Handler);
		}
		
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
		private function statementSQLResultHandler(event :SQLEvent):void
		{			
			var tempEvent : DatabaseItemEvent = new DatabaseItemEvent(DatabaseItemEvent.STATEMENT_RESULT);
			tempEvent.databaseResult = _sqlStatement.getResult();
			CursorManager.removeBusyCursor();
			dispatchEvent(tempEvent);
		}
		
		private function statementSQLErrorHandler(event : SQLErrorEvent):void
		{
			CursorManager.removeBusyCursor();
			debug("Error: " + event.error.message);	
		}
		
		private function sqlConnectionShemaHandler( event : SQLEvent):void
		{
			var tempEvent : DatabaseItemEvent = new DatabaseItemEvent(DatabaseItemEvent.SQLCONNECTION_SHEMARESULT);
			tempEvent.databaseShema = _sqlConnection.getSchemaResult();
			CursorManager.removeBusyCursor();
			dispatchEvent(tempEvent);
		}
		
		private function sqlConnection_DELETE_Handler( event : SQLEvent):void
		{
			debug("Update Event: " + event.type);
		}
		
		private function sqlConnection_INSERT_Handler( event : SQLEvent):void
		{
			debug("Update Event: " + event.type);
		}
		
		private function sqlConnection_UPDATE_Handler( event : SQLEvent):void
		{
			debug("Update Event: " + event.type);
		}
		
		private function sqlConnectionAnalyzeHandler(event : SQLEvent):void
		{
			debug("Event: " + event.type);
		}
		
		//--------------------------------------------------------------------------
		//  Properties (getter, setter)
		//--------------------------------------------------------------------------		
		public function get databaseFile() : File {
		        return _databaseFile;
		}
		
		public function get sqlConnection() : SQLConnection {
		        return _sqlConnection;
		}

		public function get databaseURL():String
		{
			return _databaseURL;
		}

		public function set databaseURL(value:String):void
		{
			_databaseURL = value;
			_databaseFile = File.applicationDirectory.resolvePath(value);
		}

		public function get sqlStatement():SQLStatement
		{
			return _sqlStatement;
		}
	}
}

internal class SingletonEnforcer{}