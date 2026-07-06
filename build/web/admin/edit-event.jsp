<%@page import="java.sql.*"%>
<%@page import="com.demo.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

int id =
Integer.parseInt(request.getParameter("id"));

Connection con =
DBConnection.getConnection();

PreparedStatement ps =
con.prepareStatement(
"SELECT * FROM events WHERE id=?"
);

ps.setInt(1,id);

ResultSet rs =
ps.executeQuery();

rs.next();

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1">

<title>Edit Event</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>

body{

background:#f5f7fb;

}

.card{

border:none;

border-radius:15px;

}

.header{

background:linear-gradient(90deg,#0d6efd,#198754);

color:white;

padding:20px;

border-radius:15px 15px 0 0;

}

</style>

</head>

<body>

<div class="container mt-5">

<div class="row justify-content-center">

<div class="col-lg-8">

<div class="card shadow">

<div class="header">

<h2>

<i class="bi bi-pencil-square"></i>

Edit Event

</h2>

<p>

Update Event Information

</p>

</div>

<div class="card-body">

<form action="<%=request.getContextPath()%>/EditEventServlet"
method="post">

<input
type="hidden"
name="id"
value="<%=rs.getInt("id")%>">
<div class="mb-3">

<label class="form-label">

Event Name

</label>

<input
type="text"
name="eventName"
class="form-control"
value="<%=rs.getString("event_name")%>"
required>

</div>

<div class="mb-3">

<label class="form-label">

Event Date

</label>

<input
type="date"
name="eventDate"
class="form-control"
value="<%=rs.getString("event_date")%>"
required>

</div>

<div class="mb-3">

<label class="form-label">

Venue

</label>

<input
type="text"
name="venue"
class="form-control"
value="<%=rs.getString("venue")%>"
required>

</div>

<div class="mb-3">

<label class="form-label">

Capacity

</label>

<input
type="number"
name="capacity"
class="form-control"
value="<%=rs.getInt("capacity")%>"
min="1"
required>

</div>

<div class="mb-3">

<label class="form-label">

Description

</label>

<textarea
name="description"
class="form-control"
rows="4"
required><%=rs.getString("description")%></textarea>

</div>
<div class="d-flex justify-content-between">

<button
type="submit"
class="btn btn-success">

<i class="bi bi-check-circle-fill"></i>

Update Event

</button>

<a
href="event-list.jsp"
class="btn btn-secondary">

<i class="bi bi-arrow-left-circle-fill"></i>

Back

</a>

</div>

</form>

</div>

</div>

</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>