<%--
  Created by IntelliJ IDEA.
  User: Derick Oduor
  Date: 1/15/2018
  Time: 10:40 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="business.ConnectDB"%>
<%@page import="data.DBIO"%>
<%@ page import="business.Doctor" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sanitorium Outpatient Management System</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css" integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js" integrity="sha384-a5N7Y/aK3qNeh15eJKGWxsqtnX/wWdSZSKp+81YjTmS15nvnvxKHuzaWwXHDli+4" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>

    <script src="./bootstrap_4_0_0/js/bootstrap.bundle.min.js"></script>
    <script src="bootstrap_4_0_0/js/bootstrap.min.js"></script>
    <script src="js/jquery.js"></script>
    <link rel="stylesheet" href="bootstrap_4_0_0/css/bootstrap-grid.min.css">
    <link rel="stylesheet" href="bootstrap_4_0_0/css/bootstrap-reboot.min.css">
    <link rel="stylesheet" href="bootstrap_4_0_0/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-inverse fixed-top navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="http://localhost:8080/">SOMS</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <%
                Doctor doctor=(Doctor) session.getAttribute("logged_doctor");
                if(doctor==null){
                    out.println("abc123");
                }else{
            %>
            <li class="nav-item">
                <a class="nav-link" href="http://localhost:8080/home.jsp"><span class="fa fa-home"></span>&nbsp;Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="http://localhost:8080/queue.jsp"><span class="fa fa-tasks"></span>&nbsp;Queue</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="http://localhost:8080/served"><span class="fa fa-check"></span>&nbsp;Served Patients</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="http://localhost:8080/pat_in_lab.jsp"><span class="fa fa-spinner"></span>&nbsp;Patients in lab<span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#"><span class="fa fa-user"></span>&nbsp;<%=doctor.getName()%></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/Logout?l=logged_doctor"><span class="fa fa-sign-out"></span>&nbsp;Logout</a>
            </li>
            <%
                }
            %>
        </ul>
    </div>
</nav>

<div class="container-fluid main">
    <%
        Class.forName("com.mysql.jdbc.Driver");
        try{
            Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital","root","");
            String sql="SELECT * FROM lab WHERE status='processing'";
            Statement st=conn.createStatement();
            ResultSet rs=st.executeQuery(sql);
            int count=0;
            if(rs.next()==true){
    %>
    <table class="table table-inverse table-sm table-bordered table-striped table-responsive table-hover">
        <thead><tr><th width="30%">Name</th><th width="10%">Reg. No.</th><th width="25%">Date completed</th></tr></thead>
        <% while(rs.next()){
            String name=rs.getString(2);
            int id=rs.getInt(1);
            String regno=rs.getString(3);
            count++;
        %>
        <a href="#"><tr id="<%= regno%>"class="table_row">
            <td><%= name %></td>
            <td><%= regno %></td>
            <td><%//= rs.getDate(11) %></td>
        </tr></a>
        <%
            }
        %>
    </table>
        <%
        }else{
        %>
        <div class="container">
            There are no patients in the lab!
        </div>
        <%
            }%>

    <%
    }catch(Exception e){
    %>
    <%= e.getMessage() %>
    <%
        }
    %>
</div>
</body>
</html>
<script>
    $(document).ready(function() {
        var sideslider = $('[data-toggle=collapse-side]');
        var sel = sideslider.attr('data-target');
        var sel2 = sideslider.attr('data-target-2');
        sideslider.click(function(event){
            $(sel).toggleClass('in');
            $(sel2).toggleClass('out');
        });
        $('.table_row').on('click',function(){
            var patient_id=$(this).attr('id');
            //alert(patient_id);
            window.open('patient.jsp?regno='+patient_id,'_self');
        });
    });
</script>
<style>
    body{
        position: relative;
    }
    pre{
        tab-size: 8;
    }
    thead{
        background:#d3d3d3;
    }
    .main{
        margin-top: 70px;
    }
    @media screen and (max-width: 768px) {
        .side-collapse-container{
            width:100%;
            position:relative;
            left:0;
            transition:left .4s;
        }
        .side-collapse-container.out{
            left:200px;
        }
        .side-collapse {
            top:50px;
            bottom:0;
            left:0;
            width:200px;
            position:fixed;
            overflow:hidden;
            transition:width .4s;
        }
        .side-collapse.in {
            width:0;
        }
        .input-group{
            width: 80%;
            margin-left: 10%;
            margin-right: 10%;
        }
    }
</style>
