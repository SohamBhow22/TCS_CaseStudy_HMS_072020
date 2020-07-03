<!--created by SB on 29062020-->
<%@ page import="files.Patient"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="ISO-8859-1">
		<title>Search Patient for Diagnostic Test</title>
	</head>

<!-- ############################################################################################### -->	

	<% String msg1 = request.getParameter("msg1")==null ? "" : request.getParameter("msg1"); %>
	<% String msg2 = request.getParameter("msg2")==null ? "" : request.getParameter("msg2"); %>
	<% String pid = request.getParameter("pid")==null ? " " : request.getParameter("pid"); %>
	<% String pname = request.getParameter("pname")==null ? " " : request.getParameter("pname"); %>
	<% String pag = request.getParameter("page")==null ? " " : request.getParameter("page"); %>
	<% String add = request.getParameter("add")==null ? " " : request.getParameter("add"); %>
	<% String city = request.getParameter("city")==null ? " " : request.getParameter("city"); %>
	<% String adt = request.getParameter("adt")==null ? " " : request.getParameter("adt"); %>
	
	<%	String dis = "";
		String len = request.getParameter("len")==null ? "0" : request.getParameter("len");
		int l = Integer.parseInt(len);
		String tid[] = new String[l];
		String tname[] = new String[l];
		String tqty[] = new String[l];
		if(!len.equals("0"))
		{
			System.out.println("Yes test"+len);
			for(int i=0;i<l;i++)
			{
				int j = i+1;
				tid[i] = request.getParameter("tid"+j);
				tname[i] = request.getParameter("tname"+j);
				tqty[i] = request.getParameter("tqty"+j);
				System.out.println(tid[i]+tname[i]+tqty[i]);
			}
		}
		else
			System.out.println("No meds"+len);
	%>
	<% if(pid == " ") 
		{
			dis = "disabled";
		}
		else
		{
			dis = "";
		}
	
	%>
	
	<script>
		function preventNonNumericalInput(e) {
			e = e || window.event;
			var charCode = (typeof e.which == "undefined") ? e.keyCode : e.which;
			var charStr = String.fromCharCode(charCode);
	
			if (!charStr.match(/^[0-9]+$/))
				e.preventDefault();
		}
	</script>
	
<!-- ############################################################################################### -->
		
	<body style="background-color:lightblue;text-align:center">
			<h1>ABC Hospital Management System</h1>
			<hr>
			<div>
				<h2 align ="center">Patient Info</h2>
				<form action="SearchPatient_Diag" method="post">
					<table style="border:1px solid black;margin-left:auto;margin-right:auto;">
						<tr>
							<td>Search by Patient ID</td>
							<td><input type="text" name="pid" id="patid"
									onkeydown="return event.keyCode !== 69"
									onkeypress="preventNonNumericalInput(event)" 
									minlength="9" maxlength="9" required></td>
							<td>(enter the 9-digit id)</td>
						</tr>
						<tr>
							<td></td>
							<td><input type="submit" name="Fetchdet" value="Fetch Patient Details"></td>
							<td></td>
						</tr>
					</table>
				</form>
				<br><br>
			</div>

<!-- ############################################################################################### -->			
			<hr>
			<h4 align ="center">Patient Details</h4>
			<% if(!msg1.equals("")) {%>
			<div>
				<p style="color:red;text-align:center"><%=msg1 %></p>
			</div>
			<%} 
			else{ %>
			<div>
				<table style="border:1px solid black;margin-left:auto;margin-right:auto;">
		    		<tr>
		    			<th>Patient ID</th>
		    			<th>Patient Name</th>
		    			<th>Age</th>
		    			<th>Address</th>
		    			<th>City</th>
		    			<th>Admit Date</th>
		    		</tr>
		    		<tr>
		    			<td><%=pid %></td>
		    			<td><%=pname %></td>
		    			<td><%=pag %></td>
		    			<td><%=add%></td>
		    			<td><%=city%></td>
		    			<td><%=adt %></td>
		    		</tr>
    			</table>
			</div>		
			<%}%>
			<br><br>
			
<!-- ############################################################################################### -->			
			<hr>
			<h4 align ="center">Diagnostic Tests Conducted</h4>
			<%if(!msg2.equals("")) {%>
			<div>
				<p style="color:red;text-align:center"><%=msg2 %></p>
			</div>
			<%} 
			else{ %>
			<div>
				<table style="border:1px solid black;margin-left:auto;margin-right:auto;">
		    		<tr>
		    			<th>Test ID</th>
		    			<th>Diagnostic Test Name</th>
		    			<th>No. of Times Conducted</th>
		    		</tr>
		    		<% for(int i=0;i<l;i++){ %>
		    		<tr>
		    			<td><%=tid[i] %></td>
		    			<td><%=tname[i] %></td>
		    			<td><%=tqty[i] %></td>
		    		</tr>
		    		<% }%>
    			</table>
			</div>		
			<%}%>
			<br><br>
			
<!-- ############################################################################################### -->
			<hr>
			<div>
				<form action="SearchPatient_Diag" method="get"> 
					<input type="submit" name="AddDiag" value="Add Diagnostics" <%=dis %>>
					<input type="hidden" name="pid2" value="<%=pid %>">
					<br><br>
					<input type="submit" name="toHome" value="Back to Main Page" formaction="desk.jsp">
				</form>
			</div>
			<br><br>
<!-- ############################################################################################### -->
			
	</body>
	
</html>
