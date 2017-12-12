<%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Error in Registration</title>
</head>
<body>

Statistic error(s):
<br/>	
<br/>
	<%
		String[] errors = (String[])session.getAttribute("errors");
		
		if(errors[0].equals("-1")){
			out.write("Start date: not a valid date  <br/> <br/>");
		}
		if(errors[1].equals("-1")){
			out.write("End date: not a valid end date <br/> <br/>");
		}
		if(errors[2].equals("-1")){
			out.write("The end date occurs before the start date <br/> <br/>" );
		}
		
	%>
	
<br/>
Try again: 
<form method = "get" action = "./selectStatistic.jsp">
		<input type = "submit" value="Statistic">
</form>
</body>
</html>