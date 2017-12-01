<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		List<String> list = new ArrayList<String>();

		try {

			//Create a connection string
			String url = "jdbc:mysql://dbinstance336.cetrc28mqdpc.us-east-2.rds.amazonaws.com:3306/HotelDatabase";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");

			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "group22", "group22password");
			
			Statement queryStatement = con.createStatement();
			String getAllCustomers = "SELECT * FROM Customer";
			
			ResultSet result = queryStatement.executeQuery(getAllCustomers);
			
			
			
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("ID");
			out.print("</td>");
			
			out.print("<td>");
				out.print("Name");
			out.print("</td>");
			
			out.print("<td>");
				out.print("Email");
			out.print("</td>");
			
			out.print("<td>");
				out.print("Address");
			out.print("</td>");
		
			out.print("<td>");
				out.print("Phone");
			out.print("</td>");
		
			
			while (result.next()) {
				out.print("<tr>");
				
				out.print("<td>");
				out.print(result.getString("CustomerID"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("Name"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("Email"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("Address"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("PhoneNumber"));
				out.print("</td>");
				
				out.print("</tr>");

			}
			out.print("</table>");

			con.close();

		} catch (Exception e) {
			
		}
	%>

</body>
</html>