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

		boolean error = false;
		String[] registrationCheck = new String[5];

		if (name.trim().length() < 3) {
			registrationCheck[0] = "-1";
			error = true;
		} else
			registrationCheck[0] = "1";
		if (!email.contains("@") || email.length() < 3) {
			registrationCheck[1] = "-1";
			error = true;
		} else
			registrationCheck[1] = "1";
		if (address.trim().length() < 5) {
			registrationCheck[2] = "-1";
			error = true;
		} else
			registrationCheck[2] = "1";
		if (phone.length() < 10) {
			registrationCheck[3] = "-1";
			error = true;
		} else
			registrationCheck[3] = "1";
		if (password.length() < 5) {
			registrationCheck[4] = "-1";
			error = true;
		} else
			registrationCheck[4] = "1";

		if (error == true) {
			session.setAttribute("errors", registrationCheck);
			response.sendRedirect("registrationError.jsp");
		} else {

			String emailChecker = "SELECT * FROM Customer WHERE Email=?";
			PreparedStatement check = con.prepareStatement(emailChecker);

			check.setString(1, email);

			ResultSet result = check.executeQuery();
			int i = 0;
			if (result.next()) {
				response.sendRedirect("./customerDuplicateEmail.jsp");
			}

			else {
				String insert = "INSERT INTO Customer(Email, Address, PhoneNumber, Password, Name)"
						+ "VALUES (?, ?, ?, ?, ?)";

				PreparedStatement ps = con.prepareStatement(insert);

				ps.setString(1, email);
				ps.setString(2, address);
				ps.setString(3, phone);
				ps.setString(4, password);
				ps.setString(5, name);

				ps.executeUpdate();
			}
		}
	%>
	Thank you for registering, Please login here:
	<br>
	<form method="get" action="../Login/customerLogin.jsp">
		<table>
			<tr>
				<td>Email Address</td>
				<td><input type="text" name="customerEmail"></td>
			</tr>

			<tr>
				<td>Password</td>
				<td><input type="text" name="customerPassword"></td>
			</tr>

		</table>
		<br> <input type="submit" value="Login">
	</form>

	<form method="get" action="../show.jsp" enctype=text/plain>
		<input type="submit" value="Check database">
	</form>



</body>
</html>