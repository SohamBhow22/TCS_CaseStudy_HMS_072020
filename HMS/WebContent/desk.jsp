<%@  page import="java.util.ArrayList" %>
<%@  page import="files.PatientView" %>
<%@  page import="files.Tests" %>
<%@  page import="files.Meds" %>
<%@  page import="files.DBConnection" %>
<%@  page import="java.sql.Connection" %>
<%@  page import="java.sql.PreparedStatement" %>
<%@  page import="java.sql.ResultSet" %>
<%@  page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>ABC Hospital Management Roles</title>
</head>

<style>
#vtable{
	width: 100%;
    border-spacing: 0;
	display:block;
	font-size: 15px;
}

#vtable tbody{
	display:block;
	overflow-y: auto;
	height:246px;    
}

#vtable tr:nth-child(even) {
	background-color: #bbbbbb;
}
#vtable tr:nth-child(odd) {
	background-color: #dddddd;
}
#vtable th, #vtable td{
	width:160px;
}


#linklist {
	text-align: center;
	font-size: 15px;
	width: 100%;
}

h2 {
	text-align: center;
}

* {
	box-sizing: border-box
}

/* Style the tab */
.tab {
	float: left;
	border: 1px solid #ccc;
	background-color: #f1f1f1;
	width: 20%;
	height: 100px;
}

/* Style the buttons inside the tab */
.tab button {
	display: block;
	padding: 15px 15px;
	width: 100%;
	border: none;
	outline: none;
	text-align: left;
	cursor: pointer;
	transition: 0.3s;
	font-size: 17px;
}

/* Change background color of buttons on hover */
.tab button:hover {
	background-color: #dddddd;
}

/* Create an active/current "tab button" class */
.tab button.active {
	background-color: #cccccc;
}

/* Style the tab content */
.tabcontent {
	float: left;
	background-color: #ccc;
	padding: 0px 12px;
	border: 1px solid #ccc;
	width: 70%;
	border-left: none;
	height: 297px;
}

a:link, a:visited {
	color: blue;
}

a:hover {
	color: darkblue;
}

a:active {
	color: red;
}

table {
	border-collapse: collapse;
}
</style>


