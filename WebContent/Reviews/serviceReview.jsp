<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<br>
	<form method="post" action="sStore.jsp">
	<table>
	<tr>
	<td>Service Type:</td><td><input type="text" name="sType"></td>
	</tr>
	<tr>    
	<td>Rating(Between 1-10):</td><td><input type="text" name="sRating"></td>
	</tr>
	<tr>    
	<td>Comment:</td><td><input type="text" name="sComment"></td>
	</tr>
	</table>
	<br>
	<input type="submit" value="submit">
	</form>
<br>
</body>
</html>