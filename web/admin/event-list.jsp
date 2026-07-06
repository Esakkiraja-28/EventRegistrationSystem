<%@page import="java.sql.*"%>
<%@page import="com.demo.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta
name="viewport"
content="width=device-width, initial-scale=1">

<title>Event Management</title>

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link
rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>

body{

background:#f4f6f9;

}

.card{

border:none;

border-radius:15px;

}

.table{

vertical-align:middle;

}

.search-box{

max-width:400px;

}

.action-link{

text-decoration:none;

display:flex;

align-items:center;

gap:6px;

font-weight:600;

margin:4px 0;

transition:.3s;

}

.edit-link{

color:#f0ad00;

}

.edit-link:hover{

color:#c98a00;

transform:translateX(3px);

}

.delete-link{

color:#dc3545;

}

.delete-link:hover{

color:#b02a37;

transform:translateX(3px);

}

</style>

</head>

<body>

<div class="container mt-5">

<div class="d-flex justify-content-between align-items-start mb-4">

<div>

<h2 class="fw-bold text-primary">

<i class="bi bi-calendar-event-fill"></i>

Event Management

</h2>

<p class="text-muted">

Manage all events from one place

</p>

</div>

<div>

<a
href="create-event.jsp"
class="btn btn-success me-2">

<i class="bi bi-plus-circle-fill"></i>

Create Event

</a>

<a
href="<%=request.getContextPath()%>/AdminDashboardServlet"
class="btn btn-secondary">

<i class="bi bi-arrow-left"></i>

Back to Dashboard

</a>

</div>

</div>

<div class="row mb-4">

<div class="col-md-6">

<input
type="text"
id="searchInput"
class="form-control search-box"
placeholder="Search Event Name...">

</div>

</div>

<div class="card shadow">

<div class="card-body">

<table
class="table table-hover table-bordered">

<thead class="table-primary text-center">

<tr>

<th>ID</th>

<th>Event Name</th>

<th>Date</th>

<th>Venue</th>

<th>Capacity</th>

<th>Registered</th>

<th>Seats Left</th>

<th>Description</th>

<th>Status</th>

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
"SELECT * FROM events ORDER BY event_date ASC");

while(rs.next())
{

int capacity =
rs.getInt("capacity");

PreparedStatement ps =
con.prepareStatement(
"SELECT COUNT(*) FROM registrations WHERE event_name=?");

ps.setString(
1,
rs.getString("event_name"));

ResultSet count =
ps.executeQuery();

int registered = 0;

if(count.next())
{

registered =
count.getInt(1);

}

int seatsLeft =
capacity - registered;

%>

<tr>

<td>

<%=rs.getInt("id")%>

</td>

<td>

<%=rs.getString("event_name")%>

</td>

<td>

<%=rs.getString("event_date")%>

</td>

<td>

<%=rs.getString("venue")%>

</td>

<td>

<%=capacity%>

</td>

<td>

<%=registered%>

</td>

<td>

<%=seatsLeft%>

</td>

<td>

<%=rs.getString("description")%>

</td>

<td class="text-center">

<%

if(seatsLeft<=0)
{

%>

<span class="badge bg-danger">

FULL

</span>

<%

}
else if(seatsLeft<=10)
{

%>

<span class="badge bg-warning text-dark">

Almost Full

</span>

<%

}
else
{

%>

<span class="badge bg-success">

Available

</span>

<%

}

%>

</td>

<td class="text-center">

<a
href="<%=request.getContextPath()%>/admin/edit-event.jsp?id=<%=rs.getInt("id")%>"
class="action-link edit-link">

<i class="bi bi-pencil-square"></i>

<span>Edit</span>

</a>

<a
href="<%=request.getContextPath()%>/DeleteEventServlet?id=<%=rs.getInt("id")%>"
class="action-link delete-link"
onclick="return confirm('Are you sure you want to delete this event?');">

<i class="bi bi-trash-fill"></i>

<span>Delete</span>

</a>

</td>

</tr>

<%

}

}
catch(Exception e)
{

out.println(

"<tr>" +
"<td colspan='10' class='text-center text-danger fw-bold'>" +
e.getMessage() +
"</td>" +
"</tr>"

);

}

%>

</tbody>

</table>

</div>

</div>
<script>

document.getElementById("searchInput").addEventListener("keyup", function () {

    let filter =
    this.value.toLowerCase();

    let rows =
    document.querySelectorAll("tbody tr");

    rows.forEach(function(row){

        let eventName =
        row.cells[1].textContent.toLowerCase();

        if(eventName.includes(filter))
        {
            row.style.display = "";
        }
        else
        {
            row.style.display = "none";
        }

    });

});

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>