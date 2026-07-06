<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Verify OTP</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

<div class="row justify-content-center">

<div class="col-md-5">

<div class="card shadow">

<div class="card-header bg-success text-white">

<h3>Verify OTP</h3>

</div>

<div class="card-body">

<form action="VerifyOTPServlet" method="post">

<label>Enter OTP</label>

<input
type="text"
name="otp"
class="form-control"
maxlength="6"
required>

<br>

<button
type="submit"
class="btn btn-success w-100">

Verify OTP

</button>

</form>

</div>

</div>

</div>

</div>

</div>

</body>

</html>