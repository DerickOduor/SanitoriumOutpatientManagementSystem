<%@ page import="java.util.Enumeration" %>
<%@ page import="business.RecordsOfficer" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.List" %>
<%@ page import="business.Records" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: Derick Oduor
  Date: 1/30/2018
  Time: 7:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<%
    int pat_id=0,id=0;
    String r_name="",queue_status="",date_of_visit="";
    List<Records> recordsList=null;
    RecordsOfficer recordsOfficer=(RecordsOfficer)session.getAttribute("logged_records_officer");
    if(recordsOfficer!=null){
        r_name=recordsOfficer.getName();
        id=recordsOfficer.getId();
        Enumeration parameterNames=request.getParameterNames();
        if(parameterNames.hasMoreElements()){
            String parameterName=(String)parameterNames.nextElement();
            pat_id=Integer.parseInt(request.getParameter(parameterName));
        }
        //out.println(pat_id);
%>
<nav class="navbar navbar-inverse fixed-top navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="http://localhost:8080/">SOMS</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="http://localhost:8080/">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#"><span class="glyphicon glyphicon-th-list"></span>&nbsp;Records</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="#"><span class="glyphicon glyphicon-th-list"></span>&nbsp;Record View</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href='<%=response.encodeURL("/new_record.jsp")%>'><span class="glyphicon glyphicon-plus"></span>&nbsp;New Record</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#"><span class="glyphicon glyphicon-user"></span>&nbsp;<%=r_name%></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href='<%=response.encodeURL("/Logout?l=logged_records_officer")%>'><span class="glyphicon glyphicon-log-out"></span>&nbsp;Logout</a>
            </li>
            <%

            %>
        </ul>
    </div>
</nav>
<div class="container"id="main">
    <%
    try{
        recordsList=new ArrayList<>();
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital","root","");
        Statement statement=conn.createStatement();
        ResultSet rs_=statement.executeQuery("SELECT * FROM patients WHERE id='"+pat_id+"'");
        while (rs_.next()){
            recordsList.add(new Records(rs_.getInt(1),rs_.getString(2),rs_.getString(3),rs_.getString(5),rs_.getString(4),rs_.getString(10),rs_.getString(11),rs_.getString(12),rs_.getString(13),rs_.getString(7),rs_.getString(8),rs_.getString(9),rs_.getString(6),rs_.getString(14),rs_.getString(15),rs_.getInt(17),rs_.getString(16)));
        }
    }catch (Exception e){
        out.println(e.getMessage());
    }
    for(Records r:recordsList){
        String latest_visit_date="Not provided";
        int count=0;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital","root","");
            Statement statement=conn.createStatement();
            ResultSet rs=null;
            if(r.getPatientType().equalsIgnoreCase("Student")){
                String in_queue="SELECT MAX(date_of_visit) FROM patients_history WHERE regno='"+r.getRegno()+"'";
                rs=statement.executeQuery(in_queue);
            }else if(r.getPatientType().equalsIgnoreCase("Staff")){
                String in_queue="SELECT MAX(date_of_visit) FROM patients_history WHERE staffId='"+r.getStaffId()+"'";
                rs=statement.executeQuery(in_queue);
            }else if(r.getPatientType().equalsIgnoreCase("Non-student")){
                String in_queue="SELECT MAX(date_of_visit) FROM patients_history WHERE natId='"+r.getNatId()+"'";
                rs=statement.executeQuery(in_queue);
            }else if(r.getPatientType().equalsIgnoreCase("Underage")){
                String in_queue="SELECT MAX(date_of_visit) FROM patients_history WHERE name='"+r.getName()+"' AND patientType='Underage'";
                rs=statement.executeQuery(in_queue);
            }
            while(rs.next()){
                //queue_status=rs.getString(14);
                date_of_visit=rs.getDate(1).toString();
            }
            /*String date_visits="SELECT MAX(date_of_visit) FROM patients_history WHERE regno='"+r.getRegno()+"' OR natId='"+r.getNatId()+"'";
            ResultSet rs=statement.executeQuery(date_visits);
            out.println("\n\n\n\n\n\n"+rs.next());
            while(rs.next()){
                count+=1;
                latest_visit_date=rs.getString("date_of_visit");
                out.println("\n\n\n\n\n\n"+latest_visit_date+count);
            }
            if(count==0){
                date_visits="SELECT MAX(date_of_visit) FROM patients_history WHERE staffId='"+r.getStaffId()+"'";
                rs=statement.executeQuery(date_visits);
                while(rs.next()){
                    count+=1;
                    latest_visit_date=rs.getString(16);
                    out.println("\n\n\n\n\n\n"+latest_visit_date+count);
                }
                if(count==0){
                    date_visits="SELECT MAX(date_of_visit) FROM patients_history WHERE name='"+r.getName()+"' AND Underage='True'";
                    rs=statement.executeQuery(date_visits);
                    while(rs.next()){
                        count+=1;
                        latest_visit_date=rs.getString(16);
                        out.println("\n\n\n\n\n\n"+latest_visit_date+count);
                    }
                }
            }*/
        }catch (Exception e){
            out.println(e.getMessage());
        }
    %>
        <div id="queueMsg"></div>
        <div class="container row about">
            <div class="col-md-1">
                <img src="images/patienticon.png"alt="patient icon"height="50"width="45"/>
            </div>
            <div class="col-md-5">
                <span id="pat_name"><b>Patient Name:</b>&nbsp;<%=r.getName()%></span>
            </div>
            <div class="col-md-4">
                <input type="hidden"value="<%=date_of_visit%>"id="date_o_visit"/>
                <%
                //String d_=date_of_visit.substring(0,10);
                    Date now=new Date();
                    DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String d_=dateFormat.format(now).toString().substring(0,10);
                    if(d_.equalsIgnoreCase(date_of_visit)){
                %>
                <a href="#"id="queueTag"disabled><button class="btn btn-outline-info" id="<%=r.getId()%>"disabled>Patient in Queue</button></a>
                <%
                    }else{
                %>
                <a href="#"id="queueTag"><button class="btn btn-outline-info" id="<%=r.getId()%>">Add to doctor's queue</button></a>
                <%
                    }
                %>

            </div>
        </div>
        <!--<div class="container row">
            <div class="col-md-5">
                <span><span class="fa fa-calender"></span>&nbsp;<b>Recent Visit Date:</b>&nbsp;<%=latest_visit_date%></span>
            </div>
        </div>-->
        <div class="container row"style="padding:30px;">
            <div class="col-md-6">
                <span><b>Patient Type:</b>&nbsp;<%=r.getPatientType()%></span>
            </div>
            <%
            if(r.getPatientType().equalsIgnoreCase("Student")){
                %><div class="col-md-4"><span><b>Regno. No.:</b>&nbsp;<%=r.getRegno()%></span></div><%
            }else if(r.getPatientType().equalsIgnoreCase("Non-Student")){
                %><div class="col-md-4"><span><b>National ID No.:</b>&nbsp;<%=r.getNatId()%></span></div><%
            }else if(r.getPatientType().equalsIgnoreCase("Staff")){
                %><div class="col-md-4"><span><b>Staff Id:</b>&nbsp;<%=r.getStaffId()%></span></div><%
            }else if(r.getPatientType().equalsIgnoreCase("Underage")){
                %><div class="col-md-4"><span><b>Id:</b>&nbsp;<%=r.getPatientType()%></span></div><%
            }
            %>
            <div class="col-md-4">
                <span><b>Date registered:</b>&nbsp;<%=r.getD_o_a()%></span>
            </div>
        </div>
        <%
        if(r.getPatientType().equalsIgnoreCase("Student")){
        %>
        <div class="container row">
            <div class="col-md-4">
                <span><b>Faculty:</b>&nbsp;<%=r.getFaculty()%></span>
            </div>
            <div class="col-md-4">
                <span><b>Department:</b>&nbsp;<%=r.getDepartment()%></span>
            </div>
            <div class="col-md-4">
                <span><b>Programme:</b>&nbsp;<%=r.getCourse()%></span>
            </div>
        </div>
        <%
        }
        %>
        <div class="container row">
            <div class="col-md-4">
                <span><b>Date of birth:</b>&nbsp;<%=r.getD_o_b()%></span>
            </div>
            <div class="col-md-4">
                <span><b>Home Address:</b>&nbsp;<%=r.getHome_address()%></span>
            </div>
        </div>
        <div class="container row">
            <div class="col-md-4">
                <span><b>Relative Name:</b>&nbsp;<%=r.getRelative()%></span>
            </div>
            <div class="col-md-4">
                <span><b>Relative Phone No.:</b>&nbsp;<%=r.getRelative_phone()%></span>
            </div>
        </div>
    <%
    }
    %>
