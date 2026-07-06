<%@page import="java.sql.*"%>
<%@page import="com.demo.DBConnection"%>

<!DOCTYPE html>
<html>
<head>

<title>Reports</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

</head>

<body>

<div class="container mt-5">

<h2>System Reports</h2>

<%
Connection con =
DBConnection.getConnection();

Statement st =
con.createStatement();

ResultSet rs1 =
st.executeQuery(
"SELECT COUNT(*) FROM students"
);

rs1.next();
int students =
rs1.getInt(1);

ResultSet rs2 =
st.executeQuery(
"SELECT COUNT(*) FROM events"
);

rs2.next();
int events =
rs2.getInt(1);

ResultSet rs3 =
st.executeQuery(
"SELECT COUNT(*) FROM registrations"
);

rs3.next();
int registrations =
rs3.getInt(1);
%>

<div class="row">

<div class="col-md-4">

<div class="card shadow">

<div class="card-body text-center">

<h4>Total Students</h4>

<h1><%=students%></h1>

</div>

</div>

</div>

<div class="col-md-4">

<div class="card shadow">

<div class="card-body text-center">

<h4>Total Events</h4>

<h1><%=events%></h1>

</div>

</div>

</div>

<div class="col-md-4">

<div class="card shadow">

<div class="card-body text-center">

<h4>Total Registrations</h4>

<h1><%=registrations%></h1>

</div>

</div>

</div>

</div>

</div>

</body>
</html>