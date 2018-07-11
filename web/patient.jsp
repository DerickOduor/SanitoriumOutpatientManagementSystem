<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*"%>
    <%@page import="javax.sql.*"%>
    <%@page import="java.util.*"%>
    <%@page import="java.io.*"%>
<%@ page import="business.Doctor" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    String name="",regno="",regno_="",doctor_name="",status="",staffId="",patType_="",complainsUpdated="";
    int doctor_id=0,natId=0;
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sanitorium Outpatient Management System</title>
    <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css" integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js" integrity="sha384-a5N7Y/aK3qNeh15eJKGWxsqtnX/wWdSZSKp+81YjTmS15nvnvxKHuzaWwXHDli+4" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>-->

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css" integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js" integrity="sha384-a5N7Y/aK3qNeh15eJKGWxsqtnX/wWdSZSKp+81YjTmS15nvnvxKHuzaWwXHDli+4" crossorigin="anonymous"></script>

    <script src="./bootstrap_4_0_0/js/bootstrap.bundle.min.js"></script>
    <script src="bootstrap_4_0_0/js/bootstrap.min.js"></script>
    <script src="js/jquery.js"></script>
    <script type="text/javascript" src="js/bootstrap-modal.js"></script>
    <link rel="stylesheet" href="bootstrap_4_0_0/css/bootstrap-grid.min.css">
    <link rel="stylesheet" href="bootstrap_4_0_0/css/bootstrap-reboot.min.css">
    <link rel="stylesheet" href="bootstrap_4_0_0/css/bootstrap.min.css">

    <script src="/js/jquery-ui.min.js"></script>
    <link rel="stylesheet"href="/css/jquery-ui.min.css"/>

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
                String d;
                if(doctor==null){
                    out.println("abc123");
                }else{
                    doctor_id=doctor.getId();
                    doctor_name=doctor.getName();
            %>
            <li class="nav-item">
                <a class="nav-link" href="http://localhost:8080/home.jsp"><i class="fa fa-home" aria-hidden="true"></i>
                    Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="http://localhost:8080/queue.jsp"><i class="fa fa-tasks" aria-hidden="true"></i>
                    &nbsp;Queue</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="http://localhost:8080/served"><i class="fa fa-check" aria-hidden="true"></i>&nbsp;Served Patients</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="p_h" href="#"><i class="fa fa-clock-o" aria-hidden="true"></i>&nbsp;Patient's History</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="n" href="#"><i class="fa fa-globe" aria-hidden="true"></i>&nbsp;Notifications<span class="badge badge-pill badge-light" id="not_count"></span></a>
                <div id="notificationContainer">
                    <div id="notificationTitle">Notifications</div>
                    <div id="notificationsBody" class="notifications"></div>
                    <div id="notificationFooter"><a href="#">See All</a></div>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="pr" href="#"><i class="fa fa-user" aria-hidden="true"></i>&nbsp;<%=doctor.getName()%></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/Logout?l=logged_doctor"><i class="fa fa-sign-out" aria-hidden="true"></i>&nbsp;Logout</a>
            </li>
            <%
                }
            %>
        </ul>
    </div>
</nav>
        <div id="inner_nav"></div>
        <!--Main-->
