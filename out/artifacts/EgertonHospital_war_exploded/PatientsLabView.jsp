<%@ page import="business.LabOfficer" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %><%--
  Created by IntelliJ IDEA.
  User: Derick Oduor
  Date: 2/19/2018
  Time: 7:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String name="",regno="",lab_tech_name="",status="",staffId="",patType_="",date_of_visit="",fill_results="";
%>
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
<%
String lab_exam="",p_name="",lab_result="",show_results="";
int id=0;
%>
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
                <a class="nav-link" href='#'>Fill Results <span class="sr-only">(current)</span></a>
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
    <br/><br/><br/>
    <div id="view_lab_exam">
<%
    Date now=new Date();
    DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Enumeration parameterNames=request.getParameterNames();
    ResultSet rs=null;
    if(parameterNames.hasMoreElements()==true) {
        while (parameterNames.hasMoreElements()) {
            String parameterName = (String) parameterNames.nextElement();
            if (parameterName.equalsIgnoreCase("id")) {
                regno = request.getParameter(parameterName);
            } else if (parameterName.equalsIgnoreCase("fill_results")) {
                fill_results = request.getParameter(parameterName);
            }else if (parameterName.equalsIgnoreCase("show_results")) {
                show_results = request.getParameter(parameterName);
            }
        }
        Class.forName("com.mysql.jdbc.Driver");
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital", "root", "");
            Statement statement = conn.createStatement();

            /*if(patType_.equalsIgnoreCase("Student")){
                String in_queue="SELECT MAX(date_of_visit) FROM lab WHERE regno='"+regno+"'";
                rs=statement.executeQuery(in_queue);
            }else if(patType_.equalsIgnoreCase("Staff")){
                String in_queue="SELECT MAX(date_of_visit) FROM lab WHERE staffId='"+regno+"'";
                rs=statement.executeQuery(in_queue);
            }else if(patType_.equalsIgnoreCase("Non-Student")){
                String in_queue="SELECT MAX(date_of_visit) FROM lab WHERE natId='"+regno+"'";
                rs=statement.executeQuery(in_queue);
            }else if(patType_.equalsIgnoreCase("Underage")){
                String in_queue="SELECT MAX(date_of_visit) FROM lab WHERE name='"+regno+"' AND patientType='Underage'";
                rs=statement.executeQuery(in_queue);
            }
            while(rs.next()){
                //queue_status=rs.getString(14);
                date_of_visit=rs.getDate(1).toString();
            }

            if(patType_.equalsIgnoreCase("Student")){
                rs=statement.executeQuery("SELECT * FROM lab WHERE regno='"+regno+"' AND date_sent='"+date_of_visit+"'");
            }else if(patType_.equalsIgnoreCase("Staff")){
                rs=statement.executeQuery("SELECT * FROM lab WHERE staffId='"+regno+"' AND date_sent='"+date_of_visit+"'");
            }else if(patType_.equalsIgnoreCase("Non-Student")){
                rs=statement.executeQuery("SELECT * FROM lab WHERE natId='"+regno+"' AND date_sent='"+date_of_visit+"'");
            }else if(patType_.equalsIgnoreCase("Underage")){
                rs=statement.executeQuery("SELECT * FROM lab WHERE name='"+regno+"' AND date_sent='"+date_of_visit+"'");
            }*/
            rs=statement.executeQuery("SELECT * FROM lab WHERE id='"+regno+"'");
            while (rs.next()){
                lab_exam=rs.getString(6);
                id=rs.getInt(1);
                p_name=rs.getString(2);
                lab_result=rs.getString(7);
            %>
            <input type="hidden"id="st"value="<%=fill_results%>"/>
        <input type="hidden"id="sh"value="<%=show_results%>"/>
            <div id="labMessage"></div>
            <div class="row">
                <div class="col-md-4"style="border: solid 1px #000000;padding: 8px;"><b>Name:</b>&nbsp;<%=rs.getString(2)%></div>
                <div class="col-md-4"style="border: solid 1px #000000;padding: 8px;"><b>Date sent:</b>&nbsp;<%=rs.getString(12)%></div>
                <div class="col-md-4"style="border: solid 1px #000000;padding: 8px;"><b>Sent by:</b> &nbsp;<%=rs.getString(5)%></div>
            </div>
            <div class="row">
                <div class="col-md-4"style="border: solid 1px #000000;padding: 8px;"><b>Lab exam:</b>&nbsp;<%=rs.getString(6)%></div>
                <div class="col-md-4"style="border: solid 1px #000000;padding: 8px;"><b>Status:</b>&nbsp;<%=rs.getString(13)%></div>
            </div>
            <div class="row" style="border: solid 1px #000000;padding: 8px;">
                <div class="col-md-12">
                <%
                if(rs.getString(13).equalsIgnoreCase("Pending")){
                %>
                <!--<form action="/BeginLab" method="POST" id="beginLab">-->
                    <div id="sendStatus">
                    <input type="hidden"name="lab_exam"value="<%=rs.getString(6)%>"id="lab_exam_input"/>
                    Click on the button to begin processing.&nbsp;<button class="btn btn-outline-info beginLab" id="<%=rs.getInt(1)%>">Begin</button>
                    </div>
                <!--</form>-->
                <%
                }else if(rs.getString(13).equalsIgnoreCase("Processing")){
                %>
                <div style="background: red;padding: 10px;color: #fff">This lab exam is already in processing.</div>
                <%
                }
                %>
                </div>
            </div>
            <%
            }
        }catch (Exception e){
            out.println(e.getMessage());
        }
    }else{
        response.sendRedirect("lab_home.jsp");
    }
