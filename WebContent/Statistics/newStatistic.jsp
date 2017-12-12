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
		
		
		int startmonth = Integer.parseInt(request.getParameter("startmonth").trim());
		int startday = Integer.parseInt(request.getParameter("startday").trim());
		int startyear = Integer.parseInt(request.getParameter("startyear").trim());
		int endmonth = Integer.parseInt(request.getParameter("endmonth").trim());
		int endday = Integer.parseInt(request.getParameter("endday").trim());
		int endyear = Integer.parseInt(request.getParameter("endyear").trim());
		
		/*int startmonth = 0;
		int startday = 0;
		int startyear = 0;
		int endmonth = 0;
		int endday = 0;
		int endyear = 0;*/

		boolean error = false;
		String[] statisticCheck = new String[3];
		statisticCheck[0] = "1";
		statisticCheck[1] = "1";
		statisticCheck[2] = "1";
		
		//error[0] = start date not valid
		//error[1] = end date not valid
		//error[2] = end date occurs before start date

		if (startmonth==4 || startmonth==6 || startmonth==9 || startmonth==11){
			//only 30 days in the month
			if (startday >30){
				statisticCheck[0] = "-1";
				error = true;
			}
		}
		else if (startmonth==2){
			//only 27 days
			if (startday >27){
				statisticCheck[0] = "-1";
				error = true;
			}
		}
		
		if (endmonth==4 || endmonth==6 || endmonth==9 || endmonth==11){
			//only 30 days i the month
			if (endday > 30){
				statisticCheck[1] = "-1";
				error = true;
			}
		}
		else if (endmonth==2){
			//only 27 days
			if (endmonth > 27){
				statisticCheck[1] = "-1";
				error = true;
			}
		}
		
		if (endyear < startyear){
			//error, year before startyear
			statisticCheck[2] = "-1";
			error = true;
		}
		else if (endyear == startyear){
			//check month
			if (endmonth < startmonth){
				//error, endmonth before startmonth
				statisticCheck[2] = "-1";
				error = true;
			}
			else if (endmonth == startmonth){
				//check day
				if (endday < startday){
					//error, endday before startday
					statisticCheck[2] = "-1";
					error = true;
				}
			}
		}

		if (error == true) {
			session.setAttribute("errors", statisticCheck);
			response.sendRedirect("statisticErr.jsp");
		} else {

			/*String emailChecker = "SELECT * FROM Customer WHERE Email=?";
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
			}*/
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