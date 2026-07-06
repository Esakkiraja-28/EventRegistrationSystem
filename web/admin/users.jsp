<%@page import="java.sql.*"%>
<%@page import="com.demo.DBConnection"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Registered Students</title>

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link
rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

</head>

<body class="bg-light">

<div class="container mt-5">

<div class="d-flex justify-content-between align-items-center mb-4">

<h2>

<i class="bi bi-people-fill"></i>

Registered Students

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
<th>Name</th>
<th>Email</th>
<th>Department</th>
<th>Year</th>

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

"SELECT * FROM students ORDER BY name ASC"

);

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

<td colspan="5" class="text-danger text-center">

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