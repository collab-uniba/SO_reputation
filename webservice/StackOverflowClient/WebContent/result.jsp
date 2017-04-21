<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Stack Overflow Reputation</title>

<style>
		.button
		{
			display: inline-block;
			border-radius: 4px;
			background-color: white;
			border: 2px solid black;
			color: black;
			text-align: center;
			font-size: 14px;
			padding: 20px;
			width: 200px;
			transition: all 0.5s;
			cursor: pointer;
			margin: 5px;	
		}
		
		.button span
		{
			cursor: pointer;
			display: inline-block;
			position: relative;
			transition: 0.5s;
		}
		
		.button span:after
		{
			content: '\00bb';
			position: absolute;
			opacity: 0;
			top: 0;
			right: -20px;
			transition: 0.5s;
		}
		
		.button:hover span
		{
			padding-right: 25px;
		}
		
		.button:hover span:after
		{
			opacity: 1;
			right: 0;
		}
		
		<style>
table {
    font-family: arial, sans-serif;
    border-collapse: 1px solid black;
    width: 100%;
}

td{
    border: 1px solid #dddddd;
    text-align: center;
    padding: 15px;
}

tr:nth-child(even) {
    background-color: #f2f2f2;
}
</style>
</head>
<body>
<% Object id = request.getAttribute("ID"); %>
<% Object name = request.getAttribute("NAME"); %>
<% Object reputation = request.getAttribute("REPUTATION"); %>
<% Object time = request.getAttribute("TIME"); %>
<div align = "center">
<img src = "Stack Overflow logo.jpg" style = "width:30%; height:30%">
<br>

<table>

<tr>
	<td> <h3> <i> <u> User Id: </u> </i> </h3> </td>
	<td> <%=id %> </td>
</tr>
<tr>
	<td> <h3> <i> <u> Display Name: </u> </i> </h3> </td>
	<td> <%=name %> </td>
</tr>
<tr>
	<td> <h3> <i> <u> Reputation: </u> </i> </h3> </td>
	<td> <%=reputation %> </td>
</tr>
<tr>
	<td> <h3> <i> <u> Time: </u> </i> </h3> </td>
	<td> <%=time %> </td>
</tr>
</table>
	  
	</div>
	<br> <br>
	
	<form action = "ClientServletResult" method = "post">
		<div align = "center"> <button class = "button" type="submit"> <span> Go Back </span> </button> </div>
	</form>

</body>
</html>