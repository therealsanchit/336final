<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


	<%
		String url = "jdbc:mysql://dbinstance336.cetrc28mqdpc.us-east-2.rds.amazonaws.com:3306/HotelDatabase";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "group22", "group22password");

		String name = request.getParameter("review");
		if(name.equals("Breakfast") || name.equals("breakfast")){
			response.sendRedirect("breakfastReview.jsp");
		}
		else if(name.equals("Service") || name.equals("service")){
			response.sendRedirect("serviceReview.jsp");
		}
		else if(name.equals("Room") || name.equals("room")){
			response.sendRedirect("roomReview.jsp");
		}
		else{
			response.sendRedirect("reviewType.jsp");
		}
			
			%>
	

</body>
</html>