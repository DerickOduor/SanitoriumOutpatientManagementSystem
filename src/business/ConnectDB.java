package business;

import java.sql.*;
import javax.sql.*;
import java.io.*;
import java.util.*;

public class ConnectDB {
	private Connection conn;
	private String sql_stmt;
	private Statement st;
	private ResultSet rs;
	
	public Connection getConn() {
		return this.conn;
	}
	public String getSql_stmt() {
		return this.sql_stmt;
	}
	public Statement getSt() {
		return this.st;
	}
	public ResultSet getRs() {
		return this.rs;
	}
	
	public ConnectDB(Connection conn) {
		this.conn=conn;
	}
	public void setConn(Connection c) {
		this.conn=c;
	} 
	public void setSql_stmt(String stmt) {
		this.sql_stmt=stmt;
	}
	public void setSt(Statement st) {
		this.st=st;
	}
	public void setResultSet(ResultSet rs) {
		this.rs=rs;
	}
	
	
}
