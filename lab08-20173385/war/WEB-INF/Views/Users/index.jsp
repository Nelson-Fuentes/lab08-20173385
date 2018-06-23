<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="controllers.users.IndexController"%>
<%@ page import="models.User"%>
<%
	List<User> users = (List<User>) request.getAttribute("users");
	User log = (User) request.getAttribute("log");
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
<title>Lista de Usuarios</title>
<script src="scripts/cambioadd.js">
	
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
			<li class="user"><a href="/users/add" title="Añadir Usuario"><img
					alt="Añadir usuario" src="img/addUserBlanco.png" >
					Añadir Usuarios</a></li>
			<li class="role"><a href="/roles" title="Ver Roles"><img
					alt="Ver Roles" src="../img/indexRol1.png"> Ver Roles</a></li>
			<li class="role"><a href="/roles/add" title="Añadir Rol"><img
					alt="Añadir usuario" src="../img/addRol.png"> Añadir Roles</a></li>
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
			if (users.isEmpty()) {
		%>
		<p>No se encuentran usuarios. Añada Usuarios</p>
		<%
			} else {
		%>
		<table>
			<tr id="head">
				<td>Carné de identidad</td>
				<td>Nombres(s)</td>
				<td>Apellido(s)</td>
				<td>Rol</td>
				<td>Correo electrónico</td>
				<td>Nacimiento</td>
				<td>Género</td>
				<td>Estado</td>
				<td>Creado</td>
			</tr>
			<%
				for (User us : users) {
			%>
			<tr class="body">
				<td><a href="/users/view?id=<%=us.getId()%>"><%=us.getId()%></a></td>
				<td><%=us.getName()%></td>
				<td><%=us.getApellido()%></td>
				<td><%=us.getRol()%></td>
				<td><%=us.getCorreo()%></td>
				<td><%=us.getBirth().toString()%></td>
				<td>
					<%
						if (us.isGender()) {
					%> Masculino <%
						} else {
					%> Femenino <%
						}
					%>
				</td>
				<td><%=us.isEstatus()%></td>
				<td><%=us.getMade()%></td>
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