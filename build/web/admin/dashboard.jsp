<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>

<%
Integer totalStudents =
(Integer)request.getAttribute("totalStudents");

Integer totalEvents =
(Integer)request.getAttribute("totalEvents");

Integer totalRegistrations =
(Integer)request.getAttribute("totalRegistrations");

if(totalStudents==null)
totalStudents=0;

if(totalEvents==null)
totalEvents=0;

if(totalRegistrations==null)
totalRegistrations=0;
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1">

<title>Admin Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>

body{

background:#f4f6f9;

padding-top:85px;

}

.navbar{

background:rgba(25,135,84,.95);

backdrop-filter:blur(12px);

-webkit-backdrop-filter:blur(12px);

position:fixed;

top:0;

left:0;

width:100%;

z-index:9999;

padding:12px 0;

transition:all .35s ease;

box-shadow:0 8px 25px rgba(0,0,0,.15);

}
.navbar .btn{

border-radius:12px;

padding:8px 18px;

font-weight:600;

transition:all .3s ease;

border:none;

}

.navbar .btn:hover{

transform:translateY(-3px);

box-shadow:0 10px 25px rgba(0,0,0,.25);

}
.navbar-brand{

font-size:1.45rem;

font-weight:700;

letter-spacing:.5px;

}

.navbar-brand i{

margin-right:6px;

}

.navbar-toggler{

border:none;

}

