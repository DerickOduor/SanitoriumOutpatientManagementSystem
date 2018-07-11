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
    <!--<script src="js/jquery.js"></script>
    <script src="js/bootstrap.js"></script>
    <link rel="stylesheet"href="css/bootstrap.min.css"/>
    <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css" integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js" integrity="sha384-a5N7Y/aK3qNeh15eJKGWxsqtnX/wWdSZSKp+81YjTmS15nvnvxKHuzaWwXHDli+4" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>

    <script src="./bootstrap_4_0_0/js/bootstrap.bundle.min.js"></script>
    <script src="bootstrap_4_0_0/js/bootstrap.min.js"></script>
    <script src="js/jquery.js"></script>
    <script type="text/javascript" src="js/bootstrap-modal.js"></script>
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
                 RecordsOfficer recordsOfficer=(RecordsOfficer)session.getAttribute("logged_records_officer");
                 if(recordsOfficer==null){
                     String url = "/index.jsp";
                     response.sendRedirect(url);
                 }else{
            %>
            <li class="nav-item active">
                <a class="nav-link" href="http://localhost:8080/">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#"><span class="glyphicon glyphicon-th-list"></span>&nbsp;Records</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href='<%=response.encodeURL("/new_record.jsp")%>'><span class="glyphicon glyphicon-plus"></span>&nbsp;New Record</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#"><span class="glyphicon glyphicon-user"></span>&nbsp;<%=recordsOfficer.getName()%></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href='<%=response.encodeURL("/Logout?l=logged_records_officer")%>'><span class="glyphicon glyphicon-log-out"></span>&nbsp;Logout</a>
            </li>
            <%
                }
            %>
        </ul>
    </div>
</nav>
<br/>
<br/><br/><br/>
<div class="container main">
    <div class="row">
        <div class="col-md-4 pull-left">
            <a href='<%=response.encodeURL("/new_record.jsp")%>'class="btn btn-outline-info">New Record</a>
        </div>
        <div class="col-md-5 pull-right">
            <form action="/Search"method="post"class="form-inline my-2 my-lg-0">
                <div class="input-group">
                    <input type="text" name="search_key" class="form-control  mr-sm-2" placeholder="Search for..."required>
                    <input type="hidden"name="search_type"value="record"/>
                    <span class="input-group-btn">
                        <button class="btn btn-outline-info my-2 my-sm-0" type="submit"><span class="glyphicon glyphicon-search"></span>&nbsp;Search</button>
                    </span>
                </div>
            </form>
        </div>
    </div>
    <div class="container">
        <%
            List<Records> recordsList=(List<Records>) request.getAttribute("recordsList");
        %>
        <div class="container badge badge-secondary">
            Showing results for:&nbsp;<span class="badge badge-light"><%=recordsList.size()%></span>&nbsp;students.
        </div>
       <%
        //Records records=(Records)request.getAttribute("recordsList");
            out.println("<table class='table table-bordered table-striped table-hover table-responsive'>" +
                    "<tr><th>Name<th/><th>Patient Type</th><th>Reg. No.<th/><th>Staff Id</th><th>Nat. Id</th><th>Phone<th/><th>Residence<th/><th>Kin<th/><th>Kin phone no.<th/></tr>");
            for (Records r:recordsList) {
                //out.println(r.getName()+" "+r.getPhone()+"\n");
                %>
                <a href="<%=response.encodeURL("/PatientRecordsView.jsp")%>"id="p_link"><tr id="<%=r.getId()%>"><td><%= r.getName()%><td/><td><%=r.getPatientType()%></td><td><%=r.getRegno()%><td/><td><%=r.getStaffId()%></td><td><%=r.getNatId()%></td><td><%=r.getPhone()%><td/><td><%=r.getResidence()%><td/><td><%=r.getRelative()%><td/><td><%=r.getRelative_phone()%><td/></tr></a>
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
        $('tr').on('click',function () {
            var id=$(this).attr('id');
            window.open('<%=response.encodeURL("/PatientRecordsView.jsp")%>?id='+id,'_self');
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
    .main{
        padding-top: 15px;
        padding-left: 10px;
        padding-right: 10px;
        padding-bottom: 5px;
    }
    table{
        margin-top: 15px;
    }
    div.row{
        margin-bottom: 5px;
    }
    #p_link{
        cursor: pointer;
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