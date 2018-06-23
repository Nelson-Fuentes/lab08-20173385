<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="controllers.resources.IndexController"%>
<%@ page import="models.Resource"%>
<%@page import="models.User"%>
<%
	User log = (User) request.getAttribute("log");
%>
<%
	List<Resource> resources = (List<Resource>) request.getAttribute("resource");
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
<title>Lista de Resources</title>
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
				title="Cerrar Sesion"><img alt="Cerrar Sesi�n"
					src="img/logout.png"><font color="black">Cerrar Sesion</font></a></li>
			<%
				} else {
			%>
			<li class="google"><a href="/users/login?url?=<%=url%>"
				title="Iniciar Sesion"><img alt="Iniciar Sesi�n"
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
			<li class="user"><a href="/users/add" title="A�adir Usuario"><img
					alt="A�adir usuario" src="img/addUserBlanco.png" id="img">
					A�adir Usuarios</a></li>
			<li class="role"><a href="/roles" title="Ver Roles"><img
					alt="Ver Roles" src="../img/indexRol1.png" id="img"> Ver
					Roles</a></li>
			<li class="role"><a href="/roles/add" title="A�adir Rol"><img
					alt="A�adir usuario" src="../img/addRol.png" id="img"> A�adir
					Roles</a></li>
			<li class="rsr"><a href="/resources/add" title="A�adir Rol"><img
					alt="A�adir usuario" src="../img/addResource.png" id="img">
					A�adir Resource</a></li>
			<li class="access"><a href="/access" title="Ver accesos"><img
					alt="Ver Accesos" src="../img/access.png" id="img"> Ver
					Accesos</a></li>
			<li class="access"><a href="/access/add" title="A�adir Acceso"><img
					alt="A�adir Acceso" src="../img/addAccess.png" id="img">
					A�adir Access</a></li>
		</ul>
	</div>
	<div id="table">
		<%
			if (resources.isEmpty()) {
		%>
		<p>No se encuentran Resources. A�ada Resources</p>
		<%
			} else {
		%>
		<table>
			<tr id="head">
				<td>ID</td>
				<td>URL</td>
				<td>Status</td>
				<td>Made</td>
			</tr>
			<%
				for (Resource us : resources) {
			%>
			<tr class="body">
				<td><a href="/resources/view?id=<%=us.getId()%>"><%=us.getId()%></a></td>
				<td><%=us.getUrl()%></td>
				<td><%=us.isStatus()%></td>
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