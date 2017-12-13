<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<br>
	<%
		String url = "jdbc:mysql://dbinstance336.cetrc28mqdpc.us-east-2.rds.amazonaws.com:3306/HotelDatabase";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "group22", "group22password");

		String country = request.getParameter("country");
		String state = request.getParameter("state");
		
		if (country == null) {
			out.write("Welcome to reservation. First choose a contry");
			out.write("<br>");
			ArrayList<String> countries = new ArrayList<String>();
			String getCountries = "Select Country FROM Hotel";
			PreparedStatement countryQuery = con.prepareStatement(getCountries);

			ResultSet result = countryQuery.executeQuery();

			while (result.next()) {
				if (!countries.contains(result.getString("Country")))
					countries.add(result.getString("Country"));
			}

			out.write("<span>");
			out.write("<select name = 'selectCountry' id = 'countrySpan'>");
			for (int i = 0; i < countries.size(); i++) {
				out.write("<option value = '" + i + "'>");
				out.write(countries.get(i));
				out.write("</option>");
			}
			out.write("</select>");
			out.write("</span>");
	%>


	<INPUT TYPE="BUTTON" VALUE="Choose" ONCLICK="showStates()">
	<script LANGUAGE="JavaScript">
		function showStates() {
			var e = document.getElementById("countrySpan");
			window.location = "http://localhost:8080/cs336Final/Reservation/reservationHome.jsp?country="
					+ e.options[e.selectedIndex].innerText;
		}
	</script>
	<%
		} 
				
		if(country != null && state == null){
			out.write("You chose country: " + country);
			out.write("<br>");
			out.write("Our hotels are in the following states: ");
			out.write("<br>");

			ArrayList<String> states = new ArrayList<String>();
			String getStates = "Select State FROM Hotel where Country = ?";
			PreparedStatement stateQuery = con.prepareStatement(getStates);
			stateQuery.setString(1, country);
			ResultSet result = stateQuery.executeQuery();

			while (result.next()) {
				if (!states.contains(result.getString("State")))
					states.add(result.getString("State"));
			}

			out.write("<span>");
			out.write("<select name = 'selectState' id = 'stateSpan'>");
			for (int i = 0; i < states.size(); i++) {
				out.write("<option value = '" + i + "'>");
				out.write(states.get(i));
				out.write("</option>");
			}
			out.write("</select>");
			out.write("</span>");
	%>

	<INPUT TYPE="BUTTON" VALUE="Choose" ONCLICK="showHotels()">
	<script LANGUAGE="JavaScript">
		function showHotels() {
			var country = '<%=country%>';
			var state = document.getElementById("stateSpan");
			window.location = "http://localhost:8080/cs336Final/Reservation/reservationHome.jsp?country="
					+ country
					+ "&state="
					+ state.options[state.selectedIndex].innerText;
		}
	</script>

	<%
		}
		
		if(country != null && state != null){			
			out.write("Showing hotels for: " + country + ", " + state);
			out.write("<br>");

			ArrayList<String> hotels = new ArrayList<String>();
			String getHotels = "Select * FROM Hotel where Country = ? and State = ?";
			PreparedStatement hotelQuery = con.prepareStatement(getHotels);
			hotelQuery.setString(1, country);
			hotelQuery.setString(2, state);
			ResultSet result = hotelQuery.executeQuery();

			while (result.next()) {
				if (!hotels.contains(result.getString("Name")))
					hotels.add(result.getString("Name"));
			}

			out.write("<span>");
			out.write("<select name = 'selectHotel' id = 'hotelSpan'>");
			for (int i = 0; i < hotels.size(); i++) {
				out.write("<option value = '" + i + "'>");
				out.write(hotels.get(i));
				out.write("</option>");
			}
			out.write("</select>");
			out.write("</span>");
			
			%>

			<INPUT TYPE="BUTTON" VALUE="Choose" ONCLICK="sendToReservationPage()">
			<script LANGUAGE="JavaScript">
				function sendToReservationPage() {
					var index = document.getElementById("hotelSpan");
					window.location = "http://localhost:8080/cs336Final/Reservation/makeReservation.jsp?hid="
							+ index.options[index.selectedIndex].value+1;
				}
			</script>
			<% 
		}
			
	%>



</body>
</html>