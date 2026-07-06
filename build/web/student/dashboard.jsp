<%
response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>

<%
    if(session.getAttribute("studentEmail")==null)
    {
        response.sendRedirect("../index.jsp");
        return;
    }

    ArrayList<String[]> upcomingEvents =
    (ArrayList<String[]>)request.getAttribute("upcomingEvents");

    Integer totalEvents =
    (Integer)request.getAttribute("totalEvents");

    Integer myRegistrations =
    (Integer)request.getAttribute("myRegistrations");

    if(totalEvents==null)
        totalEvents=0;

    if(myRegistrations==null)
        myRegistrations=0;
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta
name="viewport"
content="width=device-width, initial-scale=1.0">

<title>Student Dashboard</title>

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link
rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>

body{

background:#f5f7fb;

font-family:Arial,sans-serif;

padding-top:85px;

}
.navbar{

position:fixed;

top:0;

left:0;

width:100%;

z-index:9999;

transition:all .3s ease;

}
.hero{
background:linear-gradient(135deg,#198754,#20c997);
color:white;
padding:40px;
border-radius:20px;
box-shadow:0 8px 20px rgba(0,0,0,.15);
}

.profile-card{
border:none;
border-radius:20px;
box-shadow:0 10px 20px rgba(0,0,0,.1);
}

.profile-img{
width:130px;
height:130px;
border-radius:50%;
border:5px solid #198754;
object-fit:cover;
}

.stat-card{
border:none;
border-radius:18px;
color:white;
transition:.3s;
box-shadow:0 8px 20px rgba(0,0,0,.15);
}

.stat-card:hover{
transform:translateY(-6px);
}

.bg1{
background:linear-gradient(135deg,#0d6efd,#5b9dff);
}

.bg2{
background:linear-gradient(135deg,#198754,#42d392);
}

.bg3{
background:linear-gradient(135deg,#fd7e14,#ffb347);
}

.bg4{
background:linear-gradient(135deg,#6f42c1,#b197fc);
}

.icon{
font-size:45px;
opacity:.85;
}

.quick-btn{
border-radius:15px;
padding:15px;
font-weight:bold;
}

</style>

</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-success shadow fixed-top">

<div class="container">

<a class="navbar-brand fw-bold">

<i class="bi bi-calendar-event"></i>

Event Registration System

</a>

<div>

<a href="<%=request.getContextPath()%>/student/events.jsp"
class="btn btn-light me-2">
    Events
</a>

<a
href="<%=request.getContextPath()%>/student/profile.jsp"
class="btn btn-warning me-2">

Profile

</a>

<a
href="<%=request.getContextPath()%>/LogoutServlet"
class="btn btn-danger">

Logout

</a>

</div>

</div>

</nav>

<div class="container mt-4">

<div class="hero">

<h2>

<i class="bi bi-person-circle"></i>

Welcome,
<%=session.getAttribute("studentName")%>

👋

</h2>

<p class="mb-0">

Welcome back to the Event Registration Management System.

Have a productive day!

</p>

</div>

<div class="row mt-4">

<div class="col-lg-4">

<div class="card profile-card">

<div class="card-body text-center">

<img
src="<%=request.getContextPath()%>/images/<%=session.getAttribute("studentPhoto")%>?v=<%=System.currentTimeMillis()%>"
class="profile-img mb-3">

<h4>

<%=session.getAttribute("studentName")%>

</h4>

<hr>

<p>

<i class="bi bi-envelope-fill"></i>

<%=session.getAttribute("studentEmail")%>

</p>

<p>

<i class="bi bi-building"></i>

<%=session.getAttribute("studentDepartment")%>

</p>

<p>

<i class="bi bi-mortarboard-fill"></i>

Year

<%=session.getAttribute("studentYear")%>

</p>

<a
href="<%=request.getContextPath()%>/student/profile.jsp"
class="btn btn-success w-100">

View Full Profile

</a>

</div>

</div>

</div>

<div class="col-lg-8">

<div class="row">

<div class="col-md-6 mb-4">

<div class="card stat-card bg1">

<div class="card-body">

<div class="d-flex justify-content-between">

<div>

<h5>Total Events</h5>

<h2>

<%=totalEvents%>

</h2>

</div>

<i class="bi bi-calendar-event icon"></i>

</div>

</div>

</div>

</div>

<div class="col-md-6 mb-4">

<div class="card stat-card bg2">

<div class="card-body">

<div class="d-flex justify-content-between">

<div>

<h5>My Registrations</h5>

<h2>

<%=myRegistrations%>

</h2>

</div>

<i class="bi bi-ticket-perforated-fill icon"></i>

</div>

</div>

</div>

</div>

<div class="col-md-6 mb-4">

<div class="card stat-card bg3">

<div class="card-body">

<div class="d-flex justify-content-between">

<div>

<h5>Department</h5>

<h4>

<%=session.getAttribute("studentDepartment")%>

</h4>

</div>

<i class="bi bi-building icon"></i>

</div>

</div>

</div>

</div>

<div class="col-md-6 mb-4">

<div class="card stat-card bg4">

<div class="card-body">

<div class="d-flex justify-content-between">

<div>

<h5>Year</h5>

<h2>

<%=session.getAttribute("studentYear")%>

</h2>

</div>

<i class="bi bi-award-fill icon"></i>

</div>

</div>

</div>

</div>

</div>

</div>

</div>
<!-- Upcoming Events -->

<div class="container mt-4">

<div class="row">

<div class="col-lg-8 mb-4">

<div class="card shadow border-0 rounded-4">

<div class="card-header bg-primary text-white rounded-top-4">

<h4 class="mb-0">

<i class="bi bi-calendar-week-fill"></i>

Upcoming Events

</h4>

</div>

<div class="card-body">

<table class="table table-hover align-middle">

<thead>

<tr>

<th>Event</th>

<th>Date</th>

<th>Venue</th>

</tr>

</thead>

<tbody>

<%

if(upcomingEvents != null && upcomingEvents.size() > 0)
{

for(String event[] : upcomingEvents)
{

%>

<tr>

<td>

<span class="badge bg-success me-2">

<i class="bi bi-calendar-event"></i>

</span>

<%=event[0]%>

</td>

<td>

<%=event[1]%>

</td>

<td>

<%=event[2]%>

</td>

</tr>

<%

}

}

else

{

%>

<tr>

<td colspan="3" class="text-center text-danger">

No Upcoming Events

</td>

</tr>

<%

}

%>

</tbody>

</table>

</div>

</div>

</div>

<!-- Recent Activity -->

<div class="col-lg-4 mb-4">

<div class="card shadow border-0 rounded-4">

<div class="card-header bg-warning text-dark rounded-top-4">

<h4 class="mb-0">

<i class="bi bi-bell-fill"></i>

Recent Activity

</h4>

</div>

<div class="card-body">

<div class="mb-4">

<i class="bi bi-check-circle-fill text-success"></i>

Logged into the system successfully.

</div>

<div class="mb-4">

<i class="bi bi-person-check-fill text-primary"></i>

Profile loaded successfully.

</div>

<div class="mb-4">

<i class="bi bi-calendar2-check-fill text-danger"></i>

You can register for available events.

</div>

<div>

<i class="bi bi-stars text-warning"></i>

Enjoy your learning journey!

</div>

</div>

</div>

</div>

</div>

</div>

<!-- Quick Actions -->

<div class="container mt-3">

<div class="row">

<div class="col-md-4 mb-4">

<a href="<%=request.getContextPath()%>/student/events.jsp"
class="text-decoration-none">

<div class="card shadow border-0 quick-btn">

<div class="card-body text-center">

<i
class="bi bi-calendar-event-fill text-primary"
style="font-size:60px;"></i>

<h4 class="mt-3">

View Events

</h4>

<p>

Browse all available events.

</p>

</div>

</div>

</a>

</div>

<div class="col-md-4 mb-4">

<a href="<%=request.getContextPath()%>/student/myregistrations.jsp"
class="text-decoration-none">

<div class="card shadow border-0 quick-btn">

<div class="card-body text-center">

<i
class="bi bi-ticket-perforated-fill text-success"
style="font-size:60px;"></i>

<h4 class="mt-3">

My Registrations

</h4>

<p>

Check registered events.

</p>

</div>

</div>

</a>

</div>

<div class="col-md-4 mb-4">

<a
href="<%=request.getContextPath()%>/student/profile.jsp"
class="text-decoration-none">

<div class="card shadow border-0 quick-btn">

<div class="card-body text-center">

<i
class="bi bi-person-circle text-danger"
style="font-size:60px;"></i>

<h4 class="mt-3">

My Profile

</h4>

<p>

View and update profile.

</p>

</div>

</div>

</a>

</div>

</div>

</div>
<!-- Footer -->

<footer class="bg-dark text-white text-center p-4 mt-5">

<div class="container">

<h5>

<i class="bi bi-calendar-event-fill"></i>

Event Registration Management System

</h5>

<p class="mb-1">

Welcome,
<strong><%=session.getAttribute("studentName")%></strong>

</p>

<p class="mb-0">

© 2026 All Rights Reserved | Developed Using JSP, Servlets & MySQL

</p>

</div>

</footer>

<!-- Bootstrap JS -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>

window.onload = function()
{

const cards =
document.querySelectorAll(".stat-card");

cards.forEach(function(card,index)
{

card.style.opacity = "0";

card.style.transform =
"translateY(30px)";

setTimeout(function()
{

card.style.transition =
"all .6s ease";

card.style.opacity = "1";

card.style.transform =
"translateY(0px)";

},index*200);

});

};

</script>

</body>

</html>