<div class="container-fluid"id="main">
    <!-- <a data-toggle="modal" href="#myModal" class="btn btn-primary">Send patient to lab</a> <br/><br/>-->
    <%
        regno="";
        Date now=new Date();
        DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Enumeration parameterNames=request.getParameterNames();
        ResultSet rs=null;
        if(parameterNames.hasMoreElements()==true){
            while(parameterNames.hasMoreElements()){
                String parameterName=(String)parameterNames.nextElement();
                if(parameterName.equalsIgnoreCase("regno")){
                    regno=request.getParameter(parameterName);
                }else if(parameterName.equalsIgnoreCase("patientType")){
                    patType_=request.getParameter(parameterName);
                }else if(parameterName.equalsIgnoreCase("complainsUpdated")){
                    complainsUpdated=request.getParameter(parameterName);
                }
            }
                Class.forName("com.mysql.jdbc.Driver");
                try{
                    Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital","root","");
                    Statement statement=conn.createStatement();
                    if(patType_.equalsIgnoreCase("Student")){
                        rs=statement.executeQuery("SELECT * FROM patients_history WHERE regno='"+regno+"' AND patientType='Student'");
                    }else if(patType_.equalsIgnoreCase("Staff")){
                        rs=statement.executeQuery("SELECT * FROM patients_history WHERE staffId='"+regno+"' AND patientType='Staff'");
                    }else if(patType_.equalsIgnoreCase("Non-Student")){
                        rs=statement.executeQuery("SELECT * FROM patients_history WHERE natId='"+regno+"' AND patientType='Non-Student'");
                    }else if(patType_.equalsIgnoreCase("Underage")){
                        rs=statement.executeQuery("SELECT * FROM patients_history WHERE name='"+regno+"' AND patientType='Underage'");
                    }

                    while(rs.next()){
                        d=dateFormat.format(now).toString().substring(0,10);
                        if(d.equalsIgnoreCase(rs.getDate(16).toString())){
                            name=rs.getString(2);
                            regno_=rs.getString(3);
                            status=rs.getString(13);
                            String patType=rs.getString(14);
                            staffId=rs.getString(19);
                            natId=rs.getInt(17);

    %>
    <div class="container">
        <h1>Patient Ailment Form</h1>
        <div class="row"id="patient_details">
            <div class="col-sm-3">
                Name:&nbsp;<b><%=name %></b>
            </div>
            <%
            if(patType.equalsIgnoreCase("Student")){
                %>
            <div class="col-sm-3">
            Reg. No.:&nbsp;<b><%=regno_ %></b>
            </div>
            <%
            }else if(patType.equalsIgnoreCase("Staff")){
                %>
            <div class="col-sm-3">
                Staff Id.:&nbsp;<b><%=staffId %></b>
            </div>
            <%
            }else if(patType.equalsIgnoreCase("Non-Student")){
                %>
            <div class="col-sm-3">
                National Id.:&nbsp;<b><%=natId %></b>
            </div>
            <%
            }else if(patType.equalsIgnoreCase("Underage")){
                %>
            <div class="col-sm-3">
                Patient Type:&nbsp;<b><%=rs.getString(18) %></b>
            </div>
            <%
            }
            %>
        </div>
        <div class="container"id="fill_complains">
            <%
            if(complainsUpdated.equalsIgnoreCase("ok")){
            %>
            <div class="alert alert-success" role="alert" id="complainsUpdate">
                <strong>Success!</strong> Patient's complains has been updated!
            </div>
            <%
            }
            %>

            <%
                if(status=="lab"){
                    out.println("<div class='alert alert-info' role='alert'id='lab_message'>Patient has been sent to the lab! Waiting for results.</div>");
                }else{
                    out.println("<div class='alert alert-info' role='alert'id='lab_message'></div>");
                }
            %>

            <form action="complains"method="post"class="form">
                <input type="hidden"name="regno" class="sp_reg" id="<%= regno%>" value="<%= regno%>"/>
                <input type="hidden"name="patType"value="<%=patType_%>">
                <div class="form-group">
                    <label class="control-label">Complains</label>
                    <textarea rows="5" cols="1"class="form-control"name="complains"placeholder="Complains"required></textarea>
                </div>
                <div class="form-group">
                    <label class="control-label">Additional Information</label>
                    <textarea rows="5" cols="1"class="form-control"name="additional_info"placeholder="Additional information"required></textarea>
                </div>
                <div class="form-group">
                    <a href="#" id="labBtn" class="btn btn-outline-warning">Send patient to lab</a>
                    <!--<a data-toggle="modal" href="#myModal" id="labBtn" class="btn btn-outline-warning">Send patient to lab</a>-->
                </div>
                <div class="form-group"id="submit_btn">
                    <button type="submit" class="btn btn-outline-primary">Submit</button>
                </div>
            </form>
        </div>
    </div>
    <%
                        }


                    }
                }catch(Exception e){
                    out.println(e.getMessage());
                }

        }else{
            response.sendRedirect("queue.jsp");
        }
    %>
</div>

        <div class="container"id="patient_history">
            <%
            try{
                Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/egertonhospital","root","");
                Statement statement=conn.createStatement();
                rs=statement.executeQuery("SELECT * FROM patients_history WHERE regno='"+regno_+"' AND served ='served'");
            %>
            <table class="table table-striped table-bordered table-hover">
                <tr><th>Date</th><th>Complains</th><th>Diagnosis</th><th>Prescription</th></tr>
            <%
                while(rs.next()){
                %>
                <tr><td><%=rs.getDate(16)%></td><td><%=rs.getString(4)%></td><td><%=rs.getString(10)%></td><td><%=rs.getString(5)%></td></tr>
                <%
                }
            %>
            </table>
            <%
            }catch (Exception e){

            }
            %>
        </div>
        <div class="container"id="diagnosis">
        
        </div>
        <div class="container"id="prescription">
        
        </div>
        <div class="container"id="lab_results">
        
        </div>
        

