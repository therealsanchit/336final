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

		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		String phone = request.getParameter("phoneNumber");
		String password = request.getParameter("password");

		System.out.println(name + email + address + phone + password);

		String insert = "INSERT INTO Customer(Email, Address, PhoneNumber, Password, Name)"
				+ "VALUES (?, ?, ?, ?, ?)";

		PreparedStatement ps = con.prepareStatement(insert);

		ps.setString(1, email);
		ps.setString(2, address);
		ps.setString(3, phone);
		ps.setString(4, password);
		ps.setString(5, name);

		ps.executeUpdate();
			


%>

		<form method="get" action="show.jsp" enctype=text/plain>
					<input type = "submit" value="Check database">
		</form>



</body>
</html>