.navbar-toggler:focus{

box-shadow:none;

}
.banner{

background:linear-gradient(90deg,#0d6efd,#6610f2);

color:white;

padding:35px;

border-radius:15px;

margin-top:20px;

box-shadow:0px 8px 20px rgba(0,0,0,.15);

}

.card-box{

border:none;

border-radius:15px;

transition:.3s;

color:white;

}

.card-box:hover{

transform:translateY(-8px);

}

.profile-card{

border:none;

border-radius:15px;

}

.profile-img{

width:130px;

height:130px;

border-radius:50%;

object-fit:cover;

border:5px solid #198754;

}

</style>

</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-success shadow fixed-top">

<div class="container">

<a
class="navbar-brand fw-bold"
href="<%=request.getContextPath()%>/AdminDashboardServlet">

<i class="bi bi-calendar-event-fill"></i>

Event Registration System

</a>

<button
class="navbar-toggler"
type="button"
data-bs-toggle="collapse"
data-bs-target="#adminNavbar">

<span class="navbar-toggler-icon"></span>

</button>

<div
class="collapse navbar-collapse"
id="adminNavbar">

<div class="ms-auto">

<a
href="<%=request.getContextPath()%>/admin/create-event.jsp"
class="btn btn-light me-2 mb-2 mb-lg-0">

Create Event

</a>

<a
href="<%=request.getContextPath()%>/admin/event-list.jsp"
class="btn btn-light me-2 mb-2 mb-lg-0">

Event List

</a>

<a
href="<%=request.getContextPath()%>/admin/registrations.jsp"
class="btn btn-light me-2 mb-2 mb-lg-0">

Registrations

</a>

<a
href="<%=request.getContextPath()%>/admin/users.jsp"
class="btn btn-light me-2 mb-2 mb-lg-0">

Users

</a>

<a
href="<%=request.getContextPath()%>/admin/profile.jsp"
class="btn btn-warning me-2 mb-2 mb-lg-0">

Profile

</a>

<a
href="<%=request.getContextPath()%>/LogoutServlet"
class="btn btn-danger mb-2 mb-lg-0">

Logout

</a>

</div>

</div>

</div>

</nav>

<div class="container">

<div class="banner">

<h2>

Welcome

<%=session.getAttribute("adminName")%>

👋

</h2>

<p>

Manage Events, Students and Registrations Easily.

</p>

</div>

<div class="row mt-4">

<div class="col-lg-4">

<div class="card profile-card shadow">

<div class="card-body text-center">

<img
src="<%=request.getContextPath()%>/images/<%=session.getAttribute("adminPhoto")%>"
class="profile-img">

<h3 class="mt-3">

<%=session.getAttribute("adminName")%>

</h3>

<p>

<%=session.getAttribute("adminEmail")%>

</p>

<span class="badge bg-success">

Administrator

</span>

</div>

</div>

</div>

<div class="col-lg-8">

<div class="row">

<div class="col-md-6 mb-3">

<div class="card card-box bg-primary shadow">

<div class="card-body">

<h5>

<i class="bi bi-people-fill"></i>

Total Students

</h5>

<h1>

<%=totalStudents%>

</h1>

</div>

</div>

</div>

<div class="col-md-6 mb-3">

<div class="card card-box bg-success shadow">

<div class="card-body">

<h5>

<i class="bi bi-calendar-event-fill"></i>

Total Events

</h5>

<h1>

<%=totalEvents%>

</h1>

</div>

</div>

</div>

<div class="col-md-6 mb-3">

<div class="card card-box bg-warning shadow">

<div class="card-body">

<h5>

<i class="bi bi-journal-check"></i>

Registrations

</h5>

<h1>

<%=totalRegistrations%>

</h1>

</div>

</div>

</div>

<div class="col-md-6 mb-3">

<div class="card card-box bg-danger shadow">

<div class="card-body">

<h5>

<i class="bi bi-award-fill"></i>

System Status

</h5>

<h3>

ONLINE

</h3>

</div>

</div>

</div>

</div>

</div>

</div>
<!-- Latest Students -->

<div class="row mt-4">

<div class="col-lg-6 mb-4">

<div class="card shadow border-0">

<div class="card-header bg-primary text-white">

<h4>

<i class="bi bi-people-fill"></i>

Latest Students

</h4>

</div>

<div class="card-body">

<table class="table table-hover">

<thead>

<tr>

<th>Name</th>

<th>Email</th>

</tr>

</thead>

<tbody>

<%

ArrayList<String[]> latestStudents =
(ArrayList<String[]>)request.getAttribute("latestStudents");

if(latestStudents!=null && !latestStudents.isEmpty())
{

for(String s[] : latestStudents)
{

%>

<tr>

<td>

<%=s[0]%>

</td>

<td>

<%=s[1]%>

</td>

</tr>

<%

}

}
else
{

%>

<tr>

<td colspan="2" class="text-center">

No Students Found

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

<!-- Latest Events -->

<div class="col-lg-6 mb-4">

<div class="card shadow border-0">

<div class="card-header bg-success text-white">

<h4>

<i class="bi bi-calendar-event-fill"></i>

Latest Events

</h4>

</div>

<div class="card-body">

<table class="table table-hover">

<thead>

<tr>

<th>Event</th>

<th>Date</th>

</tr>

</thead>

<tbody>

<%

ArrayList<String[]> latestEvents =
(ArrayList<String[]>)request.getAttribute("latestEvents");

if(latestEvents!=null && !latestEvents.isEmpty())
{

for(String e[] : latestEvents)
{

%>

<tr>

<td>

<%=e[0]%>

</td>

<td>

<%=e[1]%>

</td>

</tr>

<%

}

}
else
{

%>

<tr>

<td colspan="2" class="text-center">

No Events Found

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

</div>

<!-- Quick Actions -->

<div class="row">

<div class="col-md-3 mb-3">

<a href="<%=request.getContextPath()%>/admin/create-event.jsp"
class="text-decoration-none">

<div class="card shadow text-center p-4">

<i class="bi bi-calendar-plus display-4 text-success"></i>

<h5 class="mt-3">

Create Event

</h5>

</div>

</a>

</div>

<div class="col-md-3 mb-3">

<a href="<%=request.getContextPath()%>/admin/event-list.jsp"
class="text-decoration-none">

<div class="card shadow text-center p-4">

<i class="bi bi-card-list display-4 text-primary"></i>

<h5 class="mt-3">

Event List

</h5>

</div>

</a>

</div>

<div class="col-md-3 mb-3">

<a href="<%=request.getContextPath()%>/admin/registrations.jsp"
class="text-decoration-none">
<div class="card shadow text-center p-4">

<i class="bi bi-journal-check display-4 text-warning"></i>

<h5 class="mt-3">

Registrations

</h5>

</div>

</a>

</div>

<div class="col-md-3 mb-3">

<a href="<%=request.getContextPath()%>/admin/users.jsp"
class="text-decoration-none">

<div class="card shadow text-center p-4">

<i class="bi bi-people display-4 text-danger"></i>

<h5 class="mt-3">

Users

</h5>

</div>

</a>

</div>

</div>
<!-- Recent Activity -->

<div class="row mt-4">

<div class="col-lg-8">

<div class="card shadow border-0">

<div class="card-header bg-dark text-white">

<h4>

<i class="bi bi-bell-fill"></i>

Recent Activity

</h4>

</div>

<div class="card-body">

<div class="alert alert-success">

<i class="bi bi-person-check-fill"></i>

Administrator logged in successfully.

</div>

<div class="alert alert-primary">

<i class="bi bi-calendar-event-fill"></i>

Manage all events from the Event List.

</div>

<div class="alert alert-warning">

<i class="bi bi-journal-check"></i>

Review new student registrations.

</div>

<div class="alert alert-info">

<i class="bi bi-graph-up-arrow"></i>

Dashboard statistics are loaded from the database.

</div>

</div>

</div>

</div>

<div class="col-lg-4">

<div class="card shadow border-0">

<div class="card-header bg-danger text-white">

<h4>

<i class="bi bi-lightning-charge-fill"></i>

System Information

</h4>

</div>

<div class="card-body">

<p>

<strong>Administrator</strong>

</p>

<p>

<%=session.getAttribute("adminName")%>

</p>

<hr>

<p>

<strong>Email</strong>

</p>

<p>

<%=session.getAttribute("adminEmail")%>

</p>

<hr>

<p>

<strong>Role</strong>

</p>

<span class="badge bg-success">

Administrator

</span>

<hr>

<p>

<strong>Status</strong>

</p>

<span class="badge bg-primary">

Online

</span>

</div>

</div>

</div>

</div>

<footer class="bg-dark text-white mt-5 p-4">

<div class="container text-center">

<h5>

<i class="bi bi-calendar-event-fill"></i>

Event Registration System

</h5>

<p>

Administrator Dashboard

</p>

<p>

© 2026 All Rights Reserved

</p>

</div>

</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>

window.onload=function(){

const cards=document.querySelectorAll(".card-box");

cards.forEach(function(card,index){

card.style.opacity="0";

card.style.transform="translateY(30px)";

setTimeout(function(){

card.style.transition="0.6s";

card.style.opacity="1";

card.style.transform="translateY(0px)";

},index*200);

});

};

</script>
<script>

window.addEventListener("scroll",function(){

const nav=document.querySelector(".navbar");

if(window.scrollY>20){

nav.style.padding="8px 0";

nav.style.boxShadow="0 12px 30px rgba(0,0,0,.22)";

}

else{

nav.style.padding="12px 0";

nav.style.boxShadow="0 8px 25px rgba(0,0,0,.15)";

}

});

</script>
</body>

</html>