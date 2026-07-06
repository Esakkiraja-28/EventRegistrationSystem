<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<title>Create Event</title>

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link
rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

</head>

<body class="bg-light">

<div class="container mt-5">

<div class="card shadow">

<div class="card-body">

<div class="d-flex justify-content-between align-items-center mb-4">

<h2 class="mb-0">

Create New Event

</h2>

<a
href="<%=request.getContextPath()%>/AdminDashboardServlet"
class="btn btn-secondary">

<i class="bi bi-arrow-left"></i>

Back to Dashboard

</a>

</div>

<form
action="../CreateEventServlet"
method="post">

<div class="mb-3">

<label>

Event Name

</label>

<input
type="text"
name="eventName"
class="form-control"
required>

</div>

<div class="mb-3">

<label>

Event Date

</label>

<input
type="date"
name="eventDate"
class="form-control"
required>

</div>

<div class="mb-3">

<label>

Venue

</label>

<input
type="text"
name="venue"
class="form-control"
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
required>

</div>

<div class="mb-3">

<label>

Description

</label>

<textarea
name="description"
class="form-control"
rows="4"
required></textarea>

</div>

<button
type="submit"
class="btn btn-success">

Create Event

</button>

</form>

</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>