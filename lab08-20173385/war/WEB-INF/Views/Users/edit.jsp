<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="models.User"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="models.Role"%>
<%
	List<Role> roles = (List<Role>) request.getAttribute("roles");
%>
<%
	User log = (User) request.getAttribute("log");
	User user = (User) request.getAttribute("user");
%>
<%
	Date ayer = (Date) request.getAttribute("date");
%>
<%
	ayer = new Date(ayer.getTime() - 86400000);
	String yester = "" + (1900 + ayer.getYear()) + "-";
	if (ayer.getMonth() < 10)
		yester = yester + "0";
	yester = yester + (ayer.getMonth() + 1) + "-";
	if (ayer.getDate() < 10)
		yester = yester + "0";
	yester = yester + ayer.getDate();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Oswald"
	rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Editar Usuario: <%=user.getId()%></title>
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
				String url = (String) request.getAttribute("url");
				if (islogged) {
			%>
			<li class="google"><a href="/users/logout?url?=<%=url%>"
				title="Cerrar Sesion"><img alt="Cerrar Sesión"
					src="../img/logout.png"><font color="black">Cerrar Sesion</font></a></li>
			<%
				} else {
			%>
			<li class="google"><a href="/users/login?url?=<%=url%>"
				title="Iniciar Sesion"><img alt="Iniciar Sesión"
					src="../img/login.png"><font color="black">Iniciar Sesion</font></a></li>
			<li class="google"><a href="/users/register?url?=<%=url%>"
				title="Registrarse"><img alt="Registrarse"
					src="../img/register.png"><font color="black">Registrarse</font></a></li>
			<%
				}
			%>
			<li class="user"><a href="/users" title="Lista de Usuario"><img
					alt="Lista de usuarios" src="../img/listUserBlanco.png" id="img">
					Ver Usuarios</a></li>
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
		<form action="/users/edit" method="post">
			<h1>Editar Usuario</h1>
			<label>Edite sus Nombres y Apellidos</label> <input type="text"
				name="name" value="<%=user.getName()%>" required> <br>
			<br> <br> <input type="text" name="apellido"
				value="<%=user.getApellido()%>" required> <br> <br>
			<br> <label>Edite su fecha de Nacimiento</label>
			<%
				Date date = user.getBirth();
				String res = "" + (1900 + date.getYear()) + "-";
				if (date.getMonth() < 10)
					res = res + "0";
				res = res + (date.getMonth() + 1) + "-";
				if (date.getDate() < 10)
					res = res + "0";
				res = res + date.getDate();
				String hc = "", mc = "";
				if (user.isGender())
					hc = "checked";
				else
					mc = "checked";
			%>
			<input type="hidden" name="id" value="<%=user.getId()%>"><br>
			<br> <input type="date" name="date" min="1000-01-01"
				placeholder="Ingrese su fecha de Nacimiento" required
				max="<%=yester%>" value="<%=res%>"> <br> <br> <br>
			<input type="radio" name="gender" id="hombre" value="true" <%=hc%>>
			<label for="hombre">Masculino</label> <input type="radio"
				name="gender" id="mujer" value="false" <%=mc%>> <label
				for="mujer">Femenino</label>><br> <br> <label>Seleccione
				su rol: </label> <select name="role">
				<%
					for (Role rl : roles) {
						String se = "";
						if (rl.getId() == user.getIdRol()) {
							se = "selected";
						}
				%>
				<option value="<%=rl.getId()%>" <%=se%>><%=rl.getName()%></option>
				<%
					}
				%>
			</select> <input type="submit" value="Editar">
		</form>
	</div>
</body>
</html>