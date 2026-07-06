<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.demo.DBConnection"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Available Events</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

</head>

<body>

<div class="container mt-5">

<%

String message =
(String)session.getAttribute("message");

if(message!=null)
{

%>

<div class="alert alert-info alert-dismissible fade show">

<%=message%>

<button
type="button"
class="btn-close"
data-bs-dismiss="alert">
</button>

</div>

<%

session.removeAttribute("message");

}

%>

<h2 class="mb-4">

Available Events

</h2>

<table class="table table-bordered table-hover">

<thead class="table-dark">

<tr>

<th>S.No</th>
<th>Event Name</th>
<th>Date</th>
<th>Venue</th>
<th>Capacity</th>
<th>Action</th>

</tr>

</thead>

<tbody>

<%

try
{

Connection con =
DBConnection.getConnection();

Statement st =
con.createStatement();

ResultSet rs =
st.executeQuery(

"SELECT * FROM events ORDER BY event_date ASC"

);

SimpleDateFormat sdf =
new SimpleDateFormat("dd-MM-yyyy");

int serialNo = 1;

while(rs.next())
{

%>

<tr>

<td>

<%=serialNo++%>

</td>

<td>

<%=rs.getString("event_name")%>

</td>

<td>

<%=sdf.format(rs.getDate("event_date"))%>

</td>

<td>

<%=rs.getString("venue")%>

</td>

<td>

<%=rs.getInt("capacity")%>

</td>

<td>

<form
action="../RegisterEventServlet"
method="post">

<input
type="hidden"
name="eventName"
value="<%=rs.getString("event_name")%>">

<button
type="submit"
class="btn btn-success btn-sm">

Register

</button>

</form>

</td>

</tr>

<%

}

rs.close();
st.close();

}
catch(Exception e)
{

%>

<tr>

<td colspan="6" class="text-center text-danger">

<%=e.getMessage()%>

</td>

</tr>

<%

}

%>

</tbody>

</table>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>