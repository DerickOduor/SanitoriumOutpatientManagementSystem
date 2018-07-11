package data;

import java.sql.*;
import javax.sql.*;
import java.io.*;
import java.util.*;
import business.ConnectDB;

public class DBIO{
	private Connection connect=null;
	private Statement statement=null;
	private PreparedStatement preparedStatement=null;
	private ResultSet resultSet=null;
	public ResultSet readDataBase() throws Exception{
		try {
			Class.forName("com.jdbc.mysql.Driver");
			connect=DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital","root","");
			statement=connect.createStatement();
			resultSet=statement.executeQuery("SELECT * FROM patient_history");
			return resultSet;
		}catch(Exception e) {
			return null;
		}
	}
	/*public static Statement returnStatement() {
		try {
			Statement st;
			Class.forName("com.jdbc.mysql.Driver");
			Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital","root","");
        	//con.getConn()=DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital","root","");
			st=conn.createStatement();
			return st;
		}catch(Exception e) {
			return null;
		}
	}*/

}
