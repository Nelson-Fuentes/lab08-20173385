<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="models.Role"%>
<%@page import="models.Access"%>
<%@page import="java.util.List"%>
<%@page import="models.User"%>
<%
	Role role = (Role) request.getAttribute("role");
	User log = (User) request.getAttribute("log");
%>
<%
	List<Role> roles = (List<Role>) request.getAttribute("roles");
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
				title="Cerrar Sesion"><img alt="Cerrar Sesi�n"
					src="../img/logout.png"><font color="black">Cerrar Sesion</font></a></li>
			<%
				} else {
			%>
			<li class="google"><a href="/users/login?url?=<%=url%>"
				title="Iniciar Sesion"><img alt="Iniciar Sesi�n"
					src="../img/login.png"><font color="black">Iniciar Sesion</font></a></li>
			<li class="google"><a href="/users/register?url?=<%=url%>"
				title="Registrarse"><img alt="Registrarse"
					src="../img/register.png"><font color="black">Registrarse</font></a></li>
			<%
				}
			%>
			<li class="user"><a href="/users" title="A�adir Usuario"><img
					alt="Lista de usuarios" src="../img/listUserBlanco.png" id="img">
					Ver otros Usuarios</a></li>
			<li class="user"><a href="/users/add" title="A�adir Usuario"><img
					alt="A�adir usuario" src="../img/addUserBlanco.png" id="img">
					A�adir Usuarios</a></li>
			<li class="role"><a href="/roles" title="Ver Roles"><img
					alt="A�adir usuario" src="../img/indexRol1.png" id="img"> Ver
					Roles</a></li>
			<li class="role"><a href="/roles/add" title="A�adir Rol"><img
					alt="A�adir usuario" src="../img/addRol.png" id="img"> A�adir
					Roles</a></li>
			<li class="role"><a href="/roles/edit?id=<%=role.getId()%>"><img
					src="../img/editRole.png" width:="200px">Editar Role</a></li>
			<li class="rsr"><a href="/resources" title="Ver Resources"><img
					alt="Ver Resources" src="../img/resource.png" id="img"> Ver
					Resources</a></li>
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
		<form action="/roles/delete" method="post">
			<label>Seleccionar Futuro Rol a asignar</label> <select name="rol">
				<%
					for (Role a : roles) {
						if (a.getId() != role.getId()) {
				%>
				<option value="<%=a.getId()%>"><%=a.getName()%></option>
				<%
					}
					}
				%>
			</select> <input type="hidden" name="id" value="<%=role.getId()%>"><br>
			<br> <br> <input type="submit"
				value="Eliminar y Reemplazar">
		</form>
		<p>
			<b>Importante</b> Si se borra un rol todos sus accesos tambien seran
			eliminados. <br>Tambien debera de asignar un nuevo rol a los
			usuarios con dicho rol
		</p>
	</div>
</body>
</html>