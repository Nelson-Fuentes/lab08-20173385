<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="controllers.roles.IndexController"%>
<%@ page import="models.Role"%>
<%@page import="models.User"%>
<%
	User log = (User) request.getAttribute("log");
%>
<%
	List<Role> roles = (List<Role>) request.getAttribute("roles");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="https://fonts.googleapis.com/css?family=Bangers"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Exo"
	rel="stylesheet">
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="estilos/users.css">
<link href="https://fonts.googleapis.com/css?family=Oswald"
	rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Lista de Roles</title>
</script>
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
					src="img/logout.png"><font color="black">Cerrar Sesion</font></a></li>
			<%
				} else {
			%>
			<li class="google"><a href="/users/login?url?=<%=url%>"
				title="Iniciar Sesion"><img alt="Iniciar Sesión"
					src="img/login.png"><font color="black">Iniciar Sesion</font></a></li>
			<li class="google"><a href="/users/register?url?=<%=url%>"
				title="Registrarse"><img alt="Registrarse"
					src="img/register.png"><font color="black">Registrarse</font></a></li>
			<%
				}
			%>
			<li class="user"><a href="/users" title="Lista de Usuario"><img
					alt="Lista de usuarios" src="../img/listUserBlanco.png" id="img">
					Ver Usuarios</a></li>
			<li class="user"><a href="/users/add" title="Añadir Usuario"><img
					alt="Añadir usuario" src="img/addUserBlanco.png" id="img">
					Añadir Usuarios</a></li>
			<li class="role"><a href="/roles/add" title="Añadir Rol"><img
					alt="Añadir rol" src="img/indexRol1.png" id="img"> Añadir Rol</a></li>
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
		<%
			if (roles.isEmpty()) {
		%>
		<p>No se encuentran roles. Añada rol</p>
		<%
			} else {
		%>
		<table>
			<tr id="head">
				<td>ID</td>
				<td>Nombre</td>
				<td>Creación</td>
				<td>Estado</td>
			</tr>
			<%
				for (Role rl : roles) {
			%>
			<tr class="body">
				<td><a href="/roles/view?id=<%=rl.getId()%>"><%=rl.getId()%></a></td>
				<td><%=rl.getName()%></td>
				<td><%=rl.getCreated()%></td>
				<td><%=rl.isStatus()%></td>
			</tr>
			<%
				}
			%>
		</table>
		<%
			}
		%>
	</div>
</body>
</html>