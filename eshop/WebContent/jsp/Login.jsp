<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
<style>
	#acceso {
		position: relative;
		margin: 0 auto;
		width: 300px;
		height:300px;
		text-align: center;
	}
	
	#user {
		margin-left: 20px;
	}
</style>
</head>
<body>
<h1 align="center">Login</h1>
	<div id="acceso">

		<form action="" method="POST">
			<input type="hidden" name="action" value="log" />
			Usuario: <input type="text" id="user" name="user" /><br><br/>
			Contraseña: <input type="password" name="psw" /><br><br/>
			<input type="submit" value="Loguear" /><br>
		</form>

	</div>
</body>
</html>