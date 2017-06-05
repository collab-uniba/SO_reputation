<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Stack Overflow Reputation</title>
	<link rel="stylesheet" type="text/css" href="style.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	       <script>
			$(document).on('click', '.collapsible', function () {
  				$(this).toggleClass('collapsed');
			});

    	function loadDate()
        {
           	n = new Date();
    		y = n.getFullYear();
    		m = n.getMonth() + 1;
    		d = n.getDate();
        
            
            yearSelect = document.getElementById('YearId');
            for (i = 2008; i <= y; i++)
    		{
    			yearSelect.options[yearSelect.options.length] = new Option(i, i);
    		}
            
            monthSelect = document.getElementById('MonthId');
    		for (i = 1; i <= m; i++)
    		{
            	switch(i)
            	{
            		case 1:
            			monthSelect.options[monthSelect.options.length]= new Option("January", "01");
            			break;
            		case 2:
            			monthSelect.options[monthSelect.options.length]= new Option("February", "02");
            			break;
            		case 3:
            			monthSelect.options[monthSelect.options.length]= new Option("March", "03");
            			break;
            		case 4:
            			monthSelect.options[monthSelect.options.length]= new Option("April", "04");
            			break;
            		case 5:
            			monthSelect.options[monthSelect.options.length]= new Option("May", "05");
            			break;
            		case 6:
            			monthSelect.options[monthSelect.options.length]= new Option("June", "06");
            			break;
            		case 7:
            			monthSelect.options[monthSelect.options.length]= new Option("July", "07");
            			break;
            		case 8:
            			monthSelect.options[monthSelect.options.length]= new Option("August", "08");
            			break;
            		case 9:
            			monthSelect.options[monthSelect.options.length]= new Option("September", "09");
            			break;
            		case 10:
            			monthSelect.options[monthSelect.options.length]= new Option("October", "10");
            			break;
            		case 11:
            			monthSelect.options[monthSelect.options.length]= new Option("November", "11");
            			break;
            		case 12:
            			monthSelect.options[monthSelect.options.length]= new Option("December", "12");
            			break;
            	}
            }
            
            daySelect = document.getElementById('DayId');
            for (i = 1; i <= d; i++)
            {
            	
            	if (i <= 9)
                {
                	daySelect.options[daySelect.options.length]= new Option("0" + i, "0" + i);
                }
                else
                {
                	daySelect.options[daySelect.options.length] = new Option(i, i);
            	}
             }
             
             document.getElementById('YearId').value=y;
             
             if (m <= 9)
             {
             	document.getElementById('MonthId').value = "0"+ m;
             }
             else
             {
                document.getElementById('MonthId').value = m;
             }
             
             if (d <= 9)
             {
             	document.getElementById("DayId").value = "0" + d;
             }
             else
             {
             	document.getElementById("DayId").value = d;
             }
         }
         
         function CheckDate()
         {
         	n = new Date();
   	 		y = n.getFullYear();
    		m = n.getMonth() + 1;
    		d = n.getDate();	
         	
            yearSelect = document.getElementById("YearId");
            mothSelect = document.getElementById("MonthId");
            daySelect = document.getElementById("DayId");
            
            for (i = 0; i < monthSelect.length; i++)
            {
            	monthSelect.remove(i);
                i--;
            }
                
           	for (i = 0; i < daySelect.length; i++)
            {
            	daySelect.remove(i);
                i--;
           	}
            
            if (yearSelect.options[yearSelect.selectedIndex].value < y)
            {
        
            	for (i = 1; i <= 12; i++)
    			{
                	switch(i)
                	{
                		case 1:
                			monthSelect.options[monthSelect.options.length]= new Option("January", "01");
                			break;
                		case 2:
                			monthSelect.options[monthSelect.options.length]= new Option("February", "02");
                			break;
                		case 3:
                			monthSelect.options[monthSelect.options.length]= new Option("March", "03");
                			break;
                		case 4:
                			monthSelect.options[monthSelect.options.length]= new Option("April", "04");
                			break;
                		case 5:
                			monthSelect.options[monthSelect.options.length]= new Option("May", "05");
                			break;
                		case 6:
                			monthSelect.options[monthSelect.options.length]= new Option("June", "06");
                			break;
                		case 7:
                			monthSelect.options[monthSelect.options.length]= new Option("July", "07");
                			break;
                		case 8:
                			monthSelect.options[monthSelect.options.length]= new Option("August", "08");
                			break;
                		case 9:
                			monthSelect.options[monthSelect.options.length]= new Option("September", "09");
                			break;
                		case 10:
                			monthSelect.options[monthSelect.options.length]= new Option("October", "10");
                			break;
                		case 11:
                			monthSelect.options[monthSelect.options.length]= new Option("November", "11");
                			break;
                		case 12:
                			monthSelect.options[monthSelect.options.length]= new Option("December", "12");
                			break;
                	}
    			}
            
            	
            	for (i = 1; i <= 31; i++)
            	{
            		if (i <= 9)
                	{
                		daySelect.options[daySelect.options.length]= new Option("0" + i, "0" + i);
                	}
                	else
                	{
                		daySelect.options[daySelect.options.length] = new Option(i, i);
            		}
             	}  	 
            }
            else
            {             
    			for (i = 1; i <= m; i++)
    			{
                	switch(i)
                	{
                		case 1:
                			monthSelect.options[monthSelect.options.length]= new Option("January", "01");
                			break;
                		case 2:
                			monthSelect.options[monthSelect.options.length]= new Option("February", "02");
                			break;
                		case 3:
                			monthSelect.options[monthSelect.options.length]= new Option("March", "03");
                			break;
                		case 4:
                			monthSelect.options[monthSelect.options.length]= new Option("April", "04");
                			break;
                		case 5:
                			monthSelect.options[monthSelect.options.length]= new Option("May", "05");
                			break;
                		case 6:
                			monthSelect.options[monthSelect.options.length]= new Option("June", "06");
                			break;
                		case 7:
                			monthSelect.options[monthSelect.options.length]= new Option("July", "07");
                			break;
                		case 8:
                			monthSelect.options[monthSelect.options.length]= new Option("August", "08");
                			break;
                		case 9:
                			monthSelect.options[monthSelect.options.length]= new Option("September", "09");
                			break;
                		case 10:
                			monthSelect.options[monthSelect.options.length]= new Option("October", "10");
                			break;
                		case 11:
                			monthSelect.options[monthSelect.options.length]= new Option("November", "11");
                			break;
                		case 12:
                			monthSelect.options[monthSelect.options.length]= new Option("December", "12");
                			break;
                	}
    			}
            
       
            	for (i = 1; i <= d; i++)
            	{
            		if (i <= 9)
                	{
                		daySelect.options[daySelect.options.length]= new Option("0" + i, "0" + i);
                	}
                	else
                	{
                		daySelect.options[daySelect.options.length] = new Option(i, i);
            		}
             	}
        	}
        }
            
    </script>