<script>
	window.onload = function() {
		<%
		PatientView p = new PatientView();
		
		ArrayList<PatientView> pv = new ArrayList<PatientView>();
		pv = p.getView();
		int len = 0;
		len = pv.size();
		String vid[] = new String[len];
		String vname[] = new String[len];
		String vage[] = new String[len];
		String vdate[] = new String[len];
		String vbed[] = new String[len];
		
		for(int i=0;i<len;i++){
			vid[i] = pv.get(i).getPid();
			vname[i] = pv.get(i).getPname();
			vage[i] = pv.get(i).getPage();
			vdate[i] = pv.get(i).getPdate();
			vbed[i] = pv.get(i).getPbed();
		}
		%>	
		
		loadbutton();
	};

	function getAllUrlParams(url) {
		// get query string from url (optional) or window
		var queryString = url ? url.split('?')[1] : window.location.search.slice(1);
		// we'll store the parameters here
		var obj = {};
		// if query string exists
		if (queryString) {
			// stuff after # is not part of query string, so get rid of it
			queryString = queryString.split('#')[0];
			// split our query string into its component parts
			var arr = queryString.split('&');
			for (var i = 0; i < arr.length; i++) {
				// separate the keys and the values
				var a = arr[i].split('=');
				// set parameter name and value (use 'true' if empty)
				var paramName = a[0];
				var paramValue = typeof (a[1]) === 'undefined' ? true : a[1];
				// (optional) keep case consistent
				paramName = paramName.toLowerCase();
				if (typeof paramValue === 'string')
					//paramValue = paramValue.toLowerCase();
				// if the paramName ends with square brackets, e.g. colors[] or colors[2]
				if (paramName.match(/\[(\d+)?\]$/)) {
					// create key if it doesn't exist
					var key = paramName.replace(/\[(\d+)?\]/, '');
					if (!obj[key])
						obj[key] = [];
					// if it's an indexed array e.g. colors[2]
					if (paramName.match(/\[\d+\]$/)) {
						// get the index value and add the entry at the appropriate position
						var index = /\[(\d+)\]/.exec(paramName)[1];
						obj[key][index] = paramValue;
					} else {
						// otherwise add the value to the end of the array
						obj[key].push(paramValue);
					}
				} else {
					// we're dealing with a string
					if (!obj[paramName]) {
						// if it doesn't exist, create property
						obj[paramName] = paramValue;
					} else if (obj[paramName]
							&& typeof obj[paramName] === 'string') {
						// if property does exist and it's a string, convert it to an array
						obj[paramName] = [ obj[paramName] ];
						obj[paramName].push(paramValue);
					} else {
						// otherwise add the property
						obj[paramName].push(paramValue);
					}
				}
			}
		}
		return obj;
	}

	var res=null;
	var s = "Success";
	var ons;
	function loadbutton() {
		document.getElementById("default").click();
		const url = window.location.href;
		//getParams(window.location.search.substring(1));
		//alert(getAllUrlParams(url).usmg);
		<%
			String smsg = request.getParameter("smsg") == null ? null : request.getParameter("smsg");
			//System.out.println(smsg);
		%>
		res = getAllUrlParams(url).smsg;	
		//console.log(res);
		//alert(getAllUrlParams(url).smsg);
		//alert(res);
		if (res != null) {
			//alert(res);
			//document.getElementById("updatebutton").disabled = false;
			//alert("inside");
			<%
				String go = request.getParameter("go") == null ? null : request.getParameter("go");
				//System.out.println(smsg);
			%>
			var m = '<%=go%>';
			var call=null;
			if(m.localeCompare("c") == 0){
				document.getElementById("default").click();
				call = document.getElementsByClassName("searchres")[0];
				}
			else if(m.localeCompare("u") == 0){
				document.getElementById("updatebutton").click();
				call = document.getElementsByClassName("searchres")[1];
				}
			else if(m.localeCompare("d") == 0){
				document.getElementById("deletebutton").click();
				call = document.getElementsByClassName("searchres")[2];
			}
			else if(m.localeCompare("s") == 0){
				document.getElementById("searchbutton").click();
				call = document.getElementsByClassName("searchres")[3];
			}
			else if(m.localeCompare("b") == 0){
				//alert(res);
				document.getElementById("billbutton").click();
				call = document.getElementsByClassName("searchres")[4];
			}
			ons=call;
			if (res.localeCompare(s) == 0) {
				//alert(res);
				//if(m.localeCompare("u") == 0 || m.localeCompare("s") == 0 || m.localeCompare("d") == 0)
				loadresults(call);
			}
		}
	}

	
	function loadresults(call) {
		call.style.display="block";
		
		//const url = window.location.href;
		//window.history.replaceState({}, document.title, "/"+"/HMS/desk.jsp");
		<%
			String pname = request.getParameter("pname");
			//System.out.println(pname);
			//page can't be used since it's a implicit variable in scriplets
			//refering to the current page
			String age = request.getParameter("page");
			//System.out.println(age);
			
			String pdate = request.getParameter("padmit");
			//System.out.println(pdate);
			
			String pbed = request.getParameter("pbed");
			//System.out.println(pbed);
			
			String paddr = request.getParameter("paddr");
			//System.out.println(paddr);
			
			String pcity = request.getParameter("pcity");
			//System.out.println(pcity);
			
			String pstate = request.getParameter("pstate");
			//	System.out.println(pstate);
			
			String pid = request.getParameter("spid");
			//System.out.println(pid);
		%>
		
		call.getElementsByTagName("input")[1].value = '<%=pid%>';
		call.getElementsByTagName("input")[1].required = true;
		
		call.getElementsByTagName("input")[2].value = '<%=pname%>';
		call.getElementsByTagName("input")[2].required = true;
		
		call.getElementsByTagName("input")[3].value = '<%=age%>';
		call.getElementsByTagName("input")[3].required = true;
		
		call.getElementsByTagName("input")[4].value = '<%=pdate%>';
		call.getElementsByTagName("input")[4].required = true;
		
		call.getElementsByTagName("select").setbed.selectedIndex = '<%=pbed%>';
		call.getElementsByTagName("select")[0].required = true;
		//document.getElementById("setbed")[2].selected=true;

		call.getElementsByTagName("textarea")[0].value = '<%=paddr%>';
		call.getElementsByTagName("textarea")[0].required = true;

		call.getElementsByTagName("input")[5].value = '<%=pcity%>';
		call.getElementsByTagName("input")[5].required = true;
		
		call.getElementsByTagName("input")[6].value = '<%=pstate%>';
		call.getElementsByTagName("input")[6].required = true;
		
		
		<%
		String del = request.getParameter("deleted") == null ? null : request.getParameter("deleted");
		%>
		var del = '<%=del%>';
		if(del.localeCompare("Patient deletion initiated successfully") == 0){
			call.style.display="none";
		}
	}

	function preventNonNumericalInput(e) {
		e = e || window.event;
		var charCode = (typeof e.which == "undefined") ? e.keyCode : e.which;
		var charStr = String.fromCharCode(charCode);

		if (!charStr.match(/^[0-9]+$/))
			e.preventDefault();
	}

	function openT(evt, name) {
		var i, tabcontent, tablinks;
		<%smsg="";%>
		tabcontent = document.getElementsByClassName("tabcontent");
		for (i = 0; i < tabcontent.length; i++) {
			tabcontent[i].style.display = "none";
		}

		tablinks = document.getElementsByClassName("tablinks");

		for (i = 0; i < tablinks.length; i++) {
			tablinks[i].className = tablinks[i].className
					.replace(" active", "");
		}
		document.getElementById(name).style.display = "block";
		evt.currentTarget.className += " active";
	}
	function showalert() {
		alert("Sorry, you can't change this value");
		ons.getElementsByTagName("select").setbed.selectedIndex = '<%=pbed%>';
	}
	
	function changestat(){
		<%
		DBConnection dbcon = new DBConnection();
		Connection con = dbcon.getConnection();
		
		String sql = "update patients set status=? where pid=?";
		
		try{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, "Discharged");
			ps.setString(2, pid);
			int brr = ps.executeUpdate();
			System.out.println(brr);
		} catch (SQLException e) {
			System.out.println("Error in doPost Update class");
			e.printStackTrace();
		}
		%>
		document.getElementById("confirmbutton").innerHTML="Patient Discharged";
		
	}