<div id="labDialog" title="Lab Exam">
    <form action="/Lab2"method="POST"class="form"id="lab_form">
        <input type="hidden"name="regno"value="<%=regno%>"id="r"/>
        <input type="hidden"name="name"value="<%=name%>"/>
        <input type="hidden"name="patType"value="<%=patType_%>"id="pt"/>
        <input type="hidden"name="process_lab"value="<%=true%>"/>
        <input type="hidden"name="doctor_name"value="<%=doctor_name%>"/>
        <input type="hidden"name="doctor_id"value="<%=doctor_id%>"/>

        <div class="form-group">
            <label for="lab_exam" class="control-label">Test</label>
            <textarea rows="3" cols="1"name="lab_exam"class="form-control"placeholder="Lab exam"required></textarea>
        </div>
        <div class="form-group">
            <label for="additional_info" class="control-label">Additional Information</label>
            <textarea rows="3" cols="1"name="additional_info"class="form-control"placeholder="Additional Information or N/A"required></textarea>
        </div>
        <button type="submit" class="btn btn-outline-success">Send</button>
    </form>
    <div class="loader"></div>
</div>
<!-- Modal -->
	<!--<div class="modalBox">
  <div class="modal" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">

            <h4 class="modal-title">Lab exam</h4>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        </div>
        <div class="modal-body">
          <form action="/Lab2"method="POST"class="form"id="lab_form">
              <input type="hidden"name="regno"value="<%//=regno_%>"/>
              <input type="hidden"name="name"value="<%//=name%>"/>
              <input type="hidden"name="process_lab"value="<%//=true%>"/>
              <input type="hidden"name="doctor_name"value="<%//=doctor_name%>"/>
              <input type="hidden"name="doctor_id"value="<%//=doctor_id%>"/>

              <div class="form-group">
                <label for="lab_exam" class="control-label">Test</label>
                <textarea rows="3" cols="1"name="lab_exam"class="form-control"placeholder="Lab exam"required></textarea>
              </div>
              <div class="form-group">
                <label for="additional_info" class="control-label">Additional Information</label>
                <textarea rows="3" cols="1"name="additional_info"class="form-control"placeholder="Additional Information or N/A"required></textarea>
              </div>
              <button type="submit" class="btn btn-outline-success">Send</button>
           </form>  
            <div class="loader"></div>
       </div>
        <div class="modal-footer">
          <a href="#" class="btn btn-outline-danger" data-dismiss="modal">Close</a>
        </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div><!-- /.modal -->
