<%--
  Created by IntelliJ IDEA.
  User: Derick Oduor
  Date: 12/8/2017
  Time: 11:16 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="business.ConnectDB"%>
<%@page import="data.DBIO"%>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
              <li class="nav-item active">
                  <a class="nav-link" href="http://localhost:8080/"><span class="fa fa-home"></span>&nbsp;Home <span class="sr-only">(current)</span></a>
              </li>
          </ul>
      </div>
  </nav>
  <br/><br/><br/><br/>
    <div class="container">
        <div class="card">
            <div class="">
                <form action="Login"method="post"class="form">
                    <div class="form-group">
                        <label class="control-label"for="username">Username</label>
                        <input type="text"name="username"class="form-control"placeholder="E-mail Address" required/>
                    </div>
                    <div class="form-group">
                        <label class="control-label"for="password">Password</label>
                        <input type="password"name="password"class="form-control"placeholder="Password" required/>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-outline-info"><span class="fa fa-sign-in"></span>&nbsp;Login</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
  <!--$END$
  <a href="home.jsp">Home</a><a href="recordsoffice/records_home.jsp">Records</a>-->
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
    .card{
        padding: 20px;
        width: 50%;
        color:#fff;
        background: #2e3133;
    }
    body{
        background-image: url("images/Docto_photo1.JPG");
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