</head>
<body onload = "loadDate()">
<form action = "ClientServlet" method = "post">
<div align = "center"> 
	Insert User Id: <input id = "userId_Id" type = "number" name = "userId" style="width: 200px"/>
	<br> <br>
	Select a date: 
	
	
		<select id = "YearId" name = "year" onclick = "CheckDate()" style = "width: 125px">
		</select>

		<select id = "MonthId" name = "month" style = "width: 125px">
		</select>

		<select id = "DayId" name = "day" style = "width: 125px">
		</select>
	
	<br> <br>
	<button class = "button" type = "submit" onclick = "document.getElementById('symbol').style.left = '50%'; document.getElementById('symbol').style.top = '50%'; document.getElementById('hiddenText').style.display = 'inline'"> <span> Get Reputation! </span> </button>
</div>
</form>
	<div align = "center">
	<button class = "button" onclick = "document.getElementById('userId_Id').value = ''"> <span> Reset </span> </button>
	</div>
	<div align = "center">
		<div id = "symbol" class="loader"> </div>
		<h3 id = "hiddenText"> Please wait... </h3>
	</div>
	<br> <br> <br> <br>
	<div>
		<p class="collapsible collapsed">
			<b>DISCLAIMER</b><br>
			This demo is just for demo purpose and, therefore, it is updated only to the Stack Overflow dump of <i><b>March 2015</b></i>. Besides, it computes an
			approximation of actual reputation score. For more details, please visit
			the <a href="https://github.com/collab-uniba/SO_reputation">project homepage</a> on GitHub.
		</p>
	</div>

</body>
</html>