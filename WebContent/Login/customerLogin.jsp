<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
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

		String email = request.getParameter("customerEmail");
		String password = request.getParameter("customerPassword");
		
		
		String getCustomerID = "Select * FROM Customer WHERE Email=?";
		PreparedStatement sqlQuery = con.prepareStatement(getCustomerID);
		
		sqlQuery.setString(1, email);
		
		
		ResultSet result = sqlQuery.executeQuery();
		
		if(result.next() == false){
			response.sendRedirect("./customerNotFound.jsp");
		}
		
		getCustomerID = "Select * FROM Customer Where Email=? AND Password=?";
		sqlQuery = con.prepareStatement(getCustomerID);
		sqlQuery.setString(1, email);
		sqlQuery.setString(2, password);
		
		result = sqlQuery.executeQuery();
		String cid;
		
		if(result.next()){
			cid = result.getString("CustomerID");
			session.setAttribute("customerID", cid);
			response.sendRedirect("showOptions.jsp");						
		}
%>
</body>
</html>