</div>
<%
}else{
        String url = "/index.jsp";
        response.sendRedirect(url);
    }

%>
</body>
</html>
<script>
    $(function(){
        var date_of_visit=$('#date_o_visit').val();


        var sideslider = $('[data-toggle=collapse-side]');
        var sel = sideslider.attr('data-target');
        var sel2 = sideslider.attr('data-target-2');
        sideslider.click(function(event){
            $(sel).toggleClass('in');
            $(sel2).toggleClass('out');
        });
        $('.btn-outline-info').on('click',function(){
            var id=$(this).attr('id');
            $.ajax({
                url:'/AddToQueue',
                method:'POST',
                data:{'pat_id':id},
                success:function(msg){
                    //alert(msg);
                    if(msg=="queued"){
                        $('#queueMsg').html('<div class="alert alert-success" role="alert">\n' +
                            '  <strong>Success!</strong> Patient added to queue.\n' +
                            '</div>');
                        setTimeout(function(){$('#queueMsg').slideUp('700','linear');},5000);
                        $('.btn-outline-info').addClass('disabled');
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
    pre{
        tab-size: 8;
    }
    #main{
        padding:50px;
    }
    #pat_name{
        font-size: 18px;
        font-family: Tahoma;
    }
    .container.row{
        font-family: Tahoma;
        padding: 30px;
    }
    .container.row.about{
        padding: 30px;
        border-bottom: 1px solid #0f0f0f;
    }
    a.btn-outline-info{
        color: #003eff;
    }
    a.btn-outline-info:hover{
        color: #fff;
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
    }
</style>