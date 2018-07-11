<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form action="update.jsp"method="post"class="form">
                            <input type="hidden"name="regno"value=<%= "S13/21417/14"%>/>
                            <div class="form-group">
            			<label class="control-label">Complains</label>
            			<textarea rows="5" cols="1"class="form-control"name="complains"placeholder="Complains"required></textarea>
                            </div>
                            <div class="form-group">
            			<label class="control-label">Additional Information</label>
            			<textarea rows="5" cols="1"class="form-control"name="additional_info"placeholder="Additional information"required></textarea>
                            </div>
                            <div class="form-group">
            			<a data-toggle="modal" href="#myModal" class="btn btn-warning">Send patient to lab</a>
                            </div>
                            <div class="form-group"id="submit_btn">
                                <button type="submit"class="btn btn-primary">Submit</button>
                            </div>
            			
            		</form>
</body>
</html>