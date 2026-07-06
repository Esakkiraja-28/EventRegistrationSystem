<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Student Profile</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<style>

.profile-img{

width:180px;
height:180px;

border-radius:50%;

object-fit:cover;

border:5px solid #198754;

box-shadow:0 5px 15px rgba(0,0,0,.2);

}

</style>

</head>

<body class="bg-light">

<div class="container mt-5">
    <%
String message =
(String)session.getAttribute("message");

if(message != null)
{
%>

<div class="alert alert-info">

<%=message%>

</div>

<%
session.removeAttribute("message");
}
%>

<div class="card shadow">

<div class="card-body">

<h2 class="text-center mb-4">

Student Profile

</h2>

<hr>

<div class="text-center mb-4">

<img
src="<%=request.getContextPath()%>/images/<%=session.getAttribute("studentPhoto")%>"
class="profile-img">

</div>

<p>

<strong>Name :</strong>

<%=session.getAttribute("studentName")%>

</p>

<p>

<strong>Email :</strong>

<%=session.getAttribute("studentEmail")%>

</p>

<p>

<strong>Department :</strong>

<%=session.getAttribute("studentDepartment")%>

</p>

<p>

<strong>Year :</strong>

<%=session.getAttribute("studentYear")%>

</p>

<hr>

<form
action="<%=request.getContextPath()%>/UploadPhotoServlet"
method="post"
enctype="multipart/form-data">

<label class="form-label">

Choose Profile Photo

</label>

<input
type="file"
name="photo"
class="form-control"
accept="image/*"
required>

<div class="mt-3">

<button
type="submit"
class="btn btn-success">

Upload Photo

</button>

<a
href="<%=request.getContextPath()%>/StudentDashboardServlet"
class="btn btn-primary">

Back

</a>

</div>

</form>

</div>

</div>

</div>

</body>

</html>