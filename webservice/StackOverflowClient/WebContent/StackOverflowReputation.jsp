<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Stack Overflow Reputation</title>
	
	       <script>
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
	
	<style>
select {
  margin: 5px;
  border: 1px solid #111;
  background: transparent;
  width: 150px;
  padding: 5px 35px 5px 5px;
  font-size: 16px;
  border: 1px solid #ccc;
  height: 34px;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  background: url(favicon.ico) 96% / 15% no-repeat #eee;
}


/* CAUTION: IE hackery ahead */


select::-ms-expand { 
    display: none; /* remove default arrow in IE 10 and 11 */
}

/* target Internet Explorer 9 to undo the custom arrow */
@media screen and (min-width:0\0) {
    select {
        background:none\9;
        padding: 5px\9;
    }
}
		
		.loader 
		{
    		border: 16px solid #f3f3f3; /* Light grey */
    		border-top: 16px solid #3498db; /* Blue */
    		border-radius: 50%;
    		width: 45px;
    		height: 45px;
    		animation: spin 2s linear infinite;
    		position: absolute;
    		left: -100px;
    		top: -150px;
		}

		@keyframes spin 
		{
    		0% { transform: rotate(0deg); }
    		100% { transform: rotate(360deg); }
		}
		
		h3
		{
			display: none;
			position: absolute;
			top: 50%;
			left: 40%;
			
		}
		
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
		
		input[type=number] {
    width: 12%;
    box-sizing: border-box;
    border: 2px solid #ccc;
    border-radius: 40px;
    font-size: 16px;
    background-color: white;
    background-image: url(favicon.ico);
    background-position: 120px 10px;
    background-repeat: no-repeat;
    padding: 20px 40px 12px 35px;
}
	
	</style>
</head>
<body onload = "loadDate()">
<form action = "ClientServlet" method = "post">
<div align = "center"> 
	Insert User Id: <input id = "userId_Id" type = "number" name = "userId"/>
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
	<br> <br> <br>
	<h3 id = "hiddenText"> Please wait... </h3>
	 <div id = "symbol" class="loader"> </div>
</body>
</html>