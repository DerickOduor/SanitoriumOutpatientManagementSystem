<%@ page import="business.LabExams" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="business.LabOfficer" %><%--
  Created by IntelliJ IDEA.
  User: Derick Oduor
  Date: 2/19/2018
  Time: 11:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sanitorium Outpatient Management System</title>
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
                LabOfficer labOfficer=(LabOfficer)session.getAttribute("logged_lab_tech");
                if(labOfficer==null){
                    String url = "/index.jsp";
                    response.sendRedirect(url);
                }else{
            %>
            <li class="nav-item">
                <a class="nav-link" href='<%=response.encodeURL("http://localhost:8080/lab_home.jsp")%>'>Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href='<%=response.encodeURL("http://localhost:8080/exam_progress.jsp")%>'>In Progress Exams <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href='<%=response.encodeURL("http://localhost:8080/done_exams.jsp")%>'>Processed Exams <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#"><span class="glyphicon glyphicon-user"></span>&nbsp;<%=labOfficer.getName()%></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href='<%=response.encodeURL("/Logout?l=logged_lab_officer")%>'><span class="glyphicon glyphicon-log-out"></span>&nbsp;Logout</a>
            </li>
            <%
                }
            %>
        </ul>
    </div>
</nav>
<br/>
<div class="container main">
    <%
        Class.forName("com.mysql.jdbc.Driver");
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital", "root", "");
            Statement statement = conn.createStatement();
            String sql="SELECT * FROM lab WHERE status='done'";
            ResultSet rs=statement.executeQuery(sql);
            List<LabExams> labExamsList=new ArrayList<>();
            while(rs.next()){
                labExamsList.add(new LabExams(rs.getString(6),rs.getString(7),rs.getString(3),rs.getString(2),rs.getInt(4),
                        rs.getString(5),rs.getInt(9),rs.getString(10),rs.getInt(1),rs.getString(12),rs.getString(11),
                        rs.getString(8),rs.getString(13),rs.getString(14),rs.getInt(15),rs.getString(16)));
            }
            if(labExamsList!=null){
    %>
    <table class="table table-bordered table-hover table-striped">
        <tr><th>Lab Id</th><th>Name<th/><th>Patient Type</th><th>Reg. No.<th/><th>Staff Id</th><th>Nat. Id</th>
            <th>Lab Exam<th/><th>Date sent<th/><th>Lab Result</th><th>Time completed</th><th>Status<th/></tr>
        <%
            for(LabExams l:labExamsList){
        %>
        <a href="<%=response.encodeURL("/PatientLabView.jsp")%>"id="p_link">
            <tr id="<%=l.getId()%>"class="<%=l.getPatType()%>">
                <td><%=l.getId()%></td>
                <td><%= l.getS_name()%><td/><td><%=l.getPatType()%></td><td><%=l.getS_regno()%><td/><td><%=l.getStaffId()%></td>
                <td><%=l.getNatId()%></td><td><%=l.getLab_exam()%><td/><td><%=l.getDate_sent()%></td><td><%=l.getLab_result()%></td><td><%=l.getTime_completed()%><td><%=l.getStatus()%></td>
            </tr>
        </a>
        <%
            }
        %>
    </table>
    <%
            }else{
                out.println("No done lab results!");
            }
        }catch(Exception e){
            out.println(e.getMessage());
        }
    %>
</div>
</body>
</html>
<script type="text/javascript">
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
            var patType=$(this).attr('class');
            //alert(id+" "+patType);
            window.open('<%=response.encodeURL("/PatientsLabView.jsp")%>?id='+id+'&show_results=yes','_self');
        });
    });
</script>
<style>
    body{
        position: relative;
        background-image: url("images/background4.jpg");
    }
    .main{
        padding-top: 30px;
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
