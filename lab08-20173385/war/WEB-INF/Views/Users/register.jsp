
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="models.Role"%>
<%@page import="models.User"%>
<%
	Date date = (Date) request.getAttribute("date");
%>
<%
	List<Role> roles = (List<Role>) request.getAttribute("roles");
	User log = (User) request.getAttribute("log");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Oswald"
	rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Añadir usuario</title>
<link rel="stylesheet" type="text/css" href="../estilos/users.css">
<script src="../scripts/cambiarlist.js"></script>
<link href="https://fonts.googleapis.com/css?family=Bangers"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Exo"
	rel="stylesheet">
</head>
<body>
	<div id="menu">
		<ul>
			<%
				boolean islogged = ((Boolean) request.getAttribute("isLogged")).booleanValue();
				//		String url = (String) request.getAttribute("url");
				if (islogged) {
			%>
			<li class="google"><a href="/users/logout" title="Cerrar Sesion"><img
					alt="Cerrar Sesión" src="../img/logout.png"><font
					color="black">Cerrar Sesion</font></a></li>
			<%
				} else {
			%>
			<li class="google"><a href="/users/login"
				title="Iniciar Sesion"><img alt="Iniciar Sesión"
					src="../img/login.png"><font color="black">Iniciar
						Sesion</font></a></li>
			<li class="google"><a href="/users/register" title="Registrarse"><img
					alt="Registrarse" src="../img/register.png"><font
					color="black">Registrarse</font></a></li>
			<%
				}
			%>
			<li class="user"><a href="/users" title="Lista de Usuario"><img
					alt="Lista de usuarios" src="../img/listUserBlanco.png" id="img">
					Ver Usuarios</a></li>
			<li class="user"><a href="/users/add" title="Añadir Usuario"><img
					alt="Añadir usuario" src="../img/addUserBlanco.png" id="img">
					Añadir Usuario</a></li>
			<li class="role"><a href="/roles" title="Ver Roles"><img
					alt="Ver Roles" src="../img/indexRol1.png" id="img"> Ver
					Roles</a></li>
			<li class="role"><a href="/roles/add" title="Añadir Rol"><img
					alt="Añadir usuario" src="../img/addRol.png" id="img"> Añadir
					Roles</a></li>
			<li class="rsr"><a href="/resources" title="Ver Resources"><img
					alt="Ver Resources" src="../img/resource.png" id="img"> Ver
					Resources</a></li>
			<li class="rsr"><a href="/resources/add" title="Añadir Rol"><img
					alt="Añadir usuario" src="../img/addResource.png" id="img">
					Añadir Resource</a></li>
			<li class="access"><a href="/access" title="Ver accesos"><img
					alt="Ver Accesos" src="../img/access.png" id="img"> Ver
					Accesos</a></li>
			<li class="access"><a href="/access/add" title="Añadir Acceso"><img
					alt="Añadir Acceso" src="../img/addAccess.png" id="img">
					Añadir Access</a></li>
		</ul>
	</div>
	<div id="table">
		<form action="/users/register" method="post">
			<h1>Registrar Usuario</h1>
			<input type="text" name="name" placeholder="Ingrese su nombre"
				required> <br> <br> <br> <input type="text"
				name="apellido" placeholder="Ingrese su apellido" required>
			<br> <br> <br> <input type="hidden" name="email"
				placeholder="Ingrese su correo electronico" required
				value="<%=request.getParameter("email")%>"> <label>Ingrese
				su fecha de Nacimiento</label><br>
			<%
				date = new Date(date.getTime() - 86400000);
				String res = "" + (1900 + date.getYear()) + "-";
				if (date.getMonth() < 10)
					res = res + "0";
				res = res + (date.getMonth() + 1) + "-";
				if (date.getDate() < 10)
					res = res + "0";
				res = res + date.getDate();
			%>
			<br> <input type="date" name="date" min="1000-01-01"
				max="<%=res%>" placeholder="Ingrese su fecha de Nacimiento" required>
			<br> <br> <br> <input type="radio" name="gender"
				id="hombre" value="true" checked> <label for="hombre">Masculino</label>
			<input type="radio" name="gender" id="mujer" value="false"> <label
				for="mujer">Femenino</label><br> <label>Seleccione su
				rol: </label> <select name="role">
				<%
					for (Role rl : roles) {
						if (!(rl.getName().equalsIgnoreCase("Invitado"))){
				%>
				<option value="<%=rl.getId()%>"><%=rl.getName()%></option>
				<%
					}}
				%>
			</select> <br> <input type="submit" value="Registrar">
		</form>
	</div>
</body>
</html>