<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script>
function typeReview()
{
	String mylist=document.getElementById("myList");
	document.getElementById("type").value=mylist.options(mylist.selectedIndex).text;
	
}
function score()
{
	var starlist=document.getElementById("starList");
	document.getElementById("stars").value=starlist.options(starlist.selectedIndex).text;
}


</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

		String url = "jdbc:mysql://dbinstance336.cetrc28mqdpc.us-east-2.rds.amazonaws.com:3306/HotelDatabase";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "group22", "group22password");
		
<form>
Select the type of review:
<select id="myList" onchange="typeReview()">
	<option>Room</option>
	<option>Breakfast</option>
	<option>Service</option>
</select>

Select rating:
<select id="starList" onchange="score()">
	<option>1</option>
	<option>2</option>
	<option>3</option>
	<option>4</option>
	<option>5</option>
	<option>6</option>
	<option>7</option>
	<option>8</option>
	<option>9</option>
	<option>10</option>
	
<script type="text/javascript">
   function kk(){
       var lol = document.getElementById('lolz').value;
       alert(lol);
   }
</script>
	
</select>

<p>
<input type="text" id="type" size="10">
<input type="text" id="stars" size="2">
<input type="text" id="comment" size="2">
</p>
</form>

</body>
</html>