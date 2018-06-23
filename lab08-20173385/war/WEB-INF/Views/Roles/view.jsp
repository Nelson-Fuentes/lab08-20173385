<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="models.Role"%>
<%@page import="models.Access"%>
<%@page import="java.util.List"%>
<%@page import="models.User"%>
<%
	User log = (User) request.getAttribute("log");
%>
<%
	Role role = (Role) request.getAttribute("role");
%>
<%
	List<Access> access = (List<Access>) request.getAttribute("acc");
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
<title>Rol: <%=role.getId()%></title>
<link rel="stylesheet" type="text/css" href="../estilos/users.css">
<!--  	<script type="text/javascript">
		$(document).ready(function(){
			$('#del').click(function(){
				$.post('/users/delete', {
			        id :<%=role.getId()%>;
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
			<li class="role"><a href="/roles/edit?id=<%=role.getId()%>"><img
					src="../img/editRole.png" width:="200px">Editar Role</a></li>
			<li class="role"><a href="/roles/delete?id=<%=role.getId()%>"><img
					src="../img/deleteRole.png" width:="200px">Borrar Role</a></li>
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
		<h1 id="id" name="<%=role.getId()%>">Datos del Role:</h1>
		<table>
			<tr>
				<td>ID</td>
				<td><%=role.getId()%></td>
			</tr>
			<tr>
				<td>Nombre</td>
				<td><%=role.getName()%></td>
			</tr>
			<tr>
				<td>Creado</td>
				<td><%=role.getCreated()%></td>
			</tr>
			<tr>
				<td><b>Accesos</b></td>
			</tr>
			<%
				for (Access a : access) {
			%>
			<tr>
				<td><%=a.getResource()%></td>
				<td><%=a.isStatus()%></td>
			</tr>
			<%
				}
			%>
		</table>
		<p>
			<b>Importante</b> Si se borra un rol todos sus accesos tambien seran
			eliminados. <br>Tambien debera de asignar un nuevo rol a los
			usuarios con dicho rol
		</p>
	</div>
</body>
</html>