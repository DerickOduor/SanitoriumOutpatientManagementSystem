<%--
  Created by IntelliJ IDEA.
  User: Derick Oduor
  Date: 12/27/2017
  Time: 10:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="java.util.*"%>
<%@ page import="business.Records" %>
<%@ page import="business.RecordsOfficer" %>

<html>
<head>
    <title>Sanitorium Outpatient Management System</title>
    <script src="./jquery.js"></script>
    <script src="./bootstrap.min_1.js"></script>
    <link rel="stylesheet"href="./bootstrap.min_1.css"/>
</head>
<body>
<header role="banner" class="navbar navbar-fixed-top navbar-inverse">
    <div class="container">
        <a class="navbar-brand" href="http://localhost:8080/EgertonHospital/">SOMS</a>
        <div class="navbar-header">
            <button data-toggle="collapse-side" data-target=".side-collapse" data-target-2=".side-collapse-container" type="button" class="navbar-toggle pull-left"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
        </div>
        <div class="navbar-inverse side-collapse in">
            <nav role="navigation" class="navbar-collapse">
                <ul class="nav navbar-nav">
                    <%
                        RecordsOfficer recordsOfficer=(RecordsOfficer)session.getAttribute("logged_records_officer");
                        if(recordsOfficer==null){
                            out.println("abc123");
                        }else{
                    %>
                    <li class="active"><a href="http://localhost:8080/records_home.jsp/"><span class="glyphicon glyphicon-home"></span>&nbsp;Home</a></li>
                    <li><a href="http://localhost:8080/queue.jsp"><span class="glyphicon glyphicon-th-list"></span>&nbsp;View Records</a></li>
                    <li><a href="http://localhost:8080/new_record.jsp"><span class="glyphicon glyphicon-home"></span>&nbsp;New Record</a></li>
                    <li><a href="http://localhost:8080/served"><span class="glyphicon glyphicon-home"></span>&nbsp;Served</a></li>
                    <li><a href="http://localhost:8080/EgertonHospital/"><span class="glyphicon glyphicon-user"></span>&nbsp;<%=recordsOfficer.getName()%></a></li>
                    <li><a href="http://localhost:8080/EgertonHospital/"><span class="glyphicon glyphicon-logout"></span>&nbsp;Logout</a></li>
                    <%
                        }
                    %>
                </ul>
            </nav>
        </div>
    </div>
</header>

<div class="container">
    <div class="row">
        <div class="col-md-4">
            <a href="/new_record.jsp"class="btn btn-info">New Record</a>
        </div>
        <div class="col-md-6">
            <form action=""method="post"class="form form-inline">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search for...">
                    <span class="input-group-btn">
                        <button class="btn btn-info" type="button">Search</button>
                    </span>
                </div>
            </form>
        </div>
    </div>
    <div class="container">
        <%
        List<Records> recordsList=(List<Records>) request.getAttribute("recordsList");
        //Records records=(Records)request.getAttribute("recordsList");
            out.println("<table class=\"table table-bordered table-striped\">" +
                    "<tr><th>Name<th/><th>Reg. No.<th/><th>Phone<th/><th>Residence<th/><th>Kin<th/><th>Kin phone no.<th/></tr>");
            for (Records r:recordsList) {
                //out.println(r.getName()+" "+r.getPhone()+"\n");
                %>
                <tr><td><%= r.getName()%><td/><td><%=r.getId()%><td/><td><%=r.getPhone()%><td/><td><%=r.getResidence()%><td/><td><%=r.getRelative()%><td/><td><%=r.getRelative_phone()%><td/></tr>
                <%
            }
            out.println("</table>");
        %>
    </div>
</div>
</body>
</html>
<script>
    $(function(){
        var sideslider = $('[data-toggle=collapse-side]');
        var sel = sideslider.attr('data-target');
        var sel2 = sideslider.attr('data-target-2');
        sideslider.click(function(event){
            $(sel).toggleClass('in');
            $(sel2).toggleClass('out');
        });
    });
</script>
<style>
    body{
        padding-top: 50px;
        position: relative;
    }
    pre{
        tab-size: 8;
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
<%

%>