</div>-->
</body>
</html>
<script>
$(document).ready(function() {
    $('#labBtn').on('click',function(e){
        $('#labDialog').dialog({
            draggable:false
        });
    });

    setTimeout(hideMsg,6000);
    function hideMsg() {
        $('#complainsUpdate').slideUp('900','linear');
    }
    $("#n").click(function()
    {
        $("#notificationContainer").fadeToggle(300);
        $("#notification_count").fadeOut("slow");
        return false;
    });

//Document Click hiding the popup
    $(document).click(function()
    {
        $("#notificationContainer").hide();
    });

    $('#patient_history').hide();
    $('#diagnosis').hide();
    $('#prescription').hide();
    $('#lab_results').hide();

    $('#p_h').on('click',function (e) {
       e.preventDefault();
       $('#main').hide();
        $('#patient_history').show();
        $('#diagnosis').hide();
        $('#prescription').hide();
        $('#lab_results').hide();
    });

    check_lab_results();
    setInterval(check_lab_results,10000);

    //window.open('/Lab','_self');

    function check_lab_results() {
        var patType=$('#pt').val();
        //var regno=$('.sp_reg').attr("id");
        var regno=$('#r').val();
        var not_count=0;
        alert(patType+" "+regno);
        $.ajax({
            url:'/CheckLabResults',
            method:'POST',
            data:{'regno_in_lab':regno,'patTYpe':patType},
            //dataType:'json',
            success:function(msg){
                alert(msg);

                /*if(msg!="None"||msg!="Empty"){
                    $('#not_count').addClass('badge');
                    //$('#not_count').html(msg);

                    $.each(msg,function (key, value) {
                        //alert(value['lab_exam']);
                        not_count+=not_count;
                    })
                    $('#not_count').html(not_count);
                }else{

                }*/
            },
            error:function () {
                alert('Something went wrong!');
            }
        });
    }

    var filter = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;

    var sideslider = $('[data-toggle=collapse-side]');
    var sel = sideslider.attr('data-target');
    var sel2 = sideslider.attr('data-target-2');
    sideslider.click(function(event){
        $(sel).toggleClass('in');
        $(sel2).toggleClass('out');
    });
    
    $('.modal-footer').hide();
    $('#lab_message').hide();
    $('.loader').hide();
    $('#lab_form').on('submit',function(e){
    	e.preventDefault();
    	$('#lab_form').hide();
        $('.loader').show();
    	var form_data=$(this).serialize();
    	var u=$(this).attr('action');
    	var m=$(this).attr('method');

    	//alert(form_data+"  Action->"+u+"  Method->"+m);

        $.ajax({
            url:u,
            method:m,
            data:form_data,
            success:function(msg){
                //alert(msg);
                if(msg=="ok"){
                    //$('.modal-footer').show();
                    $('.loader').hide();
                    $('#labDialog').html('<div class="alert alert-info" role="alert"><b>Lab exam sent to the lab for examination</b></div>');
                    //$('.modal-body').html('<div class="alert alert-info" role="alert"><b>Lab exam sent to the lab for examination</b></div>');
                    $('#lab_message').show();
                    $('#lab_message').html('Patient sent to lab!');
                    $('#labBtn').addClass('disabled');
                }else{
                    alert("Error occured"+msg);
                    //$('.modal-footer').show();
                    $('.loader').hide();
                    /*$('.modal-body').html('<div class="container"style="color:red"><b>Lab exam sent to the lab for examination</b></div>');
                    $('#lab_message').show();
                    $('#lab_message').css('color','#ffffff');
                    $('#lab_message').css('background','red');
                    $('#lab_message').css('padding','10px');
                    $('#lab_message').html('<b>Patient sent to lab!</b>');*/
                }
            },
            error:function(){
                alert("Something went wrong-!");
            }
        });
    });

});    
</script>
<style>
body{
    position: relative;
    background:#ffffff;
}      
pre{
    tab-size: 8;
}
#main{
	margin-top:70px;
}
h1{
	font-size:25px;
	background: #607D8B;
	padding:10px;
	color:#fff;
	border-radius: 4px; 
	
}
#patient_details{
	font-size:18px;
	font-family:tahoma;
	border-bottom:solid 1px #d3d3d3; 
	padding:10px;
}
#fill_complains{
	padding:10px;
}
#submit_btn{
    padding:10px;
    border-top:solid 1px #d3d3d3;
    border-bottom:solid 1px #d3d3d3;
}
.loader{
    border:16px solid #f3f3f3;
    border-radius: 50%;
    border-top: 16px solid #606060;
    width:70px;
    height:70px;
    -webkit-animation: spin 2s linear infinite;
    animation: spin 2s linear infinite;
    margin: auto;
}
@-webkit-keyframes spin{
    0%{
        -webkit-transform: rotate(0deg);
    }
    100%{
        -webkit-transform: rotate(360deg);
    }
}
@keyframes spin{
    0%{
        transform:rotate(0deg);
    }
    100%{
        transform:rotate(360deg);
    }
}
#not_count{
    position: relative;
}
#notificationContainer
{
    background-color: #fff;
    border: 1px solid rgba(100, 100, 100, .4);
    -webkit-box-shadow: 0 3px 8px rgba(0, 0, 0, .25);
    overflow: visible;
    position: absolute;
    top: 30px;
    margin-left: -170px;
    width: 400px;
    z-index: -1;
    display: none;
}
#notificationContainer:before {
    content: '';
    display: block;
    position: absolute;
    width: 0;
    height: 0;
    color: transparent;
    border: 10px solid black;
    border-color: transparent transparent white;
    margin-top: -20px;
    margin-left: 188px;
}
#notificationTitle
{
    font-weight: bold;
    padding: 8px;
    font-size: 13px;
    background-color: #ffffff;
    position: fixed;
    z-index: 1000;
    width: 384px;
    border-bottom: 1px solid #dddddd;
}
#notificationsBody
{
    padding: 33px 0px 0px 0px !important;
    min-height:300px;
}
#notificationFooter
{
    background-color: #e9eaed;
    text-align: center;
    font-weight: bold;
    padding: 8px;
    font-size: 12px;
    border-top: 1px solid #dddddd;
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