%>
    </div>
    <div id="enter_results">
        <div style="padding: 15px;"><b>Name:</b>&nbsp;<%=p_name%></div>
        <form action="/EnterLabResults" method="POST">
            <input type="hidden" name="id"value="<%=id%>"/>
            <div class="form-group row">
                <div class="col-md-2"><b>Lab exam:</b>&nbsp;</div>
                <div class="col-md-6"><%=lab_exam%></div>
            </div>
            <div class="form-group">
                <label for="additional_info" class="control-label">Lab Results</label>
                <textarea rows="3" cols="1"name="lab_results"class="form-control"placeholder="Results"required></textarea>
            </div>
            <button type="submit" class="btn btn-outline-success">Send</button>
        </form>
    </div>
    <div id="show_results">
        <div class="row">
            <div class="col-md-2"><b>Lab Exam:</b>&nbsp;</div>
            <div class="col-md-6"><%=lab_exam%></div>
        </div>
        <div class="row">
            <div class="col-md-2"><b>Result:</b>&nbsp;</div>
            <div class="col-md-6"><%=lab_result%></div>
        </div>
    </div>
</div>
</body>
</html>
<script type="text/javascript">
    $(function(){
        $('#enter_results,#show_results').hide();
        check_st();
        function check_st(){
            var fill_results=$('#st').val();
            var show_results=$('#sh').val();
            if(fill_results=='yes'){
                $('#view_lab_exam').hide();
                $('#enter_results').show();
                $('#show_results').hide();
            }else if(show_results=='yes'){
                $('#view_lab_exam').hide();
                $('#enter_results').hide();
                $('#show_results').show();
            }
        }
        var sideslider = $('[data-toggle=collapse-side]');
        var sel = sideslider.attr('data-target');
        var sel2 = sideslider.attr('data-target-2');
        sideslider.click(function(event){
            $(sel).toggleClass('in');
            $(sel2).toggleClass('out');
        });
        $('.beginLab').click(function(){
            var lab_id=$(this).attr('id');
            var lab_exam=$('#lab_exam_input').val();
            $.ajax({
                url:'http://localhost:8080/BeginLab',
                method:'POST',
                data:{'lab_id':lab_id,'begin_lab':'yes','lab_exam':lab_exam},
                success:function(msg){
                    alert(msg);
                    if(msg=="Status updated!"){
                        $('#labMessage').html("<div class='alert alert-info' role='alert'id='lab_message'>Patient has been sent to the lab! Waiting for results.</div>");
                        setTimeout(hideMsg,6000);
                        function hideMsg(){
                            $('#labMessage').slideUp('900','linear');
                        }
                        $('#sendStatus').css('background','red');
                        $('#sendStatus').css('color','#fff');
                        $('#sendStatus').css('padding','10px');
                        $('#sendStatus').html('This lab exam is already in processing.');
                    }
                },
                error:function(){
                    alert('Something went wrong!');
                }
            });
        });
    });
</script>
<style>
    body{
        position: relative;
    }
    .main{
        padding-top: 30px;
        padding-left: 10px;
        padding-right: 10px;
        padding-bottom: 5px;
    }
    div.row{
        margin-bottom: 5px;
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
