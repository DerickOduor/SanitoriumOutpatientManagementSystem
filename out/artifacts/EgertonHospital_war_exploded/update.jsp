<%@ page language = "java" contentType = "text/html; charset = ISO-8859-1"
	import="java.io.*"
	import="java.sql.*"
	import="java.util.*"
	import="javax.sql.*"
	import = "java.sql.ResultSet"
	import = "java.sql.Statement"
	import = "java.sql.Connection"
	import = "java.sql.DriverManager"
	import = "java.sql.SQLException"
%>
<%
	Connection con = null;  
	PreparedStatement ps = null;
	ResultSet rs = null;
	Statement stmt = null;
	String name = request.getParameter("name");
	Integer id = 5;
%>
<html>
<head>
	<title>Updating Database</title>
</head>
<body>
<%
	String complains=request.getParameter("complains");
	String regno=request.getParameter("regno");
        //PrintWriter out=response.getWriter();
        out.println("Complains "+complains
                    +"\n Regno "+regno);
	try {
		Class.forName("com.mysql.jdbc.Driver");
		con =DriverManager.getConnection ("jdbc:mysql://localhost:3306/egertonhospital", "root", "");
		ps = con.prepareStatement("update patients_history set complains = ? where regno = ?");
		ps.setString(2, regno);
		ps.setString(1, complains);
		ps.executeUpdate();
		%>
			<br>
		<%
		if(ps.executeUpdate()>=1){
		%>	
					<%="Database successfully Updated!"%>
					
		<%	
		}

	}catch(SQLException e){
            %>
            <%= e.getMessage()%>
            <%
        }
        
%>
</body>
</html>