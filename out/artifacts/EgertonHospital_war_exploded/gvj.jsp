<%--
  Created by IntelliJ IDEA.
  User: Derick Oduor
  Date: 12/30/2017
  Time: 5:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<!--
<div class="container">
            	<h1>Patient Ailment Form</h1>
            	<div class="row"id="patient_details">
            		<div class="col-sm-3">
            			Name:&nbsp;<b><%//=name %></b>
            		</div>
            		<div class="col-sm-3">
            			Reg. No.:&nbsp;<b><%//=regno_ %></b>
            		</div>
            	</div>
            	<div class="container"id="fill_complains">
                    <div class="container"id="lab_message"></div>
            		<form action="complains"method="post"class="form">
                        <input type="hidden"name="regno"value=<%//= regno%>/>
                        <div class="form-group">
            			    <label class="control-label">Complains</label>
            			    <textarea rows="5" cols="1"class="form-control"name="complains"placeholder="Complains"required></textarea>
                        </div>
                        <div class="form-group">
            			    <label class="control-label">Additional Information</label>
            			    <textarea rows="5" cols="1"class="form-control"name="additional_info"placeholder="Additional information"required></textarea>
                        </div>
                        <div class="form-group">
            			    <a data-toggle="modal" href="#myModal" class="btn btn-outline-warning">Send patient to lab</a>
                        </div>
                        <div class="form-group"id="submit_btn">
                            <button type="submit"class="btn btn-outline-primary">Submit</button>
                        </div>
                    </form>
            	</div>
            </div>-->

</body>
<div class="card"id="student_div">
    <form action="/records"method="post"class="form"id="new_non_student">
        <input type="hidden"name="post_type"value="new record">
        <input type="hidden"name="visit_type"value="First visit">
        <div class="">
            <div class="form-group">
                <label class="control-label">Age Group</label>
                <select name="age_group"class="form-control"required>
                    <option></option>
                    <option>Adult</option>
                    <option>Below 18</option>
                </select>
            </div>

            <div id="adult">
                <div class="form-group">
                    <label class="control-label">Name</label>
                    <input type="text"name="name"class="form-control"placeholder="Name" required/>
                </div>
                <div class="form-group">
                    <label class="control-label">National Id No.</label>
                    <input type="text"name="nat_id"class="form-control"placeholder="National Id No." required/>
                </div>
                <div class="form-group">
                    <label class="control-label">Phone No.</label>
                    <input type="text"name="phone"class="form-control"placeholder="Phone No." required/>
                </div>
                <div class="form-group">
                    <label class="control-label">Relative</label>
                    <input type="text"name="relative"class="form-control"placeholder="Relative" required/>
                </div>
                <div class="form-group">
                    <label class="control-label">Relative Phone No.</label>
                    <input type="text"name="relative_phone"class="form-control"placeholder="Relative Phone No." required/>
                </div>
                <div class="form-group">
                    <label class="control-label">Home Address</label>
                    <input type="text"name="home_address"class="form-control"placeholder="Home Address" required/>
                </div>
                <div class="form-group">
                    <label class="control-label">Date of Birth</label>
                    <input type="text"name="d_o_b"class="form-control"placeholder="Date of Birth" required/>
                </div>
                <div class="form-group">
                    <label class="control-label">Date of Admission</label>
                    <input type="text"name="d_o_a"class="form-control"placeholder="Date of Admission" required/>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-info">Submit</button>
                </div>
            </div>

            <div id="child">
                <div class="form-group">
                    <label class="control-label">Name</label>
                    <input type="text"name="name"class="form-control"placeholder="Name" required/>
                </div>
                <div class="form-group">
                    <input type="hidden"name="underage"value="true"/>
                </div>
                <div class="form-group">
                    <label class="control-label">Relative</label>
                    <input type="text"name="relative"class="form-control"placeholder="Relative" required/>
                </div>
                <div class="form-group">
                    <label class="control-label">Relative Phone No.</label>
                    <input type="text"name="relative_phone"class="form-control"placeholder="Relative Phone No." required/>
                </div>
                <div class="form-group">
                    <label class="control-label">Home Address</label>
                    <input type="text"name="home_address"class="form-control"placeholder="Home Address" required/>
                </div>
                <div class="form-group">
                    <label class="control-label">Date of Birth</label>
                    <input type="text"name="d_o_b"class="form-control"placeholder="Date of Birth" required/>
                </div>
                <div class="form-group">
                    <label class="control-label">Date of Admission</label>
                    <input type="text"name="d_o_a"class="form-control"placeholder="Date of Admission" required/>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-info">Submit</button>
                </div>
            </div>
        </div>
    </form>
</div>
</html>
