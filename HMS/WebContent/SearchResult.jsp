<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@page import="java.sql.*,java.util.*"%>
   
 <%
 String driver = "com.mysql.jdbc.Driver";
 String connectionUrl = "jdbc:mysql://localhost:3306/";
 String database = "hms_tcs";
 String userid = "root";
 String password = "prakhar3198#98";
 String pid = request.getParameter("patient_id");//retrieves the entered patient id in the search bar of PatientScreen.jsp page
 try {
 Class.forName(driver);
 } catch (ClassNotFoundException e) {
 e.printStackTrace();
 }
 Connection connection = null;
 Statement statement = null;
 ResultSet resultSet = null;
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Patient Information</title>
 <style type="text/css">
        .auto-style3 {
            height: 61px;
        }
        .auto-style4 {
            width: 70px;
            height: 37px;
        }
        .auto-style5 {
            width: 320px;
        }
        .auto-style6 {
            width: 322px;
        }
        .auto-style7 {
            width: 119px;
            height: 36px;
        }
    </style>
    <script type="text/javascript">
    </script>
</head>
<body bgcolor ="lightblue">
    <h1 align="center" class="auto-style3" style="color: #00FFFF; background-color: #000080;">Hospital Management System</h1>
    <h2 align ="center">Patient Info</h2>
    <div id="pat" align="center">
    	<%
    	    int i=0;//flag variable
    		try{
    			connection = DriverManager.getConnection(connectionUrl+database, userid, password);
    			statement=connection.createStatement();
    			String sql ="select * from patients";
    			
    			resultSet = statement.executeQuery(sql);
    			while(resultSet.next()){
    				if(resultSet.getString(2).equals(pid)){i=1;break;}
    			}
    			if(i==0){//Patient record not in database
    				String ans = "Patient record not found!";
    			    out.println(ans);
    			    String site = new String("PatientNotFound.jsp");
    		        response.sendRedirect(site);
    			}
    			else{
    	%>
    	<table border="1" style="background-color:white; border-collapse:collapse;">
    		<tr>
    			<th>Patient ID</th>
    			<th>Patient Name</th>
    			<th>Age</th>
    			<th>Address</th>
    			<th>Date of Joining</th>
    			<th>Room Type</th>
    		</tr>
    		<tr>
    			<td><%=resultSet.getString(2) %></td>
				<td><%=resultSet.getString(3) %></td>
				<td><%=resultSet.getString(4) %></td>
				<td><%=resultSet.getString(7) %></td>
				<td><%=resultSet.getString(5) %></td>
				<td><%=resultSet.getString(6) %></td>
    		</tr>
    	<%
    			}
    		}
    	    catch(Exception e1){
    	    	e1.printStackTrace();
    	    }
    	    finally{
    	    	//out.println("Adios Amigo!!");
    	    }
    	%>
    	</table>
    </div>
    <h2 align ="center">Medicine Issued</h2>
    <div id ="med" align="center">
    	<% try{
    		//out.println("Entered medicine division");
 
			String sql2 = "SELECT Pid,med_issued.Mid,Mname,SUM(med_issued.Quantity),Rate FROM `med_issued` INNER JOIN med_mstr ON med_issued.Mid = med_mstr.Mid WHERE Pid ="+pid+" GROUP By med_issued.Mid";
			
    		resultSet = statement.executeQuery(sql2);
    		//out.println("Executed second query");
    		 if(resultSet==null){
    			 //out.println("Inside if block");
    			 out.println("No medicines prescribed yet!!");
    		 }
    		 else{
    	%>
    	<table  border="1" style="background-color:white; border-collapse:collapse;">
    		<tr>
    			<th>Patient ID</th>
    			<th>Medicine ID</th>
    			<th>Medicine Name</th>
    			<th>Quantity Issued</th>
    			<th>Rate</th>
    			<th>Amount</th>
    		</tr>
    		<% while(resultSet.next()){ %>
    		<tr>
    			<td><%=resultSet.getString("pid") %></td>
				<td><%=resultSet.getString("mid") %></td>
				<td><%=resultSet.getString("Mname") %></td>
				<td><%=resultSet.getString("SUM(med_issued.Quantity)") %></td>
				<td><%=resultSet.getString("Rate") %></td>
				<%
					int q = Integer.parseInt(resultSet.getString("SUM(med_issued.Quantity)"));
					double r = Double.parseDouble(resultSet.getString("Rate"));
					double amt = q*r;
				%>
				<td><%=amt %></td>
    		</tr>
    		<%}%>
    	</table>
    	<% 
    	   }
    	}
    		catch(Exception e3){
    			out.println("Error occured in fetching medicine info");
    			e3.printStackTrace();
    		}
    	%>
    </div>
    <div align="center">
        <form id="issue" method="post" action="IssueMed.jsp" >
        				<input type="hidden" name="Pid" value="<%=pid%>">
                    	<input id="add" name="add" type="submit" value="Issue Medicine"  class="auto-style7" style="font-family: 'Arial Black'; color: #FFFFFF; background-color: #000000"  />
                    </form></div>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
         <table style="width:100%;">
            <tr>
                <td class="auto-style5">
                <form method="post" action="PatientScreen.jsp">
                 <input type="hidden" name="Pid" value ="<%=pid %>"/>
       <input id="Button1" class="auto-style4" style="font-family: Arial; font-size: x-large; color: #FFFFFF; background-color: #000000" type="submit" value="Back" " /></form>
       </td>
                <td class="auto-style6" align="center">
                	
                 </td>
               		
                <td>&nbsp;</td>
            </tr>
        </table>
    </body>
</html>