<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Event Registration System</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

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
    linear-gradient(rgba(0,0,0,.45),rgba(0,0,0,.45)),
    url("<%=request.getContextPath()%>/images/login-bg.png");

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

    box-shadow:0 20px 45px rgba(0,0,0,.35);

}

.form-control,
.form-select{

    height:48px;
    border-radius:10px;

}

.btn-primary{

    height:48px;
    border-radius:10px;
    font-weight:bold;

}

h2{

    font-weight:bold;

}

</style>

</head>

<body>

<div class="container">

<div class="row justify-content-center">

<div class="col-lg-5 col-md-7">

<div class="card">

<div class="card-body p-4">

<h2 class="text-center mb-4">

Event Registration System

</h2>

<form action="LoginServlet" method="post">

<div class="mb-3">

<label class="form-label">

Email

</label>

<input
type="text"
name="email"
class="form-control"
placeholder="Enter Email (Student) or Username (Admin)"
required>

</div>

<div class="mb-3">

<label class="form-label">

Password

</label>

<input
type="password"
name="password"
class="form-control"
placeholder="Enter Password"
required>

</div>

<div class="mb-3">

<label class="form-label">

Role

</label>

<select
name="role"
class="form-select"
required>

<option value="">Select Role</option>

<option value="student">Student</option>

<option value="admin">Admin</option>

</select>

</div>

<button
type="submit"
class="btn btn-primary w-100">

Login

</button>

</form>

<div class="text-center mt-4">

<a href="register.jsp">

New Student? Register Here

</a>

<br><br>

<a
href="forgot-password.jsp"
class="text-danger">

Forgot Password?

</a>

</div>

</div>

</div>

</div>

</div>

</div>

</body>

</html>