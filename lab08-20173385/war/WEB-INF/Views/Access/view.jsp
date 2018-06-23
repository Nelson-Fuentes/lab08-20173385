<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="models.Access"%>
<%@page import="models.User"%>
<%
	User log = (User) request.getAttribute("log");
%>
<%
	Access access = (Access) request.getAttribute("access");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Oswald"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Bangers"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Exo"
	rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Acceso: <%=access.getId()%></title>
<link rel="stylesheet" type="text/css" href="../estilos/users.css">
<!--  	<script type="text/javascript">
		$(document).ready(function(){
			$('#del').click(function(){
				$.post('/users/delete', {
			        id :<%=access.getId()%>;
			      }, function(response) {});
			});
		});
		</script>-->
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
			<li class="user"><a href="/users" title="Añadir Usuario"><img
					alt="Lista de usuarios" src="../img/listUserBlanco.png" id="img">
					Ver otros Usuarios</a></li>
			<li class="user"><a href="/users/add" title="Añadir Usuario"><img
					alt="Añadir usuario" src="../img/addUserBlanco.png" id="img">
					Añadir Usuarios</a></li>
			<li class="role"><a href="/roles" title="Ver Roles"><img
					alt="Añadir usuario" src="../img/indexRol1.png" id="img"> Ver
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
			<li class="access"><a
				href="/access/edit?id=<%=access.getId()%>"><img
					src="../img/editAccess.png" width:="200px">Editar Acceso</a></li>
			<li class="access" id="gog">
				<form action="/access/delete" method="post">
					<input type="hidden" value="<%=access.getId()%>" name="id">
					<input type="image" src="../img/deleteAccess.png" heigth="200px">
					<input type="submit" value="Borrar Acceso" heigth="200px">
				</form>
			</li>
		</ul>
	</div>
	<div id="table">
		<h1 id="id" name="<%=access.getId()%>">Datos del Accesso:</h1>
		<table>
			<tr>
				<td>ID</td>
				<td><%=access.getId()%></td>
			</tr>
			<tr>
				<td>Role</td>
				<td><a href="/roles/view?id=<%=access.getIdRole()%>"><%=access.getRol()%></a></td>
			</tr>
			<tr>
				<td>Resource</td>
				<td><a href="/resources/view?id=<%=access.getIdResource()%>"><%=access.getResource()%></a></td>
			</tr>
			<tr>
				<td>Estado</td>
				<td><%=access.isStatus()%></td>
			</tr>
			<tr>
				<td>Creado</td>
				<td><%=access.getMade()%></td>
			</tr>
		</table>
		<p>
			<b>Importante</b> Si se borra un acceso el rol afectado no podra
			afectuar la funcion eliminada hasta que se cree otro acceso para eso
		</p>
	</div>
</body>
</html>