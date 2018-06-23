<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="models.Resource"%>
<%@page import="models.Role"%>
<%@page import="java.util.List"%>
<%
	List<Resource> rs = (List<Resource>) request.getAttribute("rsr");
%>
<%
	List<Role> roles = (List<Role>) request.getAttribute("roles");
%>
<%@page import="models.User"%>
<%
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
<title>Añadir Access</title>
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
		</ul>
	</div>
	<div id="table">
		<form action="/access/add" method="post">
			<h1>Añadir Access</h1>
			<label>Seleccionar Funcion: </label> <select name="url">
				<%
					for (Resource r : rs) {
				%>
				<option value="<%=r.getId()%>"><%=r.getUrl()%></option>
				<%
					}
				%>
			</select> <br> <br> <br> <label>Seleccionar Role: </label> <select
				name="rol">
				<%
					for (Role r : roles) {
				%>
				<option value="<%=r.getId()%>"><%=r.getName()%></option>
				<%
					}
				%>
			</select> <br> <br> <br> <label>Permitir</label> <input
				type="radio" name="is" value="true" id="si"><label for="si">Si</label>
			<input type="radio" name="is" value="false" id="no" checked><label
				for="no">No</label> <br> <br> <br> <input
				type="submit" value="Añadir">
		</form>
	</div>
</body>
</html>