</script>



<body
	style="background-color: lightblue; text-align: left; font-size: 13px">
	
	 <h1 align="center" class="auto-style3" style="color: #00FFFF; background-color: #000080;">Hospital Management System</h1>
	 <h2>Select Your Role</h2>
	<hr>

	<div>
		<table id="linklist">
			<tr>
				<td><a href="desk.html">Admission Desk Executive</a></td>
				<td><a href="PatientScreen.jsp">Pharmacist</a></td>
				<td><a href="searchpatient_diag.jsp">Diagnostics Service Executive</a></td>
			</tr>
		</table>
	</div>
	
	<hr>

	<div class="tab">
		<button class="tablinks active" onclick="openT(event, 'create')"
			id="default">Create Patient</button>

		<button class="tablinks" onclick="openT(event, 'update')"
			id="updatebutton">Update Patient</button>

		<button class="tablinks" onclick="openT(event, 'delete')"
			id="deletebutton">Delete Patient</button>

		<button class="tablinks" onclick="openT(event, 'view');"
			id="viewbutton">View Patient</button>

		<button class="tablinks" onclick="openT(event, 'search')"
			id="searchbutton">Search Patient</button>

		<button class="tablinks" onclick="openT(event, 'bill')"
			id="billbutton">Billing</button>
	</div>

	<div id="create" class="tabcontent">
		<form class="searchres" style="margin-left: auto; margin-right: auto;" action="Create" method="post" autocomplete="off">
			<table>
				<tr>
					<td>
						<b>Patient ID</b>
					</td>
					<td>
						<input name="goto" value="c" type="hidden">
						<input type="text" name="pid" placeholder="Enter ID"
						onkeydown="return event.keyCode !== 69"
						onkeypress="preventNonNumericalInput(event)" maxlength = "9" minlength = "9" required>
					</td>
				</tr>

				<tr>
					<td>	
						<b>Patient Name</b>
					</td>
					<td>
						<input type="text" name="pname" placeholder="Enter Name" required>
					</td>
				</tr>

				<tr>
					<td>
						<b>Age</b>
						</td>
					<td>
						<input type="number" name="page" placeholder="Enter Age"
						onkeydown="return event.keyCode !== 69"
						onkeypress="preventNonNumericalInput(event)" required>
					</td>
				</tr>

				<tr>
					<td>
						<b>Date of Admission</b>
					</td>
					<td>	
						<input type="date" name="padmit"
						placeholder="Enter Admission Date" required>
					</td>
				</tr>

				<tr>
					<td>	
						<b>Type of Bed</b>
					</td>
					<td>
						<select id="setbed" name="pbed" required>
							<option value="General Ward">General Ward</option>
							<option value="Semi-Sharing">Semi-Sharing</option>
							<option value="Single Room">Single Room</option>
						</select>
					</td>
				</tr>

				<tr>
					<td>	
						<b>Address</b>
					</td>
					<td>
						<textarea name="paddr" cols="25" placeholder="Enter address" required></textarea>
					</td>
				</tr>

				<tr>
					<td>
						<b>City</b>
					</td>
					<td><input type="text" name="pcity" placeholder="Enter City" required>
					</td>
				</tr>

				<tr>
					<td>
						<b>State</b>
					</td>
					<td><input type="text" name="pstate" placeholder="Enter State" required></td>
				</tr>
				<tr>
				<tr>
					<td><input type="submit" value="Insert Patient"></td>
					<td><input type="reset"></td>
					
					<%
						String cmsg = request.getParameter("created");
						if(cmsg != null){ 
					%>
						<td>						
							<p style="color:red;"><%= cmsg %></p>
						</td>
					<%
						}
					%>
				</tr>
			</table>
		</form>
	</div>

	<div id="update" class="tabcontent" style="display: none;">
		<form style="margin-left: auto; margin-right: auto;" action="Desk" method="post" autocomplete="off">
			<table>
				<tr>
					<td><b>Patient ID</b> 
						<input name="goto" value="u" type="hidden">
						<input id="spid" type="text" name="spid" placeholder="Enter ID"
						onkeydown="return event.keyCode !== 69"
						onkeypress="preventNonNumericalInput(event)" maxlength="9" minlength = "9" required></td>
				</tr>

				<%
					if (!(smsg == null)) {
				%>

				<tr>
					<td style="color: red; text-align: center"><%=smsg%></td>
				</tr>
				<%
					}
				%>
				<tr>
					<td><input type="submit" value="Search"></td>
				</tr>
			</table>
		</form>

		<form class="searchres" style="margin-left: auto; margin-right: auto; display: none;" action="Update" method="post" autocomplete="off">
			<table>
				<tbody>
				<tr>
					<td>
						<b>Patient ID</b>
					</td>
					<td>
						<input name="goto" value="u" type="hidden">
						<input id="setpid" type="text" name="spid" placeholder="Enter ID" required readonly>
					</td>
				</tr>
					<tr>
						<td>
							<b>Patient Name</b>
						</td>
						<td>
							<input id="setname" name="pname" type="text" placeholder="Enter Name">
						</td>
					</tr>

					<tr>
						<td>
							<b>Age</b>
						</td>
						<td>
							<input id="setage" name="page" type="number" 
							placeholder="Enter Age" onkeydown="return event.keyCode !== 69"
							onkeypress="preventNonNumericalInput(event)">
						</td>
					</tr>

					<tr>
						<td>
							<b>Date of Admission</b>
						</td>
						<td>
							<input id="setdate" name="padmit" type="date" placeholder="Enter Admission Date">
						</td>
					</tr>

					<tr>
						<td>	
							<b>Type of Bed</b>
						</td>
						<td>
							<select id="setbed" name="pbed">
								<option value="General Ward">General Ward</option>
								<option value="Semi-Sharing">Semi-Sharing</option>
								<option value="Single Room">Single Room</option>
							</select>
						</td>	
					</tr>

					<tr>
						<td>	
							<b>Address</b>
						</td>
						<td>
							<textarea id="setaddr" name="paddr" cols="25" placeholder="Enter address"></textarea>
						</td>
					</tr>

					<tr>
						<td>
							<b>City</b>
						</td>
						<td>
							<input id="setcity" name="pcity" type="text" placeholder="Enter City">
						</td>
					</tr>

					<tr>
						<td>	
							<b>State</b>
						</td>
						<td>
							<input id="setstate" name="pstate" type="text" placeholder="Enter State">
						</td>
					</tr>
					<tr>
						<td><input type="submit" value="Update Details"></td>
							<%
								String updated =  null;
								updated = request.getParameter("updated") == null ? null : request.getParameter("updated");
								if (! (updated==null)) {
							%>
						<td style="color: red; text-align: center"><%=updated%></td>
							<%
								}
							%>
					</tr>
				</tbody>
			</table>
		</form>
	</div>

	<div id="delete" class="tabcontent" style="display: none;">
		<form style="margin-left: auto; margin-right: auto;" action="Desk" method="post" autocomplete="off">
			<table>
				<tr>
					<td>
						<b>Patient ID</b>
						<input name="goto" value="d" type="hidden">
						<input id="spid" type="text" name="spid" placeholder="Enter ID"
						onkeydown="return event.keyCode !== 69"
						onkeypress="preventNonNumericalInput(event)" maxlength="9" minlength = "9" required>
					</td>
				</tr>

				<tr>
					<td><input type="submit" value="Search"></td>
					<%
						String dmsg = request.getParameter("deleted");
						if(dmsg != null){ 
					%>
						<td>						
							<p style="color:red;"><%= dmsg %></p>
						</td>
					<%
						}
					%>
				</tr>
			</table>
		</form>
		
		<form class="searchres" style="margin-left: auto; margin-right: auto; display: none;" action="Delete" method="post" autocomplete="off">
			<!-- LOAD SEARCH RESULTS -->
			<table>
				<tbody>
				<tr>
					<td>
						<b>Patient ID</b>
					</td>
					<td>
						<input name="goto" value="d" type="hidden">
						<input id="setpid" type="text" name="spid" placeholder="Enter ID" required readonly>
					</td>
				</tr>
					<tr>
						<td>
							<b>Patient Name</b>
						</td>
						<td>
							<input id="setname" name="pname" type="text" placeholder="Enter Name" readonly>
						</td>
					</tr>

					<tr>
						<td>
							<b>Age</b>
						</td>
						<td>
							<input id="setage" name="page" type="number" readonly 
							placeholder="Enter Age" onkeydown="return event.keyCode !== 69"
							onkeypress="preventNonNumericalInput(event)">
						</td>
					</tr>

					<tr>
						<td>
							<b>Date of Admission</b>
						</td>
						<td>
							<input id="setdate" name="padmit" type="date" placeholder="Enter Admission Date" readonly>
						</td>
					</tr>

					<tr>
						<td>	
							<b>Type of Bed</b>
						</td>
						<td>
							<select id="setbed" name="pbed" onchange="showalert()" disabled>
								<option value="General Ward">General Ward</option>
								<option value="Semi-Sharing">Semi-Sharing</option>
								<option value="Single Room">Single Room</option>
							</select>
						</td>
					</tr>

					<tr>
						<td>	
							<b>Address</b>
						</td>
						<td>
							<textarea id="setaddr" name="paddr" cols="25" placeholder="Enter address" readonly></textarea>
						</td>
					</tr>

					<tr>
						<td>
							<b>City</b>
						</td>
						<td>
							<input id="setcity" name="pcity" type="text" placeholder="Enter City" readonly>
						</td>
					</tr>

					<tr>
						<td>	
							<b>State</b>
						</td>
						<td>
							<input id="setstate" name="pstate" type="text" placeholder="Enter State" readonly>
						</td>
					</tr>
					<tr>
						<td><input type="submit" value="Delete Patient"></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	
	<div id="search" class="tabcontent" style="display: none;">
		<form style="margin-left: auto; margin-right: auto;" action="Desk" method="post" autocomplete="off">
			<table>
				<tr>
					<td><b>Patient ID</b> 
						<input name="goto" value="s" type="hidden"> 
						<input id="spid" type="text" name="spid" placeholder="Enter ID" 
						onkeydown="return event.keyCode !== 69"
						onkeypress="preventNonNumericalInput(event)" maxlength="9" minlength = "9" required required>
					</td>
				</tr>

				<%
					String s = request.getParameter("search");
					//System.out.println(s);	
					if (s != null) {
				%>

				<tr>
					<td style="color: red; text-align: center"><%=s%></td>
				</tr>
				<%
					}
				%>
				<tr>
					<td><input type="submit" value="Search"></td>
				</tr>
			</table>
		</form>

		<form class="searchres" style="margin-left: auto; margin-right: auto; display: none;" autocomplete="off">
			<table>
				<tbody>
				<tr>
					<td>
						<b>Patient ID</b>
					</td>
					<td>
						<input name="goto" value="d" type="hidden">
						<input id="setpid" type="text" name="spid" placeholder="Enter ID" required readonly>
					</td>
				</tr>
					<tr>
						<td>
							<b>Patient Name</b>
						</td>
						<td>
							<input id="setname" name="pname" type="text" placeholder="Enter Name" readonly>
						</td>
					</tr>

					<tr>
						<td>
							<b>Age</b>
						</td>
						<td>
							<input id="setage" name="page" type="number" readonly 
							placeholder="Enter Age" onkeydown="return event.keyCode !== 69"
							onkeypress="preventNonNumericalInput(event)">
						</td>
					</tr>

					<tr>
						<td>
							<b>Date of Admission</b>
						</td>
						<td>
							<input id="setdate" name="padmit" type="date" placeholder="Enter Admission Date" readonly>
						</td>
					</tr>

					<tr>
						<td>	
							<b>Type of Bed</b>
						</td>
						<td>
							<select id="setbed" name="pbed" disabled>
								<option value="General Ward">General Ward</option>
								<option value="Semi-Sharing">Semi-Sharing</option>
								<option value="Single Room">Single Room</option>
							</select>
						</td>
					</tr>

					<tr>
						<td>	
							<b>Address</b>
						</td>
						<td>
							<textarea id="setaddr" name="paddr" cols="25" placeholder="Enter address" readonly></textarea>
						</td>
					</tr>

					<tr>
						<td>
							<b>City</b>
						</td>
						<td>
							<input id="setcity" name="pcity" type="text" placeholder="Enter City" readonly>
						</td>
					</tr>

					<tr>
						<td>	
							<b>State</b>
						</td>
						<td>
							<input id="setstate" name="pstate" type="text" placeholder="Enter State" readonly>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>

	<div id="view" class="tabcontent" style="display: none;">
		<form id="viewform" style="margin-left: auto; margin-right: auto;" action="View" method="post" autocomplete="off">
			<input name="goto" value="v" type="hidden">
			<table border="1" id="vtable" style="border: 1px solid black; padding:15px; text-align:center;">
				<thead >
				<tr>
					<th>	Patient ID			</th>
					<th>	Patient Name		</th>
					<th>	Age					</th>
					<th>	Date of Admission	</th>
					<th>	Bed Type			</th>
					<th>	Status				</th>
				</tr>
				</thead>
				
				<tbody>
				<%
				for(int i=0;i<len;i++){
				%>
				<tr>
					<td>	<%=vid[i]%>		</td>
					<td>	<%=vname[i]%>	</td>
					<td>	<%=vage[i]%>	</td>
					<td>	<%=vdate[i]%>	</td>
					<td>	<%=vbed[i]%>	</td>
					<td>	Active			</td>
				</tr>
				<%
				}
				%>
				</tbody>
			</table>
		</form>
	</div>
	
	<div id="bill" class="tabcontent" style="display: none;">
		<form style="margin-left: auto; margin-right: auto;" action="Bill" method="post" autocomplete="off">
			<table>
				<tr>
					<td>
						<b>Patient ID</b> 
							<input name="goto" value="b" type="hidden">
							<input id="spid" type="text" name="spid" placeholder="Enter ID" 
							onkeydown="return event.keyCode !== 69"
							onkeypress="preventNonNumericalInput(event)" maxlength="9" minlength = "9" required>
					</td>
				</tr>

				<%
					if (!(s == null)) {
				%>

				<tr>
					<td style="color: red; text-align: center"><%=smsg%></td>
				</tr>
				<%
					}
				%>
				<tr>
					<td><input type="submit" value="Search"></td>
				</tr>
			</table>
		</form>
		
		<form class="searchres" style="margin-left: auto; margin-right: auto; display: none;" autocomplete="off">
			<table>
				<tbody>
				<tr>
					<td>
						<input name="goto" value="d" type="hidden">
						<input id="setpid" type="hidden" name="spid" placeholder="Enter ID" required readonly>
					</td>
				</tr>
					<tr>
						<td>
							<b>Patient Name</b>
						</td>
						<td>
							<input id="setname" name="pname" type="text" placeholder="Enter Name" readonly>
						</td>
					</tr>

					<tr>
						<td>
							<b>Age</b>
						</td>
						<td>
							<input id="setage" name="page" type="number" readonly 
							placeholder="Enter Age" onkeydown="return event.keyCode !== 69"
							onkeypress="preventNonNumericalInput(event)">
						</td>
					</tr>

					<tr>
						<td>
							<b>Date of Admission</b>
						</td>
						<td>
							<input id="setdate" name="padmit" type="date" placeholder="Enter Admission Date" readonly>
						</td>
					</tr>

					<tr>
						<td>	
							<b>Type of Bed</b>
						</td>
						<td>
							<select id="setbed" name="pbed" disabled>
								<option value="General Ward">General Ward</option>
								<option value="Semi-Sharing">Semi-Sharing</option>
								<option value="Single Room">Single Room</option>
							</select>
						</td>
						<td> 
							<%
							float bedtotal = 0;
							if(go.equalsIgnoreCase("b") && smsg.equalsIgnoreCase("Success")){
								
								int x = 0;
								String bed = request.getParameter("pbed");
							if (bed.equalsIgnoreCase("0")){
								x=2000;
								bedtotal = Float.parseFloat(request.getParameter("days")) * 2000;
							}
							else if (bed.equalsIgnoreCase("1")){
								x=4000;
								bedtotal = Float.parseFloat(request.getParameter("days")) * 4000;
							}
							else{
								x=8000;
								bedtotal = Float.parseFloat(request.getParameter("days")) * 8000;
								
							}
							%>
							<b>Room Total</b> = Rs. <%=bedtotal %> (Rs. <%=x %> per day) 
						</td>
						<%
							}
						%>
					</tr>

					<tr>
						<td>	
							<b>Address</b>
						</td>
						<td>
							<textarea id="setaddr" name="paddr" cols="25" placeholder="Enter address" readonly></textarea>
						</td>
					</tr>

					<tr>
						<td>
							<input id="setcity" name="pcity" type="hidden" placeholder="Enter City" readonly>
						</td>
					</tr>

					<tr>
						<td>
							<input id="setstate" name="pstate" type="hidden" placeholder="Enter State" readonly>
						</td>
					</tr>
					
					<tr>
						<td>
							<b>Date of Discharge</b>
						</td>
						<td>
							<% String disc = request.getParameter("disc"); %>
							<input id="setdate" name="padmit" type="date" placeholder="Enter Admission Date" readonly value=<%= disc %>>
						</td>
					</tr>
					<tr>
						<td>
							<b>Days in Hospital</b>
						</td>
						<td>
							<% String days = request.getParameter("days"); %>
							<input id="setage" name="page" placeholder="Enter Age" readonly value=<%= days %>>
						</td>
					</tr>
					<tr>
						<td>
							<input type="button" value="Confirm" onclick="changestat()">
							<p id="confirmbutton" style="color:red;"></p>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	
	
	
	<%
		if(go.equalsIgnoreCase("b")){
		/* if(false)
		System.out.println(tpid != null); */
		float testtotal=0;
		String tpid =  null;
		tpid = request.getParameter("spid");
		//System.out.println(tpid);
		if(tpid != null){
			//System.out.println("inside");
			Tests t = new Tests();
			ArrayList<Tests> tests = new ArrayList<Tests>();
			
			tests = t.getTests(tpid);
			int tlen = tests.size();
			String tid[] = new String[tlen];
			String tname[] = new String[tlen];
			float tquan[] = new float[tlen];
			float trate[] = new float[tlen];
			
			//System.out.println(tlen);
	%>
	<div style="display: block; margin:0px; height: 10px; width: 700px;">
		<table id="vtable" style="width:100	%;">
			<thead>
				<tr>
					<th>	Test ID			</th>
					<th>	Test Name		</th>
					<th>	Test Quantity	</th>
					<th>	Test Rate		</th>
					<th>	Test Cost		</th>
				</tr>
			</thead>
			<tbody>
			<%
			
			for(int i=0;i<tlen;i++){
				float sum = tests.get(i).getTrate() * tests.get(i).getTquan();
				testtotal+=sum;
			%>
				<tr>
					<td>	<%=tests.get(i).getTid() %>		</td>
					<td>	<%=tests.get(i).getTname() %>	</td>
					<td>	<%=tests.get(i).getTquan( )%>	</td>
					<td>	<%=tests.get(i).getTrate( )%>	</td>
					<td>	<%=sum %>						</td>
				</tr>
			<%
				}
			%>
			<tr>	<td></td>	<td></td>	<td></td>	<td></td>	<td></td> 
			</tr>
			<tr>
			</tr>
				<tr>
					<td>	<b>Tests Total</b>	</td>
					<td>	Rs. <%= testtotal %>	</td>
				<tr>
			<%
			}
			%>
			</tbody>
		</table>
	</div>
	
	
	
	
	<%
		float medtotal=0;
		String mpid =  null;
		mpid = request.getParameter("spid");
		//System.out.println(tpid);
		if(mpid != null){
			//System.out.println("inside");
			Meds t = new Meds();
			ArrayList<Meds> meds = new ArrayList<Meds>();
			
			meds = t.getMeds(mpid);
			int mlen = meds.size();
			String mid[] = new String[mlen];
			String mname[] = new String[mlen];
			float mquan[] = new float[mlen];
			float mrate[] = new float[mlen];
			
			//System.out.println(tlen);
	%>
	<div style="display: block; margin:0px 750px 0px; height: 200px; width: 700px;">
		<table id="vtable" style="width:100%;" >
			<thead>
				<tr>
					<th>	Medicine ID			</th>
					<th>	Medicine Name		</th>
					<th>	Medicine Quantity	</th>
					<th>	Medicine Rate		</th>
					<th>	Medicine Cost		</th>
				</tr>
			</thead>
			<tbody>
			<%
			
			for(int i=0;i<mlen;i++){
				float tsum = meds.get(i).getMrate() * meds.get(i).getMquan();
				medtotal+=tsum;
			%>
				<tr>
					<td>	<%=meds.get(i).getMid() %>		</td>
					<td>	<%=meds.get(i).getMname() %>	</td>
					<td>	<%=meds.get(i).getMquan( )%>	</td>
					<td>	<%=meds.get(i).getMrate( )%>	</td>
					<td>	<%=tsum %>						</td>
				</tr>
			<%
				}
			%>
			<tr>	<td></td>	<td></td>	<td></td>	<td></td>	<td></td> 
			</tr>
			<tr>
			</tr>
				<tr>
					<td>	<b>Medicine Total</b>	</td>
					<td>	Rs. <%= medtotal %>	</td>
				<tr>
				<tr>
					<td colspan="2">	<b>Grand Total</b> = Rs. <%= medtotal+testtotal+bedtotal%>
				</tr>
			<%
			}
		}
			%>
			</tbody>
		</table>
	</div>
	
	

</body>
</html>