<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Review Type</title>



</head>

<body>
<form method="post" action="createReview.jsp">
Please select the type of review you would like to leave!

<p></p>
Review Type: 

<span>
     <select name="review">
        <option value="1">Breakfast</option>
        <option value="2">Service</option>
        <option value="3">Room</option>
     </select> 
</span>
<br>
	<br>
	<input type="submit" value="submit">
<br>
</form>
</body>
</html>