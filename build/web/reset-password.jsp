<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>Reset Password</title>

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link
rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

</head>

<body class="bg-light">

<div class="container mt-5">

<div class="row justify-content-center">

<div class="col-md-5">

<div class="card shadow">

<div class="card-header bg-success text-white">

<h3>

<i class="bi bi-key-fill"></i>

Reset Password

</h3>

</div>

<div class="card-body">

<form action="ResetPasswordServlet"
method="post">

<div class="mb-3">

<label class="form-label">

New Password

</label>

<input
type="password"
id="newPassword"
name="newPassword"
class="form-control"
placeholder="Enter New Password"
required>

</div>
<div id="strengthMessage"
class="mt-2 fw-bold">

Password Strength :

</div>
<div class="mb-3">

<label class="form-label">

Confirm Password

</label>

<input
type="password"
id="confirmPassword"
name="confirmPassword"
class="form-control"
placeholder="Confirm New Password"
required>

</div>
    <div id="matchMessage"
class="mt-2 fw-bold">

</div>
<div class="form-check mt-2">

<input
class="form-check-input"
type="checkbox"
id="showPassword">

<label
class="form-check-label"
for="showPassword">

Show Password

</label>

</div>
<button
type="submit"
id="resetBtn"
class="btn btn-success w-100"
disabled>

<i class="bi bi-check-circle-fill"></i>

Reset Password

</button>

</form>

</div>

</div>

</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>

const password =
document.getElementById("newPassword");

const confirmPassword =
document.getElementById("confirmPassword");

const strengthMessage =
document.getElementById("strengthMessage");

const matchMessage =
document.getElementById("matchMessage");

const resetBtn =
document.getElementById("resetBtn");

const showPassword =
document.getElementById("showPassword");

// -------------------------
// Show / Hide Password
// -------------------------

showPassword.addEventListener("change",function(){

if(this.checked)
{
    password.type="text";
    confirmPassword.type="text";
}
else
{
    password.type="password";
    confirmPassword.type="password";
}

});

// -------------------------
// Check Password Strength
// -------------------------

function checkPassword()
{

let pass =
password.value;

let strength =
0;

if(pass.length >= 8)
strength++;

if(/[A-Z]/.test(pass))
strength++;

if(/[a-z]/.test(pass))
strength++;

if(/[0-9]/.test(pass))
strength++;

if(/[^A-Za-z0-9]/.test(pass))
strength++;

if(strength <=2)
{

strengthMessage.innerHTML =
"<span class='text-danger'>🔴 Weak Password</span>";

}
else if(strength==3 || strength==4)
{

strengthMessage.innerHTML =
"<span class='text-warning'>🟡 Medium Password</span>";

}
else
{

strengthMessage.innerHTML =
"<span class='text-success'>🟢 Strong Password</span>";

}

checkMatch();

}

// -------------------------
// Password Match
// -------------------------

function checkMatch()
{

if(confirmPassword.value=="")
{

matchMessage.innerHTML="";
resetBtn.disabled=true;
return;

}

if(password.value==confirmPassword.value)
{

matchMessage.innerHTML=
"<span class='text-success'>✔ Passwords Match</span>";

}
else
{

matchMessage.innerHTML=
"<span class='text-danger'>✘ Passwords Do Not Match</span>";

}

// Enable button only if password is strong and matches

let strong =
strengthMessage.innerHTML.includes("Strong");

let match =
password.value==confirmPassword.value;

resetBtn.disabled=!(strong && match);

}

password.addEventListener("keyup",checkPassword);

confirmPassword.addEventListener("keyup",checkMatch);

</script>
</body>

</html>