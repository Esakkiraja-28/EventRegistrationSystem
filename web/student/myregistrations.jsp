<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.demo.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>My Registrations</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

</head>

<body class="bg-light">

<div class="container mt-5">

<%

String message =
(String)session.getAttribute("message");

if(message != null)
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

<div class="d-flex justify-content-between mb-4">

<h2 class="text-success">

<i class="bi bi-ticket-perforated-fill"></i>

My Registrations

</h2>

<a
href="<%=request.getContextPath()%>/StudentDashboardServlet"
class="btn btn-secondary">

<i class="bi bi-arrow-left"></i>

Back to Dashboard

</a>

</div>

<div class="table-responsive">

<table class="table table-bordered table-hover shadow">

<thead class="table-success">

<tr>

<th>ID</th>
<th>Event Name</th>
<th>Date</th>
<th>Venue</th>
<th>Status</th>
<th>Action</th>

</tr>

</thead>

<tbody>

<%

try
{

String email =
(String)session.getAttribute("studentEmail");

Connection con =
DBConnection.getConnection();

PreparedStatement ps =
con.prepareStatement(

"SELECT r.id,"
+ " e.event_name,"
+ " e.event_date,"
+ " e.venue,"
+ " r.registration_date "
+ "FROM registrations r "
+ "JOIN events e "
+ "ON r.event_name=e.event_name "
+ "WHERE r.student_email=? "
+ "ORDER BY r.registration_date DESC"

);

ps.setString(1,email);

ResultSet rs =
ps.executeQuery();

SimpleDateFormat sdf =
new SimpleDateFormat("dd-MM-yyyy");

int sno = 1;

while(rs.next())
{

%>

<tr>

<td>

<%=sno++%>

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

<span class="badge bg-success">

Registered

</span>

</td>

<td>

<a
href="<%=request.getContextPath()%>/CancelRegistrationServlet?id=<%=rs.getInt("id")%>"
class="btn btn-danger btn-sm"
onclick="return confirm('Cancel this registration?');">

Cancel

</a>

</td>

</tr>

<%

}

rs.close();
ps.close();

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

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>