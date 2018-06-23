<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="models.User"%>
<%
	User user = (User) request.getAttribute("user");
	User log = (User) request.getAttribute("log");
%>
<%
	String str = (String) request.getAttribute("url");
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
<title>Usuario: <%=user.getId()%></title>
<link rel="stylesheet" type="text/css" href="../estilos/users.css">
<!--  	<script type="text/javascript">
		$(document).ready(function(){
			$('#del').click(function(){
				$.post('/users/delete', {
			        id :<%=user.getId()%>;
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
			<li class="user"><a href="/users/edit?id=<%=user.getId()%>"><img
					src="../img/editUser.png" width:="200px">Editar Usuario</a></li>
			<li id="gog" class="user">
				<form action="/users/delete" method="post">
					<input type="hidden" value="<%=user.getId()%>" name="id">
					<input type="image" src="../img/deleteUserBlanco.png"
						heigth="200px"> <input type="submit"
						value="Borrar Usuario" heigth="200px">
				</form>
			</li>
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
					Accesos</a></li>>
			<li class="access"><a href="/access/add" title="Añadir Acceso"><img
					alt="Añadir Acceso" src="../img/addAccess.png" id="img">
					Añadir Access</a></li>
		</ul>
	</div>
	<div id="table">
		<h1 id="id" name="<%=user.getId()%>">Perfil de Usuario:</h1>
		<table>
			<tr>
				<td>ID de usuario</td>
				<td><%=user.getId()%></td>
			</tr>
			<tr>
				<td>Nombre</td>
				<td><%=user.getApellido() + ", " + user.getName()%></td>
			</tr>
			<tr>
				<td>Rol</td>
				<td><%=user.getRol()%></td>
			</tr>
			<tr>
				<td>Email</td>
				<td><%=user.getCorreo()%></td>
			</tr>
			<tr>
				<td>Nacimiento</td>
				<td><%=user.getBirth()%></td>
			</tr>
			<tr>
				<td>Creado</td>
				<td><%=user.getMade()%></td>
			</tr>
			<tr>
				<td>Estado</td>
				<td><%=user.isEstatus()%></td>
			</tr>
			<tr>
				<td>Genero</td>
				<td>
					<%
						if (user.isGender()) {
					%> Masculino <%
						} else {
					%> Femenino <%
						}
					%>
				</td>
			</tr>
		</table>

	</div>
</body>
</html>