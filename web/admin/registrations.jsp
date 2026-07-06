<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.demo.DBConnection"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Student Registrations</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

</head>

<body class="bg-light">

<div class="container mt-5">

<div class="d-flex justify-content-between align-items-center mb-4">

<h2>

<i class="bi bi-journal-check"></i>

Student Registrations

</h2>

<a
href="<%=request.getContextPath()%>/AdminDashboardServlet"
class="btn btn-secondary">

<i class="bi bi-arrow-left"></i>

Back to Dashboard

</a>

</div>

<div class="table-responsive">

<table class="table table-bordered table-hover shadow">

<thead class="table-dark">

<tr>

<th>S.No</th>
<th>Student Name</th>
<th>Email</th>
<th>Department</th>
<th>Year</th>
<th>Event Name</th>
<th>Registered On</th>

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

"SELECT r.id,"
+ " s.name,"
+ " s.email,"
+ " s.department,"
+ " s.year,"
+ " e.event_name,"
+ " r.registration_date "
+ "FROM registrations r "
+ "JOIN students s "
+ "ON r.student_email=s.email "
+ "JOIN events e "
+ "ON r.event_name=e.event_name "
+ "ORDER BY r.registration_date DESC"

);

SimpleDateFormat sdf =
new SimpleDateFormat("dd-MM-yyyy hh:mm a");

int serialNo = 1;

while(rs.next())
{

%>

<tr>

<td>

<%=serialNo++%>

</td>

<td>

<%=rs.getString("name")%>

</td>

<td>

<%=rs.getString("email")%>

</td>

<td>

<%=rs.getString("department")%>

</td>

<td>

<%=rs.getString("year")%>

</td>

<td>

<%=rs.getString("event_name")%>

</td>

<td>

<%=sdf.format(rs.getTimestamp("registration_date"))%>

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

<td colspan="7" class="text-center text-danger">

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