<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Customer Registration</title>
</head>
<body>

*Need to fill all the details
<br>
	<form method="post" action="newCustomer.jsp">
	<table>
	<tr>
	<td>Name</td><td><input type="text" name="name"></td>
	</tr>
	<tr>    
	<td>Email Address:</td><td><input type="text" name="email"></td>
	</tr>
	<tr>
	<td>Address</td><td><input type="text" name="address"></td>
	</tr>
	<tr>
	<td>Phone Number</td><td><input type="text" name="phoneNumber"></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="text" name="password"></td>
	</tr>
	</table>
	<br>
	<input type="submit" value="submit">
	</form>
<br>

</body>
</html>