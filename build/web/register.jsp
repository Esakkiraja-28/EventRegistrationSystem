<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Student Registration</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}
body{

    min-height:100vh;

    display:flex;
    justify-content:center;
    align-items:center;

    font-family:Arial,sans-serif;

    background-image:
    linear-gradient(rgba(255,255,255,.25),rgba(255,255,255,.25)),
    url("<%=request.getContextPath()%>/images/register-bg.png");

    background-size:cover;

    background-position:center;

    background-repeat:no-repeat;

    background-attachment:fixed;

}

.card{

    background:rgba(255,255,255,.94);

    backdrop-filter:blur(12px);

    border:none;

    border-radius:20px;

    box-shadow:0 20px 45px rgba(0,0,0,.30);

}

.form-control{

    height:48px;

    border-radius:10px;

}

.btn-success{

    height:48px;

    border-radius:10px;

    font-weight:bold;

}

.btn-secondary{

    border-radius:10px;

}

h2{

    font-weight:bold;

}

</style>

</head>

<body>

<div class="container">

<div class="row justify-content-center">

<div class="col-lg-6 col-md-8">

<div class="card">

<div class="card-body p-4">

<h2 class="text-center mb-4">

Student Registration

</h2>

<form action="<%=request.getContextPath()%>/RegisterServlet" method="post">

<div class="mb-3">

<label class="form-label">
Name
</label>
<input
type="text"
name="name"
class="form-control"
placeholder="Enter Full Name"
required>
</div>
<div class="mb-3">
<label class="form-label">
Emailz
</label>
<input
type="email"
name="email"
class="form-control"
placeholder="Enter Email Address"
required>

</div>

<div class="mb-3">

<label class="form-label">

Department

</label>

<input
type="text"
name="department"
class="form-control"
placeholder="Enter Department"
required>

</div>

<div class="mb-3">

<label class="form-label">

Year

</label>

<input
type="text"
name="year"
class="form-control"
placeholder="Enter Year"
required>

</div>

<div class="mb-4">

<label class="form-label">

Password

</label>

<input
type="password"
name="password"
class="form-control"
placeholder="Create Password"
required>

</div>

<div class="d-grid mb-3">

<button
type="submit"
class="btn btn-success">

Register

</button>

</div>

<div class="text-center">

<a
href="index.jsp"
class="btn btn-secondary">

Back To Login

</a>

</div>

</form>

</div>

</div>

</div>

</div>

</div>

</body>

</html>