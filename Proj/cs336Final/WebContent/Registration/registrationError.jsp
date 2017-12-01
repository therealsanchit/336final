<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Error in Registration</title>
</head>
<body>

Registration error(s):
<br/>	
<br/>
	<%
		String[] errors = (String[])session.getAttribute("errors");
		
		if(errors[0].equals("-1")){
			out.write("Name Field: has to be atleast 3 letters long  <br/> <br/>");
		}
		if(errors[1].equals("-1")){
			out.write("Email Address: should contain '@' and be atleast 3 letters long <br/> <br/>");
		}
		if(errors[2].equals("-1")){
			out.write("Address Field: has to be atleast 5 letters long <br/> <br/>" );
		}
		if(errors[3].equals("-1")){
			out.write("Phone Numbers: should be atleast 10 numbers <br/> <br/>");
		}
		if(errors[4].equals("-1")){
			out.write("Password has: to be atleast 5 letters <br/> <br/>");
		}
	%>
	
<br/>
Register again: 
<form method = "get" action = "./customerRegister.jsp">
		<input type = "submit" value="Register">
</form>
</body>
</html>