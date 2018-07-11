<%--
  Created by IntelliJ IDEA.
  User: Derick Oduor
  Date: 1/15/2018
  Time: 11:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="java.util.*"%>
<%@ page import="business.Doctor" %>
<%@ page import="business.Records" %>
<!---->

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sanitorium Outpatient Management System</title>
    <!--<script src="js/jquery.js"></script>
    <script src="js/bootstrap.js"></script>
    <link rel="stylesheet"href="css/bootstrap.min.css"/>-->
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
                <a class="nav-link" href="http://localhost:8080/home.jsp"><span class="fa fa-home"></span>&nbsp;Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="http://localhost:8080/queue.jsp"><span class="fa fa-tasks"></span>&nbsp;View Queue</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="http://localhost:8080/served"><span class="fa fa-check"></span>&nbsp;Served Patients</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="http://localhost:8080/pat_in_lab.jsp"><span class="fa fa-spinner"></span>&nbsp;Patients in lab</a>
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
<div class="container-fluid">

    <%
        List<Records> servedList=(List<Records>) request.getAttribute("recordsList");
        //Records records=(Records)request.getAttribute("recordsList");
        if(servedList.size()!=0){
            out.println("<table class='table table-bordered table-striped'>" +
                    "<tr><th>Name<th/><th>Reg. No.<th/><th>Phone<th/><th>Residence<th/><th>Kin<th/><th>Kin phone no.<th/></tr>");
            for (Records r:servedList) {
                //out.println(r.getName()+" "+r.getPhone()+"\n");
    %>
    <tr><td><%= r.getName()%><td/><td><%=r.getId()%><td/><td><%=r.getPhone()%><td/><td><%=r.getResidence()%><td/><td><%=r.getRelative()%><td/><td><%=r.getRelative_phone()%><td/></tr>
    <%
            }
            out.println("</table>");
        }else{
            out.println("<div class='alert alert-warning' role='alert'>There are no served patients yet!</div>");
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
    });
</script>
<style>
    body{
        position: relative;
    }
    pre{
        tab-size: 8;
    }
    .container-fluid{
        margin-top: 70px;
        padding-right: 10px;
        padding-left: 10px;
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

